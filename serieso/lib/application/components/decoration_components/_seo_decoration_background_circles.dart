import 'package:flutter/material.dart';
import 'package:serieso/application/components/decoration_components/_seo_component_custom_paint_circle.dart';
import 'package:serieso/application/constants/_seo_const_brandcolors.dart';

class SeoDecorationBackgroundCircles {
  List<Widget> getCircles({bool isOnDark = false}) {
    return [
      Positioned(
        top: -400,
        left: 100,
        child: CustomCircle(
          color: isOnDark
              ? BrandColors.colorPaintGrey
              : BrandColors.colorPaintGrey,
          child: const SizedBox(
            width: 900,
            height: 900,
          ),
        ),
      ),
      Positioned(
        top: -100,
        right: 100,
        child: CustomCircle(
          color: isOnDark
              ? BrandColors.colorPaintGrey
              : BrandColors.colorPaintGrey,
          child: const SizedBox(
            width: 900,
            height: 900,
          ),
        ),
      ),
      Positioned(
        bottom: -600,
        right: 50,
        child: CustomCircle(
          color: isOnDark
              ? BrandColors.colorPaintGrey
              : BrandColors.colorPaintGrey,
          child: const SizedBox(
            width: 900,
            height: 900,
          ),
        ),
      ),
    ];
  }
}
