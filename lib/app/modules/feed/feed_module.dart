import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:samsgram/app/modules/feed/feed_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:samsgram/app/modules/feed/feed_page.dart';

import '../../constants.dart';
import 'chat_page.dart';

class FeedModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => FeedStore(
      firebaseAuth: i.get<FirebaseAuth>(),
      firebaseFirestore: i.get<FirebaseFirestore>(),
    )),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (context, args) => FeedPage()),
    ChildRoute(Constants.Routes.CHAT, child: (context, args) => ChatPage()),
  ];
}
