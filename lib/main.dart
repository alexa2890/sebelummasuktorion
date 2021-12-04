import 'package:flutter/material.dart';
import 'package:flutter_login/pages/login/login_page.dart';
import 'package:flutter_login/route_generator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*

GOOGLE SIGN IN HARUS PAKAI FIREBASE, Terutama untuk aplikasi iOS



 */

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final bool hasLoggedIn = prefs.getBool("hasLoggedIn") ?? false;

  runApp(
    ProviderScope(
      child: MyApp(hasLoggedIn: hasLoggedIn),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool hasLoggedIn;

  const MyApp({required this.hasLoggedIn, Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
