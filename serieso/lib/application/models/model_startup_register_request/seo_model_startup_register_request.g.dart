// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seo_model_startup_register_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeoModelStartupRegisterRequest _$SeoModelStartupRegisterRequestFromJson(
        Map<String, dynamic> json) =>
    SeoModelStartupRegisterRequest(
      requestId: json['requestId'] as String,
      companyName: json['companyName'] as String,
      founderName: json['founderName'] as String,
      founderEmail: json['founderEmail'] as String,
      founderLinkedIn: json['founderLinkedIn'] as String,
      productName: json['productName'] as String,
      industry: $enumDecode(_$StartupIndustryTypeEnumMap, json['industry']),
      cinNumber: json['cinNumber'] as String,
      companyPan: json['companyPan'] as String,
      investmentStage:
          $enumDecode(_$StartupInvestmentStageEnumMap, json['investmentStage']),
      investmentType:
          $enumDecode(_$StartupInvestmentTypeEnumMap, json['investmentType']),
      raiseTarget: json['raiseTarget'] as String,
      requestStatus: $enumDecode(
          _$StartupRegistrationStatusEnumMap, json['requestStatus']),
    );

Map<String, dynamic> _$SeoModelStartupRegisterRequestToJson(
        SeoModelStartupRegisterRequest instance) =>
    <String, dynamic>{
      'requestId': instance.requestId,
      'companyName': instance.companyName,
      'founderName': instance.founderName,
      'founderEmail': instance.founderEmail,
      'founderLinkedIn': instance.founderLinkedIn,
      'productName': instance.productName,
      'industry': _$StartupIndustryTypeEnumMap[instance.industry]!,
      'cinNumber': instance.cinNumber,
      'companyPan': instance.companyPan,
      'investmentStage':
          _$StartupInvestmentStageEnumMap[instance.investmentStage]!,
      'investmentType':
          _$StartupInvestmentTypeEnumMap[instance.investmentType]!,
      'raiseTarget': instance.raiseTarget,
      'requestStatus':
          _$StartupRegistrationStatusEnumMap[instance.requestStatus]!,
    };

const _$StartupIndustryTypeEnumMap = {
  StartupIndustryType.fintech: 'fintech',
  StartupIndustryType.healthtech: 'healthtech',
  StartupIndustryType.edtech: 'edtech',
  StartupIndustryType.ecommerce: 'ecommerce',
  StartupIndustryType.saas: 'saas',
  StartupIndustryType.greentech: 'greentech',
  StartupIndustryType.aiAndMachineLearning: 'aiAndMachineLearning',
  StartupIndustryType.cybersecurity: 'cybersecurity',
  StartupIndustryType.biotech: 'biotech',
  StartupIndustryType.transportationAndMobility: 'transportationAndMobility',
  StartupIndustryType.foodTech: 'foodTech',
  StartupIndustryType.spaceTech: 'spaceTech',
  StartupIndustryType.cleanEnergy: 'cleanEnergy',
  StartupIndustryType.arVr: 'arVr',
  StartupIndustryType.robotics: 'robotics',
};

const _$StartupInvestmentStageEnumMap = {
  StartupInvestmentStage.preSeed: 'preSeed',
  StartupInvestmentStage.seed: 'seed',
  StartupInvestmentStage.seriesA: 'seriesA',
  StartupInvestmentStage.seriesB: 'seriesB',
};

const _$StartupInvestmentTypeEnumMap = {
  StartupInvestmentType.equity: 'equity',
  StartupInvestmentType.safe: 'safe',
};

const _$StartupRegistrationStatusEnumMap = {
  StartupRegistrationStatus.submitted: 'submitted',
  StartupRegistrationStatus.reviewing: 'reviewing',
  StartupRegistrationStatus.accepted: 'accepted',
  StartupRegistrationStatus.declined: 'declined',
};
