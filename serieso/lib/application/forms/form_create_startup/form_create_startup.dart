import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serieso/application/components/components.dart';
import 'package:serieso/application/components/input_components/_seo_component_dropdown_field.dart';
import 'package:serieso/application/forms/form_create_startup/form_create_startup_vm.dart';
import 'package:serieso/application/models/model_startup_register_request/seo_model_startup_register_request.dart';
import 'package:serieso/application/models/seo_enums/seo_enums.dart';

import '../../constants/_seo_const_brandcolors.dart';

class FormCreateStartup extends StatefulWidget {
  final String uid;
  final Function() onComplete;
  final SeoModelStartupRegisterRequest? startup;

  const FormCreateStartup({
    super.key,
    required this.uid,
    required this.onComplete,
    this.startup,
  });

  @override
  State<FormCreateStartup> createState() => _FormCreateStartupState();
}

class _FormCreateStartupState extends State<FormCreateStartup> {
  late Size size;

  @override
  void didChangeDependencies() {
    size = MediaQuery.of(context).size;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        return FormCreateStartupVM(
          widget.startup,
          uid: widget.uid,
          onComplete: widget.onComplete,
        );
      },
      builder: (context, child) {
        return _body();
      },
    );
  }

  _body() {
    return Consumer<FormCreateStartupVM>(builder: (context, vm, _) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        if (vm.showErrorMessage) {
          _showErrorMessage(vm);
        }
      });

      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Company Details",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                    ),
                  ),
                ),
                const SizedBox(height: 12.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Step ${vm.currentStep} of ${vm.totalStep}",
                    style: const TextStyle(
                      color: BrandColors.colorPaintGrey,
                      fontSize: 24,
                    ),
                  ),
                ),
                const SizedBox(height: 24.0),
              ],
            ),
            _companyInformation(vm),
            Column(
              children: [
                const SizedBox(height: 12.0),

                /// Submit button.
                if (widget.startup == null)
                  Row(
                    children: [
                      InkWell(
                        onTap: () {},
                        child: const SeoElevatedContainer(
                          width: 120,
                          height: 50,
                          type: SeoElevatedContainerType.darkOnDarkBackground,
                          child: Text(
                            "Save draft",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: BrandColors.textLight,
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      SeoRawMaterialButton(
                        onPressed: () {
                          if (vm.formKey.currentState!.validate()) {
                            vm.registerStartup();
                          }
                        },
                        borderRadius: 50.0,
                        child: const Text(
                          "Next",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: BrandColors.textLight,
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ],
        ),
      );
    });
  }

  _companyInformation(FormCreateStartupVM vm) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 18.0, right: 20.0),
        child: Form(
          key: vm.formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Company name
                SeoTextFormField(
                  controller: vm.companyNameController,
                  hintText: "Company name",
                  validator: (value) {
                    if (value!.isNotEmpty) {
                      return null;
                    }
                    return "Required field";
                  },
                ),
                const SizedBox(height: 24.0),

                /// Founder Name
                SeoTextFormField(
                  controller: vm.founderNameController,
                  hintText: "Founder's Name",
                  validator: (value) {
                    if (value!.isNotEmpty) {
                      return null;
                    }
                    return "Required field";
                  },
                ),

                const SizedBox(height: 24.0),

                /// Founder Email
                SeoTextFormField(
                  controller: vm.founderEmailController,
                  hintText: "Founder's Email",
                  validator: (value) {
                    if (value!.isNotEmpty) {
                      return null;
                    }
                    return "Required field";
                  },
                ),

                const SizedBox(height: 24.0),

                /// Founder LinkedIn
                SeoTextFormField(
                  controller: vm.founderLinkedInController,
                  hintText: "Founder's linkedin",
                  validator: (value) {
                    if (value!.isNotEmpty) {
                      return null;
                    }
                    return "Required field";
                  },
                ),

                const SizedBox(height: 24.0),

                /// Product Name
                SeoTextFormField(
                  controller: vm.productNameController,
                  hintText: "Product Name",
                  validator: (value) {
                    if (value!.isNotEmpty) {
                      return null;
                    }
                    return "Required field";
                  },
                ),
                const SizedBox(height: 24.0),

                /// Industry
                SeoComponentDropdownField<StartupIndustryType>(
                  hintText: 'Select Industry Type',
                  onChanged: vm.industryTypeController,
                  dropdownItems: StartupIndustryType.values,
                  validator: (value) {
                    if (value != null) {
                      return null;
                    }
                    return "Required field";
                  },
                ),

                const SizedBox(height: 24.0),

                /// Company Pan
                SeoTextFormField(
                  controller: vm.companyPanController,
                  hintText: "Company PAN",
                  validator: (value) {
                    if (value!.isNotEmpty) {
                      return null;
                    }
                    return "Required field";
                  },
                ),

                const SizedBox(height: 24.0),

                /// CIN Number
                SeoTextFormField(
                  controller: vm.cinNumberController,
                  hintText: "CIN Number",
                  validator: (value) {
                    if (value!.isNotEmpty) {
                      return null;
                    }
                    return "Required field";
                  },
                ),

                const SizedBox(height: 24.0),

                /// Amount to Raise
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Amount
                    Expanded(
                      flex: 4,
                      child: SeoTextFormField(
                        textInputType: TextInputType.number,
                        controller: vm.raiseTargetController,
                        hintText: "Raise target",
                        validator: (value) {
                          if (value!.isNotEmpty) {
                            double? val = double.tryParse(value);

                            if (val == null) {
                              return "Not a valid amount";
                            }

                            return null;
                          }
                          return "Required field";
                        },
                      ),
                    ),

                    const SizedBox(width: 10.0),

                    // Unit
                    Expanded(
                      flex: 3,
                      child: SeoComponentDropdownField<StartupRaiseTargetUnit>(
                        hintText: 'Unit',
                        onChanged: vm.selectRaiseTargetUnit,
                        dropdownItems: StartupRaiseTargetUnit.values,
                        validator: (value) {
                          if (value != null) {
                            return null;
                          }
                          return "Required field";
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24.0),

                /// Stage
                SeoComponentDropdownField<StartupInvestmentStage>(
                  hintText: 'Select Company Stage',
                  onChanged: vm.selectStageController,
                  dropdownItems: StartupInvestmentStage.values,
                  validator: (value) {
                    if (value != null) {
                      return null;
                    }
                    return "Required field";
                  },
                ),

                const SizedBox(height: 24.0),

                /// Investment Type
                SeoComponentDropdownField<StartupInvestmentType>(
                  onChanged: vm.investmentTypeController,
                  dropdownItems: StartupInvestmentType.values,
                  hintText: 'Select Investment Type',
                  validator: (value) {
                    if (value != null) {
                      return null;
                    }
                    return "Required field";
                  },
                ),

                const SizedBox(height: 50.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _showErrorMessage(FormCreateStartupVM vm) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Dialog(
          insetAnimationDuration: const Duration(milliseconds: 250),
          insetAnimationCurve: Curves.linearToEaseOut,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          backgroundColor: BrandColors.colorScaffold,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20.0),
              Text(
                vm.errorMessage,
                style: const TextStyle(
                  color: BrandColors.textDark,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20.0),
              SeoRawMaterialButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Okay",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        );
      },
    ).then((value) {
      Navigator.of(context).pop(true);
    });
  }
}

// Align(
//   alignment: Alignment.centerLeft,
//   child: Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       const Text(
//         "Upload Brand Logo",
//         style: TextStyle(
//           color: Colors.white,
//           fontSize: 16,
//         ),
//       ),
//       const SizedBox(height: 20.0),
//
//       /// TODO : Move Media upload to page builder.
//       // !vm.isFilePicked
//       //     ? Container(
//       //         width: 200,
//       //         height: 200,
//       //         decoration: BoxDecoration(
//       //             border: Border.all(color: Colors.white60),
//       //             borderRadius: BorderRadius.circular(8.0)),
//       //         padding: const EdgeInsets.all(8.0),
//       //         child: InkWell(
//       //           onTap: () {
//       //             vm.pickUpFile();
//       //           },
//       //           child: const Icon(
//       //             Icons.upload_file,
//       //             size: 100,
//       //             color: Colors.white,
//       //           ),
//       //         ),
//       //       )
//       //     : Container(
//       //         width: 200,
//       //         height: 200,
//       //         decoration: BoxDecoration(
//       //             border: Border.all(color: Colors.white60),
//       //             borderRadius: BorderRadius.circular(8.0)),
//       //         padding: const EdgeInsets.all(8.0),
//       //         child: widget.startup == null
//       //             ? Image.memory(vm.imageFile!.bytes!)
//       //             : Image.network(
//       //                 vm.imageUrl.replaceFirst("https:", "gs:"),
//       //               ),
//       //       ),
//       /// --------------------------------------------------------
//     ],
//   ),
// ),
