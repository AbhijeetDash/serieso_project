import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:serieso/application/models/models.dart';
import 'package:serieso/application/services/seo_service_firestore.dart';
import 'package:serieso/application/services/seo_service_locator.dart';
import 'package:serieso/application/services/seo_service_navigation.dart';

abstract class SeoFireAuthService {
  Future<void> registerAuthListener();

  Future<String?> signUpWithEmailPassword(String email, String password);

  Future<String> loginWithEmailPassword({
    required String email,
    required String password,
  });

  Future<void> logout();

  User? get currentUser;
}

class SeoFireAuthServiceImpl extends SeoFireAuthService {
  static final SeoFirestoreService _service =
      locator.get<SeoFirestoreService>();

  @override
  Future<String?> signUpWithEmailPassword(
    String email,
    String password,
  ) async {
    try {
      // complete the signup process.
      UserCredential creds =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Creating the user object in users.
      return creds.user!.uid;
      // On catch
    } on FirebaseAuthException catch (e) {
      log("$e");
      rethrow;
    }
  }

  @override
  Future<void> registerAuthListener() async {
    log("[AuthStateChange] : Function Called");
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      log("[AuthStateChange] : $user");
      if (user == null) {
        // Go to the home page
        SeoNavigationService.navigatorKey.currentState
            ?.pushReplacementNamed("/welcome");
      } else {
        // Go to User Profile page automatically
        SeoNavigationService.navigatorKey.currentState!
            .pushReplacementNamed("/userProfile");
      }
    });
  }

  @override
  Future<String> loginWithEmailPassword(
      {required String email, required String password}) async {
    try {
      UserCredential creds =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return creds.user!.uid;
    } on FirebaseAuthException catch (e) {
      log("$e");
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      SeoNavigationService.navigatorKey.currentState
          ?.popAndPushNamed("/welcome");
    } catch (e) {
      throw Exception("$e");
    }
  }

  @override
  User? get currentUser => FirebaseAuth.instance.currentUser;
}
