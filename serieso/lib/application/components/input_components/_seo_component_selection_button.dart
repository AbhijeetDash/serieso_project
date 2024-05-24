import 'package:flutter/material.dart';
import 'package:serieso/application/constants/_seo_const_brandcolors.dart';

class SeoSelectionButton extends StatelessWidget {
  final bool isSelected;
  final String title;
  final void Function() onPressedExtension;
  const SeoSelectionButton({
    super.key,
    required this.isSelected,
    required this.title,
    required this.onPressedExtension,
  });

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      fillColor: isSelected
          ? BrandColors.colorButtonBlue
          : BrandColors.colorShadowLightOnDark,
      onPressed: () {
        onPressedExtension();
      },
      child: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 18),
      ),
    );
  }
}
