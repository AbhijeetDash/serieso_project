import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:serieso/application/constants/_seo_const_brandcolors.dart';
import 'package:serieso/application/services/seo_service_navigation.dart';

class SeoMaterialApp extends StatefulWidget {
  const SeoMaterialApp({super.key});

  @override
  State<SeoMaterialApp> createState() => _SeoMaterialAppState();
}

class _SeoMaterialAppState extends State<SeoMaterialApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: "Serieso Investment",
      theme: ThemeData(fontFamily: "Inter"),
      routes: SeoNavigationService.routes,
      navigatorKey: SeoNavigationService.navigatorKey,
      initialRoute: "/welcome",
      builder: (context, child) => ResponsiveWrapper.builder(
        child,
        maxWidth: 2560,
        minWidth: 250,
        defaultScale: false,
        breakpoints: const [
          ResponsiveBreakpoint.autoScaleDown(300, name: MOBILE),
          ResponsiveBreakpoint.autoScaleDown(800, name: TABLET),
          ResponsiveBreakpoint.autoScaleDown(1200, name: DESKTOP),
          ResponsiveBreakpoint.autoScaleDown(1800, name: DESKTOP),
          ResponsiveBreakpoint.autoScale(2560, name: 'XL'),
        ],
        background: Container(
          color: Color(BrandColors.colorScaffold.value),
        ),
      ),
    );
  }
}
