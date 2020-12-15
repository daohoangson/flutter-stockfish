import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:ffi/ffi.dart';
import 'package:flutter/foundation.dart';

class Stockfish {
  final state = ValueNotifier(StockfishState.starting);

  Stockfish._() {
    compute(_initCallback, null).then(
      (_) => state.value = StockfishState.ready,
      onError: (_) => state.value = StockfishState.error,
    );
  }

  Future<String> traceEval() => compute(_traceEvalCallback, null);

  static Stockfish _instance;
  static Stockfish get instance => _instance ??= Stockfish._();
}

enum StockfishState {
  error,
  ready,
  starting,
}

final _lib = Platform.isAndroid
    ? DynamicLibrary.open('libstockfish.so')
    : DynamicLibrary.process();

Future<void> _initCallback(Null _) async => _initNative();

final void Function() _initNative =
    _lib.lookup<NativeFunction<Void Function()>>('stockfish_init').asFunction();

Future<String> _traceEvalCallback(Null _) async {
  final pointer = _traceEvalNative();
  final string = Utf8.fromUtf8(pointer);
  free(pointer);

  return string;
}

final Pointer<Utf8> Function() _traceEvalNative = _lib
    .lookup<NativeFunction<Pointer<Utf8> Function()>>('stockfish_trace_eval')
    .asFunction();
