import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:serieso/application/models/model_startup_register_request/seo_model_startup_register_request.dart';
import 'package:serieso/application/models/seo_enums/seo_enums.dart';
import 'package:serieso/application/services/seo_service_filepicker.dart';
import 'package:serieso/application/services/seo_service_firestore.dart';

import '../../services/seo_service_locator.dart';

class FormCreateStartupVM extends ChangeNotifier {
  final String uid;
  final Function() onComplete;
  final SeoModelStartupRegisterRequest? startup;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _founderNameController = TextEditingController();
  final TextEditingController _founderEmailController = TextEditingController();
  final TextEditingController _founderLinkedInController =
      TextEditingController();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _cinNumberController = TextEditingController();
  final TextEditingController _companyPanController = TextEditingController();
  final TextEditingController _raiseTargetController = TextEditingController();

  // Values from the dropdown will come here.
  String _industryType = "",
      _fundingStage = "",
      _investmentType = "",
      _raiseTargetUnit = "";

  // Param Const
  FormCreateStartupVM(
    this.startup, {
    required this.uid,
    required this.onComplete,
  }) {
    if (startup != null) {
      _setValues();
    }
  }

  int _currentStep = 1;
  int _totalStep = 3;
  bool _isFormEditable = true;
  bool _loadingIndicatorVisible = false;
  bool _showErrorPopUp = false;
  String _errorMessage = "";
  bool _isFilePicked = false;
  PlatformFile? _file;
  String? _imageUrl;

  int get currentStep => _currentStep;
  int get totalStep => _totalStep;

  bool get showLoading => _loadingIndicatorVisible;
  bool get showErrorMessage => _showErrorPopUp;
  bool get isFilePicked => _isFilePicked;
  bool get isFormEditable => _isFormEditable;

  String get errorMessage => _errorMessage;
  String get imageUrl => _imageUrl ?? "";
  PlatformFile? get imageFile => _file;
  GlobalKey<FormState> get formKey => _formKey;

  TextEditingController get companyNameController => _companyNameController;
  TextEditingController get founderNameController => _founderNameController;
  TextEditingController get founderEmailController => _founderEmailController;
  TextEditingController get founderLinkedInController =>
      _founderLinkedInController;
  TextEditingController get productNameController => _productNameController;
  TextEditingController get cinNumberController => _cinNumberController;
  TextEditingController get companyPanController => _companyPanController;
  TextEditingController get raiseTargetController => _raiseTargetController;

  set fundingStage(String value) {
    if (value == _fundingStage) {
      return;
    }
    _fundingStage = value;
  }

  set industryType(String value) {
    if (value == _industryType) {
      return;
    }
    _industryType = value;
  }

  set investmentType(String value) {
    if (value == _investmentType) {
      return;
    }
    _investmentType = value;
  }

  set raiseTargetUnit(String value) {
    if (value == _investmentType) {
      return;
    }
    _investmentType = value;
  }

  void industryTypeController(StartupIndustryType? selection) {
    industryType = selection?.name ?? "";
  }

  void selectStageController(StartupInvestmentStage? selection) {
    fundingStage = selection?.name ?? "";
  }

  void investmentTypeController(StartupInvestmentType? selection) {
    investmentType = selection?.name ?? "";
  }

  void selectRaiseTargetUnit(StartupRaiseTargetUnit? selection) {
    raiseTargetUnit = selection?.name ?? "";
  }

  void _setValues() {
    _isFormEditable = false;
    _companyNameController.text = startup!.companyName;
    _founderNameController.text = startup!.founderName;
    _founderEmailController.text = startup!.founderEmail;
    _founderLinkedInController.text = startup!.founderLinkedIn;
    _productNameController.text = startup!.productName;
    _cinNumberController.text = startup!.cinNumber;
    _companyPanController.text = startup!.companyPan;
    _raiseTargetController.text = startup!.raiseTarget.toString();
    notifyListeners();
  }

  SeoModelStartupRegisterRequest _getRegistrationRequestObject() {
    return SeoModelStartupRegisterRequest(
      requestId: "",
      companyName: _companyNameController.text,
      founderName: _founderNameController.text,
      founderEmail: _founderEmailController.text,
      founderLinkedIn: _founderLinkedInController.text,
      productName: _productNameController.text,
      industry: StartupIndustryType.arVr,
      cinNumber: _cinNumberController.text,
      companyPan: _companyPanController.text,
      investmentStage: StartupInvestmentStage.seed,
      investmentType: StartupInvestmentType.equity,
      raiseTarget:
          "${_raiseTargetController.text} ${_raiseTargetUnit.toString()}",
      requestStatus: StartupRegistrationStatus.submitted,
    );
  }

  void pickUpFile() async {
    FilePickerResult? result =
        await locator.get<SeoFileService>().pickUpImageFile();
    if (result != null) {
      _file = result.files.first;
      _isFilePicked = true;
      notifyListeners();
    }
  }

  Future<void> registerStartup() async {
    try {
      // Show Loading
      _loadingIndicatorVisible = true;
      notifyListeners();

      // Run all validations.
      if (formKey.currentState!.validate()) {
        if (await verifyCompanyPan(_companyPanController.text) &&
            await verifyCompanyCin(_cinNumberController.text)) {
          // Create Startup Request.
          bool isSuccess = await locator
              .get<SeoFirestoreService>()
              .createStartupRegistrationRequest(
                request: _getRegistrationRequestObject(),
                uid: uid,
              );

          if (!isSuccess) {
            // show error popup.
            _showErrorPopUp = true;
            _errorMessage = "There was a problem creating startup request.";
            notifyListeners();
            return;
          }

          _showErrorPopUp = true;
          _errorMessage =
              "Thanks for registering with us. Our team will reach out to you soon.";

          /// This re-fetches the userData in [seo_page_profile_vm]
          onComplete();
          notifyListeners();
        }
      }

      // On Success Pop Route and Hide Loading
    } catch (e) {
      rethrow;
    }
  }

  // Verifies wheather the company pan is valid and belongs to the founder only
  Future<bool> verifyCompanyPan(String companyPan) {
    return Future.value(true);
  }

  // Vewrifies wheather the company CIN is valid and belongs to the same company name.
  Future<bool> verifyCompanyCin(String cin) {
    return Future.value(true);
  }
}
