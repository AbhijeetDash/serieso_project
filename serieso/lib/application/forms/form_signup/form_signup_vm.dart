import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:serieso/application/extensions/seo_context_extension.dart';
import 'package:serieso/application/models/models.dart';
import 'package:serieso/application/services/seo_service_exception.dart';
import 'package:serieso/application/services/seo_service_fireauth.dart';
import 'package:serieso/application/services/seo_service_firestore.dart';
import 'package:serieso/application/services/seo_service_locator.dart';
import 'package:serieso/application/services/seo_service_navigation.dart';

/// The VM is supposed to keep track of all the data.

class SeoFormSignupVM extends ChangeNotifier {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _conPassController = TextEditingController();

  // getters for above.
  TextEditingController get emailController => _emailController;
  TextEditingController get firstNameController => _firstNameController;
  TextEditingController get lastNameController => _lastNameController;
  TextEditingController get phoneNumberController => _phoneNumberController;
  TextEditingController get passController => _passController;
  TextEditingController get conPassController => _conPassController;

  // Managing the focus of the form.
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _firstNameFocus = FocusNode();
  final FocusNode _lastNameFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _passwordConfirmFocus = FocusNode();
  final FocusNode _continueButtonFocus = FocusNode();
  final FocusNode _signupBtnFocus = FocusNode();
  final FocusNode _phoneNumberFocus = FocusNode();

  FocusNode get emailFocus => _emailFocus;

  FocusNode get firstNameFocus => _firstNameFocus;

  FocusNode get lastNameFocus => _lastNameFocus;

  FocusNode get passwordFocus => _passwordFocus;

  FocusNode get passwordConfirmFocus => _passwordConfirmFocus;

  FocusNode get signupBtnFocus => _signupBtnFocus;

  FocusNode get continueButtonFocus => _continueButtonFocus;

  FocusNode get phoneNumberFocus => _phoneNumberFocus;

  /// This Dart code defines a class with methods and variables for handling user registration and form
  /// validation.
  ///
  /// Args:
  ///   value (String): The "value" parameter is a variable that represents the current value of a form
  /// field. It is used in the validator functions to check if the entered value is valid or not.
  final GlobalKey<FormState> stageOneFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> stageTwoFormKey = GlobalKey<FormState>();

  late String _userEmail;
  late String _userPassword;
  late String _userFirstName;
  late String _userLastName;
  late String _userPhoneNumber;
  late UserRole _userProfileSelection;
  late String _userPasswordConfirm;

  bool _showLoading = false, _hasError = false;
  int selectionIndex = 0;
  String _errorMessage = "";

  /// Getters for email and password.
  String get getUserEmail => _userEmail;
  String get getUserPassword => _userPassword;
  String get getUserFirstName => _userFirstName;
  String get getUserLastName => _userLastName;
  String get errorMessage => _errorMessage;

  bool get showLoadingIndicator => _showLoading;
  bool get hasError => _hasError;

  int _stageIndex = 0;

  /// Setters for email and password.
  set userEmail(String value) {
    if (value == _userEmail) {
      return;
    }

    _userEmail = value;
  }

  set userPhoneNumber(String value) {
    if (value == _userPhoneNumber) {
      return;
    }

    _userPhoneNumber = value;
  }

  set userPassword(String value) {
    if (value == _userPassword) {
      return;
    }

    _userPassword = value;
  }

  set firstName(String value) {
    if (value == _userFirstName) {
      return;
    }

    _userFirstName = value;
  }

  set lastName(String value) {
    if (value == _userLastName) {
      return;
    }

    _userLastName = value;
  }

  set userProfileSelection(UserRole value) {
    if (value == _userProfileSelection) {
      return;
    }

    _userProfileSelection = value;
  }

  int get getStageIndex => _stageIndex;

  /// The above code contains a set of validation functions for different input fields such as email,
  /// first name, last name, password, confirm password, and phone number.
  ///
  /// Args:
  ///   value (String): The "value" parameter represents the input value that needs to be validated. It
  /// can be a string value representing various user inputs such as email, first name, last name,
  /// password, confirm password, or phone number.
  ///
  /// Returns:
  ///   The code is returning a string message if the input value does not meet the validation criteria,
  /// and it returns null if the input value is valid.
  String? validatorEmail(String? value) {
    if (value!.isEmpty || !value.isEmail) return "Please check email again";
    return null;
  }

  String? validatorFirstName(String? value) {
    if (value!.isEmpty) return "Please enter first name";
    return null;
  }

  String? validatorLastName(String? value) {
    if (value!.isEmpty) return "Please enter a value";
    return null;
  }

  String? validatorPassword(String? value) {
    if (value!.isEmpty) return "Password cannot be empty";
    _userPasswordConfirm = value;
    return null;
  }

