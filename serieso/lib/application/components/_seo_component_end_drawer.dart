import 'package:flutter/material.dart';
import 'package:serieso/application/constants/_seo_const_brandcolors.dart';

class SeoEndDrawer extends StatefulWidget {
  final Widget child;

  const SeoEndDrawer({
    super.key,
    required this.child,
  });

  @override
  State<SeoEndDrawer> createState() => _SeoEndDrawerState();
}

class _SeoEndDrawerState extends State<SeoEndDrawer> {
  late Size size;

  @override
  void didChangeDependencies() {
    size = MediaQuery.sizeOf(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: BrandColors.colorBlueDark,
      width: size.width > 800 ? size.width * 0.4 : size.width * 0.8,
      height: size.height,
      child: widget.child,
    );
  }
}
