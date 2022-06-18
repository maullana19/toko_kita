// ignore_for_file: file_names

class ValidationException implements Exception {
  final String message;
  ValidationException(this.message);
  @override
  String toString() {
    return message;
  }
}
