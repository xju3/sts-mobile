class AppConstants {
  AppConstants._();

  static const String kToken = 'token';
  static const String kEmployee = 'employee';
  static const String kRoleIds = 'roleIds';
  static const String kAuthorization = 'Authorization';
  static const String kVersion = '2024.11.12.017';
  static const String kBaseUrl = 'http://192.168.0.123:3300';
  // static const String kBaseUrl = ' https://5583-103-127-219-49.ngrok-free.app';
  static const String kWsUrl = 'ws://192.168.0.123:3300';

  static final RegExp regEmail = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.([a-zA-Z]{2,})+",
  );

  static final RegExp regPassword = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$#!%*?&_])[A-Za-z\d@#$!%*?&_].{7,}$',
  );

  static final RegExp regUserName = RegExp(r'^.{4,15}$');
  static final RegExp regSimplePassword = RegExp(r'^.{4,15}$');
}
