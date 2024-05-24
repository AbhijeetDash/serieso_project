import 'package:flutter/material.dart';
import 'package:serieso/application/constants/_seo_const_assets.dart';

class BrandAppBar extends StatelessWidget {
  final List<Widget> trailingActions;
  const BrandAppBar({
    Key? key,
    required this.trailingActions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 50.0, right: 50.0, top: 60.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Image.asset(SeoAssets.assetsLogo, height: 60.0),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [...trailingActions],
          )
        ],
      ),
    );
  }
}
