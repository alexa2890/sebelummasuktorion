import 'package:flutter/material.dart';
import 'package:flutter_login/pages/login/login_page_view_model.dart';
import 'package:flutter_login/pages/profile/profile_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerWidget {
  static const routeName = "/login-page";

  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(loginPageViewModelProvider);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () => _loginUsingGoogleClicked(vm, context),
            child: const Text("Google", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => _loginUsingFacebookClicked(vm, context),
            child: const Text("Facebook", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
          ),
          const SizedBox(height: 16),
          if (vm.isLoading) const CircularProgressIndicator(),
        ],
      ),
    );
  }

  void _loginUsingGoogleClicked(LoginPageViewModel vm, BuildContext context) async {
    final user = await vm.loginUsingGoogle();

    if (user == null) return;

    final args = ProfilePageArgs(name: user.displayName!, email: user.email);
    Navigator.of(context).pushReplacementNamed(ProfilePage.routeName, arguments: args);
  }

  void _loginUsingFacebookClicked(LoginPageViewModel vm, BuildContext context) async {
    final userData = await vm.loginUsingFacebook();

    final args = ProfilePageArgs(name: userData["name"], email: userData["email"]);
    Navigator.of(context).pushReplacementNamed(ProfilePage.routeName, arguments: args);
  }
}
