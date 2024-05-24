import 'package:get_it/get_it.dart';
import 'package:serieso/application/services/seo_service_filepicker.dart';
import 'package:serieso/application/services/seo_service_fireauth.dart';
import 'package:serieso/application/services/seo_service_firestore.dart';
import 'package:serieso/application/services/seo_service_navigation.dart';
import 'package:serieso/application/services/seo_service_shared_prefs.dart';

final locator = GetIt.instance;

class SeoLocatorService {
  static void setupLocator() {
    final SeoNavigationService seoApplicationRoutes =
        SeoNavigationServiceImpl();
    final SeoFileService seoFileService = SeoFileServiceImpl();
    final SeoFireAuthService seoFireAuthService = SeoFireAuthServiceImpl();
    final SeoFirestoreService seoFirestoreService = SeoFirestoreServiceImpl();
    final SeoSharedPrefsService seoSharedPrefsService =
        SeoSharedPrefsServiceImpl();

    locator.registerSingleton<SeoNavigationService>(seoApplicationRoutes);
    locator.registerSingleton<SeoFirestoreService>(seoFirestoreService);
    locator.registerSingleton<SeoFireAuthService>(seoFireAuthService);
    locator.registerSingleton<SeoFileService>(seoFileService);
    locator.registerSingleton<SeoSharedPrefsService>(seoSharedPrefsService);
  }
}
