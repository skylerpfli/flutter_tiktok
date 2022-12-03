import 'package:flutter/services.dart';
import 'package:flutter_conch_plugin/annotation/conch_scope.dart';
import 'package:flutter_conch_plugin/conch_dispatch.dart';
import 'package:flutter_tiktok/pages/homePage.dart';
import 'package:flutter_tiktok/style/style.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

bool useConch = true;

@ConchScope()
void main() async {
  /// 自定义报错页面
  if (kReleaseMode) {
    ErrorWidget.builder = (FlutterErrorDetails flutterErrorDetails) {
      debugPrint(flutterErrorDetails.toString());
      return Material(
        child: Center(
            child: Text(
          "发生了没有处理的错误\n请通知开发者",
          textAlign: TextAlign.center,
        )),
      );
    };
  }

  WidgetsFlutterBinding.ensureInitialized();
  if(useConch){
    var source = await rootBundle.loadString('assets/conch_data/conch_result.json');
    ConchDispatch.instance.loadSource(source);
    return await ConchDispatch.instance.callStaticFun(library: 'package:flutter_tiktok/main.dart', funcName: 'mainInner');
  }

  mainInner();
}

mainInner(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Tiktok',
      theme: ThemeData(
        brightness: Brightness.dark,
        hintColor: Colors.white,
        accentColor: Colors.white,
        primaryColor: ColorPlate.orange,
        primaryColorBrightness: Brightness.dark,
        scaffoldBackgroundColor: ColorPlate.back1,
        dialogBackgroundColor: ColorPlate.back2,
        accentColorBrightness: Brightness.light,
        textTheme: TextTheme(
          bodyText1: StandardTextStyle.normal,
        ),
      ),
      home: HomePage(),
    );
  }
}
