import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:samsgram/app/constants.dart';
import 'package:samsgram/app/modules/onboarding/onboarding_module.dart';
import 'package:samsgram/app/modules/register/register_module.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'modules/home/home_module.dart';
import 'modules/login/login_module.dart';

class AppModule extends Module {
  SharedPreferences _sharedPreferences;
  FirebaseApp _firebaseApp;
  AppModule(this._sharedPreferences, this._firebaseApp);

  @override
  List<Bind> get binds => [
    Bind.singleton((i) => _sharedPreferences),
    Bind.instance(_firebaseApp),
    Bind.factory((i) => FirebaseAuth.instance),
    Bind.factory((i) => FirebaseFirestore.instance),
    Bind.factory((i) => FirebaseStorage.instance),
  ];

  @override
  late final List<ModularRoute> routes = [
    /*Modular.initialRoute é o mesmo que uma barra '/'*/
    ModuleRoute('/', module: _initialModule()),
    ModuleRoute(Constants.Routes.HOME, module: HomeModule(), guards: [_FirebaseAuthGuard()]),
    ModuleRoute(Constants.Routes.ONBOARDING, module: OnboardingModule()),
    ModuleRoute(Constants.Routes.REGISTER, module: RegisterModule(), transition: TransitionType.rotate),
    ModuleRoute(Constants.Routes.LOGIN, module: LoginModule(), transition: TransitionType.scale),
  ];

  Module _initialModule() {
    final onboardingDone =
      _sharedPreferences.getBool(Constants.SPK_ONBOARDING_DONE) ?? false;
    final registerDone =
      _sharedPreferences.getBool(Constants.SPK_REGISTER_DONE) ?? false;

    if (onboardingDone) {
      if (registerDone) {
        if (FirebaseAuth.instance.currentUser?.isAnonymous ?? true) {
          return LoginModule();
        } else {
          return HomeModule();
        }
      } else {
        return RegisterModule();
      }
      } else {
      return OnboardingModule();
    }
  }
}

class _FirebaseAuthGuard extends RouteGuard {
  _FirebaseAuthGuard() : super(null);

  @override
  Future<bool> canActivate(String path, ModularRoute router) {
    return Future.value(!(FirebaseAuth.instance.currentUser?.isAnonymous ?? true));
  }
}
