import 'package:flutter/material.dart';
import 'package:serieso/application/components/_seo_component_end_drawer.dart';
import 'package:serieso/application/components/input_components/_seo_component_material_button.dart';
import 'package:serieso/application/constants/_seo_const_brandcolors.dart';
import 'package:serieso/application/forms/form_login/form_login.dart';
import 'package:serieso/application/forms/form_signup/form_signup.dart';
import 'package:serieso/application/services/seo_service_fireauth.dart';
import 'package:serieso/application/services/seo_service_locator.dart';
import 'package:serieso/application/views/_seo_view_landing_sectionone.dart';

class SeoPageLanding extends StatefulWidget {
  static String routeName = "/welcome";
  const SeoPageLanding({Key? key}) : super(key: key);

  @override
  State<SeoPageLanding> createState() => _SeoPageLandingState();
}

class _SeoPageLandingState extends State<SeoPageLanding> {
  late Size size;
  late bool isLoginForm;
  late GlobalKey<ScaffoldState> scaffoldKey;

  void registerUserSignupLoginListener() {
    // Register auth listener
    locator.get<SeoFireAuthService>().registerAuthListener();
  }

  @override
  void initState() {
    isLoginForm = false;
    scaffoldKey = GlobalKey<ScaffoldState>(debugLabel: "KeyLandingScaffold");
    super.initState();
  }

  @override
  void didChangeDependencies() {
    size = MediaQuery.sizeOf(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: BrandColors.colorScaffold,
      endDrawer: SeoEndDrawer(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Signup Form.
            isLoginForm ? const SeoFormSignup() : const SeoFormLogin(),
            // Login button should not be part of the Signup Form.
            _switchFormSection()
          ],
        ),
      ),
      body: SizedBox(
        height: size.height * 2,
        child: ListView(
          children: [
            SeoLandingSectionOne(
              scaffoldKey: scaffoldKey,
            ),
          ],
        ),
      ),
    );
  }

  Widget _switchFormSection() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 20.0),
        const Text(
          " -- OR -- ",
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(height: 20.0),
        SeoRawMaterialButton(
          onPressed: () {
            isLoginForm = !isLoginForm;
            setState(() {});
          },
          child: Text(
            isLoginForm ? "Login" : "Signup",
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
