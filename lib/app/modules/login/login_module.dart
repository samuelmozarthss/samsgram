import 'package:flutter_modular/flutter_modular.dart';
import 'package:samsgram/app/constants.dart';
import 'package:samsgram/app/modules/login/forgot_password_page.dart';

import '../login_page.dart';

class LoginModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (context, arg) => LoginPage()),
    ChildRoute(Constants.Routes.FORGOT_PASSWORD, child: (context, arg) => ForgotPasswordPage()),
  ];

}