import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:serieso/application/models/models.dart';
import 'package:serieso/application/services/seo_service_fireauth.dart';
import 'package:serieso/application/services/seo_service_firestore.dart';
import 'package:serieso/application/services/seo_service_locator.dart';

class SeoPageProfileVM extends ChangeNotifier {
  final Size size;

  // Flags
  bool _loading = true;
  bool _error = false;
  String _errorMessage = "";
  bool _isStartup = false;
  bool _showRegisterOption = false;

  late SeoModelUser _userData;
  SeoModelStartupRegisterRequest? _startupData;
  late final User? _firebaseUser;
  late final GlobalKey<ScaffoldState> _scaffoldKey;

  SeoPageProfileVM({required this.size}) {
    // Get the user id from firebase auth.
    _firebaseUser = locator.get<SeoFireAuthService>().currentUser;
    _scaffoldKey = GlobalKey(debugLabel: "KeyProfilePage");
    fetchUserDetails();
  }

  SeoModelUser get user => _userData;
  bool get loading => _loading;
  bool get error => _error;
  String get errorMessage => _errorMessage;
  bool get showStartupForm => _isStartup;
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
  SeoModelStartupRegisterRequest? get startupData => _startupData;
  bool get showRegisterOption => _showRegisterOption;

  // Get Status Message based on Startup form status
  String getStatusMessage() {
    switch (_startupData!.requestStatus) {
      case StartupRegistrationStatus.submitted:
        return "Thanks for registering with us. While we've received your application it might take us a while to start reviewing it. Sit back and plan ahead while we do our part.";
      case StartupRegistrationStatus.reviewing:
        return "We’ve received your application and our team is reviewing it. Once done we’ll get back to you with an update.";
      case StartupRegistrationStatus.accepted:
        return "Congratulations!! You must've received an email stating the next step. Great things awaits you for sure.";
      case StartupRegistrationStatus.declined:
        return "After reviewing your application we're sorry to inform you that we cannot proceed further. Please reach out to us in case of any questions or query.";
    }
  }

  // Fetch the user model from firebase collection.
  void fetchUserDetails() async {
    try {
      _loading = true;
      notifyListeners();

      _userData = await locator
          .get<SeoFirestoreService>()
          .getPlatformUser(_firebaseUser!.uid);

      _isStartup = (_userData.role.name == UserRole.startup.name);

      if (_isStartup) {
        if (_userData.startupID == null) {
          _loading = false;
          _showRegisterOption = true;
          notifyListeners();
          return;
        }
        _fetchStartupDetails();
      }
    } on Exception catch (e) {
      _error = true;
      _errorMessage = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  void _fetchStartupDetails() async {
    try {
      _loading = true;
      notifyListeners();

      if (_userData.startupID == null) {
        return;
      }

      _startupData = await locator
          .get<SeoFirestoreService>()
          .getStartupRegistrationRequest(_userData.startupID!);

      _loading = false;
      notifyListeners();
    } on Exception catch (e) {
      _error = true;
      _errorMessage = e.toString();
    }
  }

  void logout() {
    try {
      locator.get<SeoFireAuthService>().logout();
    } catch (e) {
      log(e.toString());
    }
  }

  void reload(String? startupID) {
    if (startupID != null) {
      _showRegisterOption = false;
      notifyListeners();
    }
  }
}
