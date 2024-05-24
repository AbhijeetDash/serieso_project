import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serieso/application/components/input_components/_seo_component_material_button.dart';
import 'package:serieso/application/components/input_components/_seo_component_selection_button.dart';
import 'package:serieso/application/components/input_components/_seo_component_text_field.dart';
import 'package:serieso/application/constants/_seo_const_strings.dart';
import 'package:serieso/application/extensions/seo_context_extension.dart';

import 'form_signup_vm.dart';

class SeoFormSignup extends StatelessWidget {
  const SeoFormSignup({super.key});

  void showErrorMessage(SeoFormSignupVM vm, BuildContext context) {
    if (vm.hasError) {
      context.showErrorOverlay(vm.errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return SeoFormSignupVM();
      },
      builder: (context, child) {
        return _signUpForm();
      },
    );
  }

  Widget _signUpForm() {
    return Consumer<SeoFormSignupVM>(builder: (context, vm, child) {
      showErrorMessage(vm, context);

      switch (vm.getStageIndex) {
        case 0:
          return _stageOne(vm);
        case 1:
          return _stageTwo(vm);
      }
      return _stageOne(vm);
    });
  }

  Widget _stageOne(SeoFormSignupVM vm) {
    return Padding(
      padding: const EdgeInsets.only(left: 32.0, top: 18.0, right: 20.0),
      child: Form(
        key: vm.stageOneFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              SeoStrings.signUpString,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 14.0),
            const Text(
              SeoStrings.signUpMessageString,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w300,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: SeoTextFormField(
                    currentFocus: vm.firstNameFocus,
                    nextFocus: vm.lastNameFocus,
                    controller: vm.firstNameController,
                    hintText: SeoStrings.getFirstNameHint,
                    validator: vm.validatorFirstName,
                  ),
                ),
                const SizedBox(
                  width: 20.0,
                ),
                Expanded(
                  flex: 1,
                  child: SeoTextFormField(
                    currentFocus: vm.lastNameFocus,
                    nextFocus: vm.emailFocus,
                    controller: vm.lastNameController,
                    hintText: SeoStrings.getLastNameHint,
                    validator: vm.validatorLastName,
                  ),
                )
              ],
            ),
            const SizedBox(height: 20.0),
            SeoTextFormField(
              currentFocus: vm.emailFocus,
              nextFocus: vm.phoneNumberFocus,
              controller: vm.emailController,
              hintText: SeoStrings.getEmailHint,
              validator: vm.validatorEmail,
            ),
            const SizedBox(height: 20.0),
            SeoTextFormField(
              controller: vm.phoneNumberController,
              currentFocus: vm.phoneNumberFocus,
              nextFocus: vm.continueButtonFocus,
              hintText: SeoStrings.getPhoneNumberHint,
              validator: vm.validatorPhoneNumber,
            ),
            const SizedBox(height: 20.0),
            SeoRawMaterialButton(
              focusNode: vm.continueButtonFocus,
              onPressed: () {
                vm.setStageOneValues(
                  vm.firstNameController.text,
                  vm.lastNameController.text,
                  vm.emailController.text,
                  vm.phoneNumberController.text,
                );
              },
              child: Container(
                height: 60.0,
                width: double.maxFinite,
                alignment: Alignment.center,
                child: const Text(
                  "Continue",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _stageTwo(SeoFormSignupVM vm) {
    return Padding(
      padding: const EdgeInsets.only(left: 32.0, top: 18.0, right: 20.0),
      child: Form(
        key: vm.stageTwoFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              SeoStrings.signUpStepTwo,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 14.0),
            const Text(
              SeoStrings.signUpStepTwoMessage,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w300,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              "What would you like to do on our platform?",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 12.0),
            _profileTypeSelection(vm),
            const SizedBox(height: 14.0),
            SeoTextFormField(
              currentFocus: vm.passwordFocus,
              nextFocus: vm.passwordConfirmFocus,
              controller: vm.passController,
              hintText: SeoStrings.getPasswordHint,
              validator: vm.validatorPassword,
              isObscured: true,
            ),
            const SizedBox(height: 14.0),
            SeoTextFormField(
              currentFocus: vm.passwordConfirmFocus,
              nextFocus: vm.signupBtnFocus,
              controller: vm.conPassController,
              hintText: SeoStrings.getConfirmPasswordHint,
              validator: vm.validatorConfirmPassword,
              isObscured: true,
            ),
            const SizedBox(height: 14.0),
            SeoRawMaterialButton(
              focusNode: vm.signupBtnFocus,
              onPressed: () {
                vm.setStageTwoValues(
                  vm.passController.text,
                  vm.conPassController.text,
                );
              },
              child: vm.showLoadingIndicator
                  ? Container(
                      height: 60.0,
                      width: double.maxFinite,
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(),
                    )
                  : Container(
                      height: 60.0,
                      width: double.maxFinite,
                      alignment: Alignment.center,
                      child: const Text(
                        "Register",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }

  Widget _profileTypeSelection(SeoFormSignupVM vm) {
    return SizedBox(
      height: 50.0,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SeoSelectionButton(
            isSelected: vm.selectionIndex == 0,
            title: "Investor",
            onPressedExtension: () {
              vm.changeGroupSelection();
            },
          ),
          const SizedBox(width: 20.0),
          SeoSelectionButton(
            isSelected: vm.selectionIndex == 1,
            title: "Startup",
            onPressedExtension: () {
              vm.changeGroupSelection();
            },
          ),
        ],
      ),
    );
  }
}
