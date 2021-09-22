import 'package:carefinderclient/Pages/Splash.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'pages/Root.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    final swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    strengths.forEach((strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    });
    return MaterialColor(color.value, swatch);
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Carefinder',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        primarySwatch: createMaterialColor(Color(0xfff05e56)),
        brightness: Brightness.light,
        textTheme: TextTheme(
          headline2: TextStyle(color: Colors.black, fontSize: 40.0),
          headline3: TextStyle(color: Colors.black, fontSize: 32.0),
          headline4: TextStyle(color: Colors.grey[700], fontSize: 18.0),
          headline5: TextStyle(color: Colors.grey[800], fontSize: 18.0, fontWeight: FontWeight.w700),
          headline6: TextStyle(color: Colors.grey[800], fontSize: 13.0, fontWeight: FontWeight.w700),
          bodyText2: TextStyle(color: Colors.grey[900], fontSize: 16.0, fontWeight: FontWeight.w700),
          bodyText1: TextStyle(color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.w700),
          subtitle1: TextStyle(color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.w700),
          subtitle2: TextStyle(color: Colors.grey[900], fontSize: 13.0),
          caption: TextStyle(color: Colors.grey[700], fontSize: 11.0, letterSpacing: 0.5),
          overline: TextStyle(color: Colors.grey[700], fontSize: 11.0, letterSpacing: 1.2, fontWeight: FontWeight.w600),
          button: TextStyle(color: Colors.black, fontSize: 14.0),
        ),
        canvasColor: Colors.white,
        dividerColor: Colors.grey[500],
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: AppBarTheme(
            color: Color.fromRGBO(234, 234, 234, 0.8),
            elevation: 0.0,
            iconTheme: IconThemeData(
                color: Colors.grey[800]
            ),
            actionsIconTheme: IconThemeData(
                color: Colors.grey[800]
            )
        ),
      ),
      home: Splash()
    );
  }
}

