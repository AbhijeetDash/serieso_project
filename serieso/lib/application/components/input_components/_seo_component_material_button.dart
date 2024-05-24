import 'package:flutter/material.dart';
import 'package:serieso/application/constants/_seo_const_brandcolors.dart';

class SeoRawMaterialButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget child;
  final FocusNode? focusNode;
  final double borderRadius;

  const SeoRawMaterialButton({
    super.key,
    this.onPressed,
    this.focusNode,
    this.borderRadius = 0.0,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      focusNode: focusNode,
      fillColor: BrandColors.colorButtonBlue,
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: child,
    );
  }
}
