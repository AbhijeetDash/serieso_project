import 'package:flutter/material.dart';
import 'package:serieso/application/components/_seo_component_appbar.dart';
import 'package:serieso/application/components/decoration_components/_seo_component_container.dart';
import 'package:serieso/application/components/decoration_components/_seo_decoration_background_circles.dart';
import 'package:serieso/application/constants/_seo_const_assets.dart';
import 'package:serieso/application/constants/_seo_const_brandcolors.dart';

import '../services/seo_service_locator.dart';
import '../services/seo_service_navigation.dart';

class SeoLandingSectionOne extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const SeoLandingSectionOne({Key? key, required this.scaffoldKey})
      : super(key: key);

  @override
  State<SeoLandingSectionOne> createState() => _SeoLandingSectionOneState();
}

class _SeoLandingSectionOneState extends State<SeoLandingSectionOne> {
  late Size size;

  void openOnboardingForms() {
    locator.get<SeoNavigationService>().openDrawer(widget.scaffoldKey);
  }

  @override
  void didChangeDependencies() {
    size = MediaQuery.of(context).size;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Stack(
        fit: StackFit.loose,
        clipBehavior: Clip.none,
        children: [
          /// Decoration Circles
          ...SeoDecorationBackgroundCircles().getCircles(),

          /// Remaining Content
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              BrandAppBar(
                trailingActions: [
                  InkWell(
                    onTap: () {},
                    child: const SeoElevatedContainer(
                      width: 150,
                      height: 50,
                      type: SeoElevatedContainerType.lightOnLightBackground,
                      child: Text("ABOUT"),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  InkWell(
                    onTap: () {
                      openOnboardingForms();
                    },
                    child: const SeoElevatedContainer(
                      width: 150,
                      height: 50,
                      type: SeoElevatedContainerType.darkOnLightBackground,
                      child: Text(
                        "GET STARTED",
                        style: TextStyle(color: BrandColors.textLight),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: size.height - 120.0,
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: size.height - 120,
                      width: size.width > 800
                          ? size.width * 0.4
                          : size.width * 0.8,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Invest in startups\nand founders\nbuilding the future\nwith serieso",
                            style: TextStyle(
                                fontSize: 64, fontWeight: FontWeight.bold),
                            overflow: TextOverflow.clip,
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(height: 50.0),
                          InkWell(
                            onTap: () {
                              openOnboardingForms();
                            },
                            child: const SeoElevatedContainer(
                              width: 250,
                              height: 60,
                              type: SeoElevatedContainerType
                                  .darkOnLightBackground,
                              child: Text(
                                "GET STARTED",
                                style: TextStyle(color: BrandColors.textLight),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    size.width > 800
                        ? SizedBox(
                            width: size.width * 0.4,
                            height: size.height,
                            child: Image.asset(SeoAssets.assetLandingIntro))
                        : Container()
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
