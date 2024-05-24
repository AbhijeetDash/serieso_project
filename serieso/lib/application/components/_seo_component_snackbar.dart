import 'dart:async';

import 'package:flutter/material.dart';
import 'package:serieso/application/constants/_seo_const_brandcolors.dart';

class SeoComponentSnackBar {
  static void showSeoSnackBar(
      BuildContext context, SeoSnackBarContent child) async {
    // getting handle on the overlay state.
    OverlayState? overlayState = Overlay.of(context);

    // creating overlay entry
    OverlayEntry overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(child: child);
    });

    overlayState.insert(overlayEntry);

    Timer(const Duration(seconds: 4), () {
      overlayEntry.remove();
    });
  }
}

class SeoSnackBarContent extends StatefulWidget {
  final String message;
  const SeoSnackBarContent({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  State<SeoSnackBarContent> createState() => _SeoSnackBarContentState();
}

class _SeoSnackBarContentState extends State<SeoSnackBarContent>
    with SingleTickerProviderStateMixin {
  late Size size;
  late AnimationController controller;
  late Animation<Offset> animation;

  @override
  void didChangeDependencies() {
    print("init");
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    size = MediaQuery.of(context).size;
    animation = Tween<Offset>(
            begin: Offset(size.width + 300, size.height - 100),
            end: Offset(size.width - 320, size.height - 100))
        .animate(controller);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.forward();

      Timer(const Duration(milliseconds: 3400), () {
        controller.reverse();
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Align(
        alignment: Alignment.topLeft,
        child: AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return Transform.translate(
              offset: animation.value,
              child: Container(
                width: 300,
                height: 80,
                color: BrandColors.colorErrorRed,
                child: Text(
                  widget.message,
                  style: const TextStyle(color: BrandColors.textDark),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
