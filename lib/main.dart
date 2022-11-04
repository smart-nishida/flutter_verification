import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// class _MyHomePageState2 extends State<MyHomePage> {
//
//   @override
//   Widget build(BuildContext context) {
//     final Size size = MediaQuery.of(context).size;
//     print("size.height: ${size.height}");
//     print("size.width: ${size.width}");
//
//     return ScreenUtilInit(
//       designSize: const Size(375, 812),
//       builder: (context, child) => AspectRatio(
//         aspectRatio: 9/19.5,
//         child: Scaffold(
//           appBar: AppBar(
//             title: Text(widget.title),
//           ),
//           body: Center(
//             child: Column(
//               // crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Container(
//                   height: 0.5.sh,
//                   color: Colors.red,
//                   child: Text("3×1=", style: TextStyle(fontSize: 40.sp),),
//                 ),
//                 Container(
//                   height: 0.393.sh,
//                   color: Colors.blueGrey,
//                   child: Text("てすとa"),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  final _key = GlobalKey();
  Size containerSize = Size(0, 0);

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      setState(() {
        containerSize = _key.currentContext!.size!;
      });
      print("AspectRatio直下のコンテナのサイズは height: ${containerSize!.height} width: ${containerSize!.width}");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    print("画面全体のサイズは height: $height width: $width");

    return Container(
      color: Colors.white,
      child: Center(
        child: AspectRatio(
          /// 9:19.5扱いのiPhone11
          // aspectRatio: 9/19.5, // 9:19.5だと横幅が空いてしまう
          // aspectRatio: 414.0/848.0, // MediaQueryで取得したその端末の実際の縦、横サイズで指定するとサイズはちょうど収まる → 厳密には9:19.5ではなく、おおよそ9:19.5ということっぽい
          /// 9:19扱いのPixel4XL
          // aspectRatio: 9/19, // 9:19だと横幅が空いてしまう
          // aspectRatio: 411.42857142857144/820.5714285714286, // MediaQueryで取得したその端末の実際の縦、横サイズで指定するとサイズはちょうど収まる → 厳密には9:19ではなく、おおよそ9:19ということっぽい
          /// 9:20扱いのPixel5a
          aspectRatio: 9/20, // 9:20だと横幅が空いてしまう // MediaQueryで取得したその端末の実際の縦、横サイズで指定するとサイズはちょうど収まる
          // aspectRatio: 360.0/752.0, // MediaQueryで取得した縦、横サイズで指定するとサイズはちょうど収まる 厳密にはMediaQueryで取得した縦横の長さが正しくて、ネットとかの仕様での9:20、1080x2400はアバウトな数値っぽい
          child: Scaffold(
            appBar: AppBar(
              title: Text(widget.title),
            ),
            body: Container(
                key: _key, // このコンテナの縦横の長さを把握するために使用
                color: Colors.grey,
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        height: containerSize!.height * 0.5,
                        width: containerSize!.width * 0.5,
                        color: Colors.cyanAccent,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Text(
                                'You have pushed the button this many times:',
                              ),
                              Text(
                                '$_counter',
                                style: Theme.of(context).textTheme.headline4,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: containerSize!.height * 0.5,
                        width: containerSize!.width * 0.3,
                        color: Colors.red,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Text(
                                'You have pushed the button this many times:',
                              ),
                              Text(
                                '$_counter',
                                style: Theme.of(context).textTheme.headline4,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            floatingActionButton: FloatingActionButton(
              onPressed: _incrementCounter,
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
          ),
        ),
      ),
    );
  }
}
