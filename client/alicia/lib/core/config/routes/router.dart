import 'package:alicia/core/config/routes/route.dart';
import 'package:alicia/features/chat/ui/chat_page.dart';
import 'package:alicia/features/home/ui/home_page.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod/riverpod.dart';

class Routes {
  static final Route home = Route(name: '/home', path: '/');
  static final Route chat = Route(name: '/chat', path: '/chat');
}

final routerProvider = Provider(
  (ref) {
    return GoRouter(
      initialLocation: Routes.home.path,
      routes: [
        GoRoute(
          path: Routes.home.path,
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: Routes.chat.path,
          builder: (context, state) => const ChatPage(),
        ),
      ],
    );
  },
);
