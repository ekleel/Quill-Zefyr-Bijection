import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:zefyr_quill/HomePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  /// Ensures channels are initialized.
  WidgetsFlutterBinding.ensureInitialized();

  // RendererBinding.instance.initPersistentFrameCallback();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      locale: kLocale,
      supportedLocales: kSupportedLocales,
      localizationsDelegates: kLocalizationsDelegates,
      // others
      debugShowCheckedModeBanner: false,
    );
  }
}

/// Sets delegates
const kLocalizationsDelegates = [
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
  DefaultCupertinoLocalizations.delegate,
];

/// Sets local
const kLocale = Locale('ar', 'SA');

/// Sets supported local
const kSupportedLocales = [
  Locale('ar', 'SA'),
];
