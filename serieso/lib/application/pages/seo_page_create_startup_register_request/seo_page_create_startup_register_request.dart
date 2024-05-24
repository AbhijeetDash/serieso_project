import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serieso/application/components/decoration_components/_seo_decoration_background_circles.dart';
import 'package:serieso/application/constants/constants.dart';
import 'package:serieso/application/forms/form_create_startup/form_create_startup.dart';
import 'package:serieso/application/models/model_user/seo_model_user.dart';
import 'package:serieso/application/pages/seo_page_create_startup_register_request/seo_page_create_startup_register_request_vm.dart';

class SeoPageCreateStartupRegisterRequest extends StatefulWidget {
  final SeoModelUser userData;
  const SeoPageCreateStartupRegisterRequest({
    Key? key,
    required this.userData,
  }) : super(key: key);

  @override
  State<SeoPageCreateStartupRegisterRequest> createState() =>
      _SeoPageCreateStartupRegisterRequestState();
}

class _SeoPageCreateStartupRegisterRequestState
    extends State<SeoPageCreateStartupRegisterRequest> {
  late Size size;

  @override
  void didChangeDependencies() {
    size = MediaQuery.of(context).size;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SeoPageCreateStartupRegisterRequestVM>(
      create: (context) {
        return SeoPageCreateStartupRegisterRequestVM(userData: widget.userData);
      },
      builder: (context, _) {
        return _body();
      },
    );
  }

  _body() {
    return Consumer<SeoPageCreateStartupRegisterRequestVM>(
        builder: (context, vm, _) {
      return Scaffold(
        backgroundColor: BrandColors.colorBlueDark,
        body: SizedBox(
          width: size.width,
          // Affects Row Height.
          height: size.height,
          child: Stack(
            fit: StackFit.loose,
            clipBehavior: Clip.none,
            children: [
              ...SeoDecorationBackgroundCircles().getCircles(isOnDark: true),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 20.0),
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: BrandColors.textLight,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          constraints: const BoxConstraints(
                              maxWidth: 300, maxHeight: 300),
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(SeoAssets.assetStartupRegister),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12.0),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 700),
                          child: const Text(
                            "We're glad to see you here.",
                            style: TextStyle(
                              fontSize: 64,
                              fontWeight: FontWeight.bold,
                              color: BrandColors.textLight,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 64.0,
                        vertical: 32.0,
                      ),
                      child: Container(
                        constraints:
                            BoxConstraints(maxHeight: size.height - 32.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40.0),
                          border: Border.all(
                            color: BrandColors.colorPaintGrey,
                          ),
                          color: BrandColors.colorBlueDark,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 64.0,
                          vertical: 32.0,
                        ),
                        child: FormCreateStartup(
                          uid: vm.uid,
                          onComplete: () {},
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
