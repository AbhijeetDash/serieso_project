enum StartupRegistrationStatus { submitted, reviewing, accepted, declined }

enum StartupIndustryType {
  fintech,
  healthtech,
  edtech,
  ecommerce,
  saas,
  greentech,
  aiAndMachineLearning,
  cybersecurity,
  biotech,
  transportationAndMobility,
  foodTech,
  spaceTech,
  cleanEnergy,
  arVr,
  robotics
}

enum StartupInvestmentStage { preSeed, seed, seriesA, seriesB }

enum StartupRaiseTargetUnit { th, lac, cr }

enum StartupInvestmentType { equity, safe }

enum UserRole { investor, startup }

enum SeoExceptionType {
  firebaseAuthException,
  firebaseStorageException,
  firebaseFirestoreException,
  generalException,
}

extension StartupIndustryExt on StartupIndustryType {
  String getDisplayName() {
    switch (this) {
      case StartupIndustryType.fintech:
        return "Fintech";
      case StartupIndustryType.healthtech:
        return "Healthtech";
      case StartupIndustryType.edtech:
        return "Edtech";
      case StartupIndustryType.ecommerce:
        return "E-commerce";
      case StartupIndustryType.saas:
        return "SaaS";
      case StartupIndustryType.greentech:
        return "GreenTech";
      case StartupIndustryType.aiAndMachineLearning:
        return "AI and Machine Learning";
      case StartupIndustryType.cybersecurity:
        return "Cybersecurity";
      case StartupIndustryType.biotech:
        return "Biotech";
      case StartupIndustryType.transportationAndMobility:
        return "Transportation and Mobility";
      case StartupIndustryType.foodTech:
        return "FoodTech";
      case StartupIndustryType.spaceTech:
        return "SpaceTech";
      case StartupIndustryType.cleanEnergy:
        return "Clean Energy";
      case StartupIndustryType.arVr:
        return "AR/VR";
      case StartupIndustryType.robotics:
        return "Robotics";
      default:
        return "Unknown";
    }
  }

  String getValue() {
    return name;
  }
}

extension StartupInvestmentStageExt on StartupInvestmentStage {
  String getDisplayName() {
    switch (this) {
      case StartupInvestmentStage.preSeed:
        return "Pre-Seed";
      case StartupInvestmentStage.seed:
        return "Seed";
      case StartupInvestmentStage.seriesA:
        return "Series A";
      case StartupInvestmentStage.seriesB:
        return "Series B";
      default:
        return "";
    }
  }
}

extension StartupInvestmentTypeExt on StartupInvestmentType {
  String getDisplayName() {
    switch (this) {
      case StartupInvestmentType.equity:
        return "Equity";
      case StartupInvestmentType.safe:
        return "Safe";
    }
  }
}
