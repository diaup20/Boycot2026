abstract class Failure {
  final String message;
  const Failure(this.message);
}

class NetworkFailure extends Failure {
  const NetworkFailure() : super('لا يوجد اتصال بالإنترنت');
}

class TimeoutFailure extends Failure {
  const TimeoutFailure() : super('انتهت مهلة الطلب');
}


class ServerFailure extends Failure {
  final int statusCode;
  const ServerFailure(this.statusCode)
      : super('خطأ في الخادم: رمز الحالة HTTP $statusCode');
}

class ParseFailure extends Failure {
  const ParseFailure() : super('خطأ أثناء معالجة البيانات');
}

class UnknownFailure extends Failure {
  const UnknownFailure(String details) : super('حدث خطأ غير متوقع: $details');
}
