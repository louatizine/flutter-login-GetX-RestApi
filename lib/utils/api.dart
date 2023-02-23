class ApiEndPoints {
  static final String baseUrl = 'http://restapi.adequateshop.com/api/authaccount/login';
  static _AuthEndPoints authEndpoints = _AuthEndPoints();
}

class _AuthEndPoints {
  final String registerEmail = 'authaccount/registration';
  final String loginEmail = 'authaccount/login';
}
