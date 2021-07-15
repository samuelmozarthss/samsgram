import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:samsgram/app/constants.dart';
import 'package:samsgram/app/modules/profile/edit_page.dart';
import 'package:samsgram/app/modules/profile/user_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:samsgram/app/modules/profile/profile_page.dart';

class ProfileModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => UserStore(i.get<FirebaseAuth>(), i.get<FirebaseFirestore>())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (context, args) => ProfilePage()),
    ChildRoute(Constants.Routes.EDIT_PROFILE, child: (context, args) => EditPage()),
  ];
}
