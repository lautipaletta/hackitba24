import 'package:alicia/core/config/routes/route.dart';
import 'package:alicia/features/auth/ui/auth_page.dart';
import 'package:alicia/features/chat/ui/chat_page.dart';
import 'package:alicia/features/home/ui/home_page.dart';
import 'package:alicia/features/splash/ui/splash_page.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod/riverpod.dart';

class Routes {

  static final Route home = Route(name: '/home', path: '/');
  static final Route splash = Route(name: '/splash', path: '/splash');
  static final Route chat = Route(name: '/chat', path: '/chat');
  static final Route auth = Route(name: '/auth', path: '/auth');
}

final routerProvider = Provider(
  (ref) {
    return GoRouter(
      initialLocation: Routes.splash.path,
      routes: [
        GoRoute(
          name: Routes.splash.name,
          path: Routes.splash.path,
          builder: (context, state) => const SplashPage(),
          ),
        GoRoute(
          name: Routes.auth.name,
          path: Routes.auth.path,
          builder: (context, state) => AuthPage(),),
        GoRoute(
          name: Routes.home.name,
          path: Routes.home.path,
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          name: Routes.chat.name,
          path: Routes.chat.path,
          builder: (context, state) => const ChatPage(),
        ),
      ],
    );
  },
);
