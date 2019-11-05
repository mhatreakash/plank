import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:plank/blocs/themeChanger.dart';
import 'package:plank/screens/loginPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeChanger>(
      builder: (_) => ThemeChanger(ThemeData.light()),
      child: MaterialAppWithTheme(),
    );
  }
}

class MaterialAppWithTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    return MaterialApp(
      title: "plank",
      debugShowCheckedModeBanner: false,
      home: Login(),
      theme: theme.getTheme(),
    );
  }
}

// Mostly Used Components
//  color: Color(0xFFB33771)
//Android-X error
// For Android-X error use multiDexEnabled true in app(build.gradle) defaultConfig {}
// android.useAndroidX=true, android.enable Jetifier=true in gradle.properties
