import 'package:flutter/material.dart';
import 'package:serieso/application/constants/_seo_const_brandcolors.dart';

enum SeoElevatedContainerType {
  lightOnDarkBackground,
  lightOnLightBackground,
  darkOnDarkBackground,
  darkOnLightBackground,
}

class SeoElevatedContainer extends StatelessWidget {
  final Widget child;
  final double? radius, width, height;
  final SeoElevatedContainerType type;

  const SeoElevatedContainer({
    Key? key,
    this.radius,
    this.width,
    this.height,
    required this.child,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Decide the Background Color of the Container.
    final Color backgroundColor =
        (type == SeoElevatedContainerType.darkOnDarkBackground ||
                type == SeoElevatedContainerType.darkOnLightBackground)
            ? BrandColors.colorBlueDark
            : BrandColors.colorScaffold;

    // Decide the Shadows of the Container.
    final List<BoxShadow> boxShadow =
        (type == SeoElevatedContainerType.lightOnDarkBackground ||
                type == SeoElevatedContainerType.darkOnDarkBackground)
            ? const [
                BoxShadow(
                    color: BrandColors.colorShadowLightOnDark,
                    offset: Offset(-10, -10),
                    blurRadius: 15.0),
                BoxShadow(
                    color: BrandColors.colorShadowDarkOnDark,
                    offset: Offset(10, 10),
                    blurRadius: 15.0),
              ]
            : const [
                BoxShadow(
                    color: BrandColors.colorShadowLightOnLight,
                    offset: Offset(-10, -10),
                    blurRadius: 15.0),
                BoxShadow(
                    color: BrandColors.colorShadowDarkOnLight,
                    offset: Offset(10, 10),
                    blurRadius: 15.0),
              ];

    return Container(
      width: width ?? double.minPositive,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.all(Radius.circular(radius ?? height ?? 0 * 0.5)),
        color: backgroundColor,
        boxShadow: boxShadow,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),
        child: child,
      ),
    );
  }
}
