import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serieso/application/components/decoration_components/_seo_component_container.dart';
import 'package:serieso/application/components/decoration_components/_seo_decoration_background_circles.dart';
import 'package:serieso/application/components/input_components/_seo_component_material_button.dart';
import 'package:serieso/application/constants/_seo_const_assets.dart';
import 'package:serieso/application/constants/_seo_const_brandcolors.dart';
import 'package:serieso/application/models/models.dart';
import 'package:serieso/application/pages/seo_page_create_startup_register_request/seo_page_create_startup_register_request.dart';
import 'package:serieso/application/pages/seo_page_profile/seo_page_profile_vm.dart';

class SeoPageProfile extends StatefulWidget {
  const SeoPageProfile({super.key, required});

  @override
  State<SeoPageProfile> createState() => _SeoPageProfileState();
}

class _SeoPageProfileState extends State<SeoPageProfile> {
  late Size size;

  @override
  void didChangeDependencies() {
    size = MediaQuery.of(context).size;
    super.didChangeDependencies();
  }

  void _navigateToStartupRegisterPage(
      BuildContext context, SeoPageProfileVM vm) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SeoPageCreateStartupRegisterRequest(
          userData: vm.user,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SeoPageProfileVM>(
      create: (context) {
        return SeoPageProfileVM(size: size);
      },
      builder: (context, child) {
        return _body();
      },
    );
  }

  _body() {
    return Consumer<SeoPageProfileVM>(builder: (context, vm, _) {
      if (vm.loading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      return Scaffold(
        key: vm.scaffoldKey,
        backgroundColor: BrandColors.colorScaffold,
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: Stack(
            fit: StackFit.loose,
            clipBehavior: Clip.none,
            children: [
              ...SeoDecorationBackgroundCircles().getCircles(),
              vm.loading
                  ? const Center(child: CircularProgressIndicator())
                  : _getPageOptions(vm),
            ],
          ),
        ),
      );
    });
  }

  _getPageOptions(SeoPageProfileVM vm) {
    if (vm.user.role == UserRole.investor) {
      return _investorView(vm);
    }
    return _startupView(vm);
  }

  _investorView(SeoPageProfileVM vm) {
    return Padding(
      key: vm.scaffoldKey,
      padding: const EdgeInsets.symmetric(
        horizontal: 64.0,
        vertical: 24.0,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30.0,
            ),
            Image.asset(SeoAssets.assetsLogo, height: 60.0),
            const SizedBox(
              height: 50.0,
            ),
            _userInfoContainer(vm),
            const SizedBox(height: 28.0),
            SeoElevatedContainer(
              height: 250,
              width: size.width * 0.3,
              radius: 30.0,
              type: SeoElevatedContainerType.darkOnLightBackground,
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      "Complete KYC",
                      style: TextStyle(
                        fontSize: 26,
                        color: BrandColors.textLight,
                      ),
                    ),
                    const SizedBox(height: 14.0),
                    const Text(
                      "Before you can begin investing we would need to verify few documents.",
                      style: TextStyle(
                        fontSize: 18,
                        color: BrandColors.textLight,
                      ),
                    ),
                    const SizedBox(height: 14.0),
                    SeoRawMaterialButton(
                      onPressed: () {},
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "START KYC",
                          style: TextStyle(color: BrandColors.textLight),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 50.0),
            SeoRawMaterialButton(
              onPressed: () {
                vm.logout();
              },
              child: const Text(
                "Logout",
                style: TextStyle(color: BrandColors.textLight),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _startupView(SeoPageProfileVM vm) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 64.0,
        vertical: 24.0,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30.0,
            ),
            Image.asset(SeoAssets.assetsLogo, height: 60.0),
            const SizedBox(
              height: 50.0,
            ),
            _userInfoContainer(vm),
            const SizedBox(height: 28.0),
            if (!vm.showRegisterOption)
              SeoElevatedContainer(
                height: 250,
                width: size.width * 0.3,
                radius: 30.0,
                type: SeoElevatedContainerType.darkOnLightBackground,
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        "Application Status",
                        style: TextStyle(
                          fontSize: 26,
                          color: BrandColors.textLight,
                        ),
                      ),
                      const SizedBox(height: 14.0),
                      Text(
                        vm.getStatusMessage(),
                        style: const TextStyle(
                          fontSize: 18,
                          color: BrandColors.textLight,
                        ),
                      ),
                      const SizedBox(height: 14.0),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SeoRawMaterialButton(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                vm.startupData!.requestStatus.name
                                    .toUpperCase(),
                                style: const TextStyle(
                                    color: BrandColors.textLight),
                              ),
                            ),
                          ),
                          const Spacer(),
                          InkWell(
                            splashColor: Colors.transparent,
                            splashFactory: NoSplash.splashFactory,
                            onTap: () {},
                            child: const SeoElevatedContainer(
                              width: 150,
                              radius: 20.0,
                              type:
                                  SeoElevatedContainerType.darkOnDarkBackground,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  "View Details",
                                  style:
                                      TextStyle(color: BrandColors.textLight),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 28.0),
            if (vm.showRegisterOption)
              SeoElevatedContainer(
                height: 250,
                width: size.width * 0.3,
                radius: 30.0,
                type: SeoElevatedContainerType.darkOnLightBackground,
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        "Raise Funds",
                        style: TextStyle(
                          fontSize: 26,
                          color: BrandColors.textLight,
                        ),
                      ),
                      const SizedBox(height: 14.0),
                      const Text(
                        "Let's get you up to speed. We would need few details before you can showcase your startup to our investors.",
                        style: TextStyle(
                          fontSize: 18,
                          color: BrandColors.textLight,
                        ),
                      ),
                      const SizedBox(height: 14.0),
                      SeoRawMaterialButton(
                        onPressed: () {
                          if (vm.showStartupForm) {
                            _navigateToStartupRegisterPage(context, vm);
                          }
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "START REGISTRATION",
                            style: TextStyle(color: BrandColors.textLight),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 50.0),
            SeoRawMaterialButton(
              onPressed: () {
                vm.logout();
              },
              child: const Text(
                "Logout",
                style: TextStyle(color: BrandColors.textLight),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _userInfoContainer(SeoPageProfileVM vm) {
    return SeoElevatedContainer(
      height: 250,
      width: size.width * 0.3,
      radius: 30.0,
      type: SeoElevatedContainerType.darkOnLightBackground,
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100.0),
                border: Border.all(color: Colors.black, width: 10.0),
                image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    "https://staticg.sportskeeda.com/editor/2021/11/2a485-16358656961313-1920.jpg",
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${vm.user.firstName} ${vm.user.lastName}",
                  style: const TextStyle(
                    fontSize: 26,
                    color: BrandColors.textLight,
                  ),
                ),
                const SizedBox(height: 10.0),
                Text(
                  vm.user.email,
                  style: const TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 18,
                    color: BrandColors.textLight,
                  ),
                ),
                const SizedBox(height: 10.0),
                SeoRawMaterialButton(
                  child: Text(
                    vm.user.role.name.toUpperCase(),
                    style: const TextStyle(color: BrandColors.textLight),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
