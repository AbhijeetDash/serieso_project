import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:serieso/application/services/seo_service_fireauth.dart';
import 'package:serieso/application/services/seo_service_locator.dart';

import '../../services/seo_service_navigation.dart';

class SeoFormLoginVM extends ChangeNotifier {
  bool _isLoading = false;
  bool _hasError = false;
  String _errorMessage = "";

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;

  final GlobalKey _formState = GlobalKey<FormState>();

  // Managing the focus of the form.
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _loginBtnFocus = FocusNode();

  // Focus getter
  FocusNode get emailFocus => _emailFocus;
  FocusNode get passwordFocus => _passwordFocus;
  FocusNode get loginBtnFocus => _loginBtnFocus;

  GlobalKey get formKey => _formState;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  String get errorMessage => _errorMessage;

  String? validatorEmail(String? value) {
    if (value!.isEmpty || !value.isEmail) return "Please check email again";
    return null;
  }

  Future<void> login() async {
    _isLoading = true;
    notifyListeners();

    try {
      await locator.get<SeoFireAuthService>().loginWithEmailPassword(
          email: _emailController.text, password: _passwordController.text);
      SeoNavigationService.navigatorKey.currentState!
          .pushReplacementNamed("/userProfile");

      // Updating the UI
      _hasError = false;
      _isLoading = false;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      // Updating the UI
      _hasError = true;
      _isLoading = false;
      _errorMessage = e.message!;
      notifyListeners();
    } finally {
      // Because the overlay takes 2 seconds.
      Timer(const Duration(seconds: 2), () {
        _hasError = false;
        notifyListeners();
      });
    }
  }
}
