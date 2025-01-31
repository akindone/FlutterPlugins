import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:doraemonkit_csx/doraemonkit_csx.dart';

void main() {
  const MethodChannel channel = MethodChannel('doraemonkit_csx');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await DoraemonkitCsx.platformVersion, '42');
  });
}
