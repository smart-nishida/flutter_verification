import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_verification/main.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

void main() {
  testGoldens("app", (WidgetTester tester) async {
    // pubspecに記載したフォントの読込み
    await loadAppFonts();

    // 複数の解像度でスクリーンショットをビルドする
    await tester.pumpWidgetBuilder(MyApp());

    await multiScreenGolden(
      tester,
      'myApp',
      devices: [
        /// 配列で複数解像度を追加していく
        /// 縦横のサイズはロジカルピクセルっぽい
        const Device(
          name: '9_16', //9:16
          // size: Size(360, 640),
          size: Size(375.0, 619.0), //エミュレータでMediaQueryから取得した論理ピクセル
        ),
        const Device(
          name: '9_19.5', //9:19.5
          // size: Size(360, 780),
          size: Size(414.0, 848.0), //エミュレータでMediaQueryから取得した論理ピクセル
        ),
        const Device(
          name: '9_20', //9:20
          size: Size(360, 752), //エミュレータでMediaQueryから取得した論理ピクセル
        ),
      ],
    );

    // マスターのスクリーンショットと現在のスクリーンショットと同じかテストする。第二引数は生成されるスクリーンショットのファイル名
    await screenMatchesGolden(tester, "myApp");
  });

}
