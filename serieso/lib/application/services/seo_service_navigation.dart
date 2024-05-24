import 'package:flutter/material.dart';
import 'package:serieso/application/pages/seo_page_landing/seo_page_landing.dart';
import 'package:serieso/application/pages/seo_page_profile/seo_page_profile.dart';

abstract class SeoNavigationService {
  // global navigation scaffold
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static final routes = {
    "/welcome": (context) => const SeoPageLanding(),
    "/userProfile": (context) => const SeoPageProfile(),
  };

  /// Opens drawer on home screen.
  void openDrawer(GlobalKey<ScaffoldState> scaffoldKey);
}

class SeoNavigationServiceImpl extends SeoNavigationService {
  @override
  void openDrawer(GlobalKey<ScaffoldState> scaffoldKey) {
    scaffoldKey.currentState!.openEndDrawer();
  }
}