  String? validatorConfirmPassword(String? value) {
    if (value!.isEmpty) return "Password cannot be empty";
    if (value != _userPasswordConfirm) return "Passwords are different.";
    return null;
  }

  String? validatorPhoneNumber(String? value) {
    if (value!.isEmpty) return "Phone number is required";
    return null;
  }

  /// The function sets the values of the user's first name, last name, email, and phone number, validates
  /// the form, updates the stage index, adds the data to a model, and notifies listeners.
  ///
  /// Args:
  ///   firstName (String): The first name of the user.
  ///   lastName (String): The `lastName` parameter is a `String` that represents the last name of the
  /// user.
  ///   email (String): A string representing the user's email address.
  ///   phoneNumber (String): The `phoneNumber` parameter is a `String` that represents the user's phone
  /// number.
  void setStageOneValues(
    String firstName,
    String lastName,
    String email,
    String phoneNumber,
  ) {
    if (stageOneFormKey.currentState!.validate()) {
      // first set the values.
      _userFirstName = firstName;
      _userLastName = lastName;
      _userEmail = email;
      _userPhoneNumber = phoneNumber;

      _stageIndex = 1;

      // Also add the data to model.
      // Send the model to firebase.
      notifyListeners();
    }
  }

  /// The function sets the values for the user's profile selection, password, and password confirmation,
  /// and then proceeds with the signup process if the form is valid.
  ///
  /// Args:
  ///   password (String): The password parameter is a string that represents the user's chosen password
  /// for their account.
  ///   confirmPassword (String): The `confirmPassword` parameter is a string that represents the user's
  /// confirmation of their password. It is used to ensure that the user has entered the same password
  /// correctly twice during the signup process.
  void setStageTwoValues(String password, String confirmPassword) async {
    if (stageTwoFormKey.currentState!.validate()) {
      _userProfileSelection =
          selectionIndex == 0 ? UserRole.investor : UserRole.startup;
      _userPassword = password;
      _userPasswordConfirm = confirmPassword;

      try {
        final SeoFirestoreService service = locator.get<SeoFirestoreService>();

        _showLoading = true;
        notifyListeners();

        // Build User object and complete the signup process.
        String? uid =
            await locator.get<SeoFireAuthService>().signUpWithEmailPassword(
                  _userEmail,
                  password,
                );

        if (uid == null) {
          _clearInputFields();

          throw SeoException(
            message: "Cannot Authorize User",
            exceptionType: SeoExceptionType.firebaseAuthException,
            errorCode: 01,
          );
        }

        // Create the User Object in seo_users collection
        if (!(await _checkIfPhoneNumberExists(_phoneNumberController.text))) {
          // add phone number
          await service.addPhoneNumber(_phoneNumberController.text, uid);

          await service.createPlatformUser(_getSeoUserObject(uid));

          _autoLoginUserOnSignup(_emailController.text, _passController.text);

          _clearInputFields();

          _showLoading = false;
          notifyListeners();

          // Navigate to Profile Page
          SeoNavigationService.navigatorKey.currentState!
              .pushReplacementNamed("/userProfile");
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          _errorMessage = 'password provided is too weak.';
        } else if (e.code == 'email-already-in-use') {
          _errorMessage = 'The account already exists for that email.';
        }
        // Updating the UI
        _hasError = true;
        _errorMessage = e.message!;
        notifyListeners();
        _showLoading = false;
        notifyListeners();
        rethrow;
      }
    }
  }

  void _autoLoginUserOnSignup(String email, String password) {
    try {
      locator
          .get<SeoFireAuthService>()
          .loginWithEmailPassword(email: email, password: password);
    } catch (e) {
      log("$e");
      _showLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  SeoModelUser _getSeoUserObject(String uid) {
    return SeoModelUser(
      id: uid,
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      email: _emailController.text,
      phoneNumber: _phoneNumberController.text,
      role: _userProfileSelection,
    );
  }

  void _clearInputFields() {
    _emailController.text = "";
    _firstNameController.text = "";
    _lastNameController.text = "";
    _phoneNumberController.text = "";
    _passController.text = "";
    _conPassController.text = "";
  }

  /// The function `changeGroupSelection` toggles the value of `selectionIndex` between 0 and 1 and
  /// notifies listeners of the change.
  void changeGroupSelection() {
    selectionIndex = selectionIndex == 0 ? 1 : 0;
    notifyListeners();
  }

  Future<bool> _checkIfPhoneNumberExists(String phoneNumber) async {
    try {
      return await locator
          .get<SeoFirestoreService>()
          .checkPhoneNumber(phoneNumber);
    } catch (e) {
      rethrow;
    }
  }
}
