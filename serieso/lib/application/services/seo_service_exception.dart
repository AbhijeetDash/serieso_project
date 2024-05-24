import 'package:serieso/application/models/seo_enums/seo_enums.dart';

class SeoException {
  final String message;
  final SeoExceptionType exceptionType;
  final int errorCode;

  SeoException({
    required this.message,
    required this.exceptionType,
    required this.errorCode,
  });
}

abstract class SeoExceptionService {
  String getExceptionMessage(SeoException exception);
}

class SeoExceptionServiceImpl extends SeoExceptionService {
  @override
  String getExceptionMessage(SeoException exception) {
    // Did it like this as we need to be able to parse the
    // exception messages comming from firebase type exception.
    return exception.message;
  }
}
