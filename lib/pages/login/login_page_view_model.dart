import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_login/services/google_sign_in_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

final loginPageViewModelProvider = ChangeNotifierProvider<LoginPageViewModel>((ref) {
  return LoginPageViewModel();
});

class LoginPageViewModel with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void _startLoading() {
    _isLoading = true;
    notifyListeners();
  }

  void _stopLoading() {
    _isLoading = false;
    notifyListeners();
  }

  Future<GoogleSignInAccount?> loginUsingGoogle() async {
    _startLoading();
    try {
      final user = await GoogleSignInService().login();
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool("hasLoggedIn", true);

      return user;
    } catch (error) {
      debugPrint(error.toString());
    } finally {
      _stopLoading();
    }
  }

  Future<Map<String, dynamic>> loginUsingFacebook() async {
    _startLoading();
    try {
      final facebookAuth = FacebookAuth.instance;

      final LoginResult result = await facebookAuth.login(
        permissions: ['public_profile', 'email'],
      );

      if (result.status == LoginStatus.success) {
        final userData = await facebookAuth.getUserData();

        final prefs = await SharedPreferences.getInstance();
        prefs.setBool("hasLoggedIn", true);

        return userData;
      } else {
        debugPrint(result.status.toString());
        debugPrint(result.message);
        throw Exception(result.message);
      }
    } catch (error) {
      debugPrint(error.toString());
      throw Exception(error.toString());
    } finally {
      _stopLoading();
    }
  }
}
