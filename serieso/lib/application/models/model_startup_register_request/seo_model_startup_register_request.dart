import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:serieso/application/models/seo_enums/seo_enums.dart';

part 'seo_model_startup_register_request.g.dart';

@JsonSerializable()
class SeoModelStartupRegisterRequest extends Equatable {
  final String requestId;
  final String companyName;
  final String founderName; // From SeoModelUser
  final String founderEmail; // From SeoModelUser
  final String founderLinkedIn;
  final String productName;
  final StartupIndustryType industry;
  final String cinNumber;
  final String companyPan;
  final StartupInvestmentStage investmentStage;
  final StartupInvestmentType investmentType;
  final String raiseTarget;
  final StartupRegistrationStatus requestStatus;

  const SeoModelStartupRegisterRequest({
    required this.requestId,
    required this.companyName,
    required this.founderName,
    required this.founderEmail,
    required this.founderLinkedIn,
    required this.productName,
    required this.industry,
    required this.cinNumber,
    required this.companyPan,
    required this.investmentStage,
    required this.investmentType,
    required this.raiseTarget,
    required this.requestStatus,
  });

  factory SeoModelStartupRegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$SeoModelStartupRegisterRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SeoModelStartupRegisterRequestToJson(this);

  SeoModelStartupRegisterRequest copyWith({
    String? requestId,
    String? companyName,
    String? founderName,
    String? founderEmail,
    String? founderLinkedIn,
    String? productName,
    StartupIndustryType? industry,
    String? cinNumber,
    String? companyPan,
    StartupInvestmentStage? investmentStage,
    StartupInvestmentType? investmentType,
    String? raiseTarget,
    StartupRegistrationStatus? requestStatus,
  }) {
    return SeoModelStartupRegisterRequest(
      requestId: requestId ?? this.requestId,
      companyName: companyName ?? this.companyName,
      founderName: founderName ?? this.founderName,
      founderEmail: founderEmail ?? this.founderEmail,
      founderLinkedIn: founderLinkedIn ?? this.founderLinkedIn,
      productName: productName ?? this.productName,
      industry: industry ?? this.industry,
      cinNumber: cinNumber ?? this.cinNumber,
      companyPan: companyPan ?? this.companyPan,
      investmentStage: investmentStage ?? this.investmentStage,
      investmentType: investmentType ?? this.investmentType,
      raiseTarget: raiseTarget ?? this.raiseTarget,
      requestStatus: requestStatus ?? this.requestStatus,
    );
  }

  @override
  List<Object?> get props => [
        requestId,
        companyName,
        founderName,
        founderEmail,
        founderLinkedIn,
        productName,
        industry,
        cinNumber,
        companyPan,
        investmentStage,
        investmentType,
        raiseTarget,
        requestStatus
      ];
}
