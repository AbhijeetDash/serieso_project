import 'package:flutter/material.dart';
import 'package:serieso/application/components/_seo_component_snackbar.dart';

extension SeoContext on BuildContext {
  void showSeoDialog() {
    showDialog(
      context: this,
      builder: (context) {
        return const AboutDialog();
      },
    );
  }

  void showErrorOverlay(String message) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      SeoComponentSnackBar.showSeoSnackBar(
        this,
        SeoSnackBarContent(message: message),
      );
    });
  }
}

extension SeoString on String {
  bool get isEmail {
    return contains("@");
  }
}
