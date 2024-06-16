abstract class ValidationRule {
  final String _errorMessage;

  String get errorMessage => _errorMessage;

  ValidationRule({required String errorMessage}) : _errorMessage = errorMessage;

  String? run(String inputString);
}
