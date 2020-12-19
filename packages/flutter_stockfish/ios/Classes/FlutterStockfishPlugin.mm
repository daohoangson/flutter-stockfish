#import "FlutterStockfishPlugin.h"
#import "flutter_stockfish.h"

@implementation FlutterStockfishPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"flutter_stockfish"
            binaryMessenger:[registrar messenger]];
  FlutterStockfishPlugin* instance = [[FlutterStockfishPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  } else {
    if (call == NULL) {
      // avoid stripping
      stockfish_init();
      stockfish_trace_eval();
      stockfish_uci(NULL);
    }

    result(FlutterMethodNotImplemented);
  }
}

@end
