class ErrorsConst {
  static final ErrorsConst _instance = ErrorsConst._internal();
  factory ErrorsConst() {
    return _instance;
  }
  ErrorsConst._internal();
  static const API_DEFAULT_ERROR = 'An error occurred while trying to connect to the API. Please try again later.';
}