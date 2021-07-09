import 'package:firebase_auth/firebase_auth.dart';
import 'package:samsgram/app/modules/login/login_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:samsgram/app/constants.dart';
import 'package:samsgram/app/modules/login/forgot_password_page.dart';
import 'package:samsgram/app/modules/login/login_page.dart';

class LoginModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => LoginStore(i.get<FirebaseAuth>())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (context, arg) => LoginPage()),
    ChildRoute(Constants.Routes.FORGOT_PASSWORD,
        child: (context, arg) => ForgotPasswordPage(),
        transition: TransitionType.scale
    ),
  ];
}
