import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_login/pages/login/login_page.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePageArgs {
  final String name;
  final String email;

  ProfilePageArgs({required this.name, required this.email});
}

class ProfilePage extends StatelessWidget {
  static const routeName = "/profile-page";

  final ProfilePageArgs args;

  const ProfilePage({required this.args, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _logOutIconClicked(context),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(args.name),
          const SizedBox(height: 32),
          Text(args.email),
        ],
      ),
    );
  }

  void _logOutIconClicked(BuildContext context) async {
    Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
    performLogOut();
  }

  Future<void> performLogOut() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool("hasLoggedIn", false);

      GoogleSignIn().signOut();
      FacebookAuth.instance.logOut();
    } catch (error) {
      debugPrint(error.toString());
    }
  }
}
