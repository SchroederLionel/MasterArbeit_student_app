/// Failure is used as an exception.
class Failure {
  final String code;
  Failure({required this.code});

  @override
  String toString() => code;
}
