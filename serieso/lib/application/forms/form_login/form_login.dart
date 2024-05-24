import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serieso/application/components/_seo_component_snackbar.dart';
import 'package:serieso/application/components/input_components/_seo_component_material_button.dart';
import 'package:serieso/application/components/input_components/_seo_component_text_field.dart';
import 'package:serieso/application/constants/_seo_const_strings.dart';
import 'package:serieso/application/extensions/seo_context_extension.dart';
import 'package:serieso/application/forms/form_login/form_login_vm.dart';

class SeoFormLogin extends StatelessWidget {
  const SeoFormLogin({super.key});

  void showErrorMessage(SeoFormLoginVM vm, BuildContext context) {
    if (vm.hasError) {
      context.showErrorOverlay(vm.errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        return SeoFormLoginVM();
      },
      builder: (context, child) {
        return _body();
      },
    );
  }

  Widget _body() {
    return Consumer<SeoFormLoginVM>(
      builder: (context, vm, child) {
        showErrorMessage(vm, context);

        return Form(
          key: vm.formKey,
          child: Padding(
            padding: const EdgeInsets.only(left: 32.0, top: 18.0, right: 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  SeoStrings.loginForm,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 14.0),
                const Text(
                  SeoStrings.loginMessage,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w300,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 20.0),
                const SizedBox(height: 14.0),
                SeoTextFormField(
                  currentFocus: vm.emailFocus,
                  nextFocus: vm.passwordFocus,
                  controller: vm.emailController,
                  hintText: SeoStrings.getEmailHint,
                  validator: vm.validatorEmail,
                ),
                const SizedBox(height: 14.0),
                SeoTextFormField(
                  currentFocus: vm.passwordFocus,
                  nextFocus: vm.loginBtnFocus,
                  controller: vm.passwordController,
                  hintText: SeoStrings.getConfirmPasswordHint,
                  validator: (str) => null,
                  isObscured: true,
                ),
                const SizedBox(height: 14.0),
                SeoRawMaterialButton(
                  focusNode: vm.loginBtnFocus,
                  onPressed: () {
                    if (!vm.isLoading) {
                      vm.login();
                    }
                  },
                  child: Container(
                    height: 60.0,
                    width: double.maxFinite,
                    alignment: Alignment.center,
                    child: vm.isLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : const Text(
                            "Login",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
