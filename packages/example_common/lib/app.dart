import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_stockfish/flutter_stockfish.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final stockfish = Stockfish.instance;

  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String platformVersion;
    try {
      platformVersion = await FlutterStockfish.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Stockfish Example'),
        ),
        body: Column(
          children: [
            Expanded(
              child: Center(
                child: AnimatedBuilder(
                  animation: stockfish.state,
                  builder: (_, __) =>
                      Text('${stockfish.state.value} on $_platformVersion\n'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () async {
                  final result = await stockfish.traceEval();
                  print('traceEval=$result');
                },
                child: Text('traceEval'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
