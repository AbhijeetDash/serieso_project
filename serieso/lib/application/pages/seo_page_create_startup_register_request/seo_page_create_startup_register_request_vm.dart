import 'package:flutter/material.dart';
import 'package:serieso/application/models/models.dart';

class SeoPageCreateStartupRegisterRequestVM extends ChangeNotifier {
  final SeoModelUser userData;
  SeoPageCreateStartupRegisterRequestVM({
    required this.userData,
  });

  String get uid => userData.id;
}
