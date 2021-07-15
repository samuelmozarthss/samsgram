import 'package:flutter_modular/flutter_modular.dart';
import 'package:samsgram/app/modules/feed/feed_page.dart';

class FeedModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (context, args) => FeedPage()),
  ];

}