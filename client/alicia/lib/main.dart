import 'package:alicia/core/config/routes/router.dart';
import 'package:alicia/features/chat/providers/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

WidgetRef? globalRef;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final chatState = globalRef!.read(chatProvider);
    final chatController = globalRef!.read(chatProvider.notifier);
    if (state != AppLifecycleState.resumed) {
      if (globalRef == null) return;
      if (chatState.sessionStarted && !chatState.sessionTerminated) {
        chatController.endSession();
      }
    } else {
      if (chatState.sessionTerminated) {
        chatController.resetState();
        chatController.init();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: Consumer(
        builder: (context, ref, child) {
          globalRef = ref;
          return GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: MaterialApp.router(
              routerConfig: ref.read(routerProvider),
              theme: ThemeData(
                fontFamily: 'Poppins',
                colorScheme: const ColorScheme.light(
                  primary: Colors.white,
                  secondary: Colors.white,
                ),
                textSelectionTheme: TextSelectionThemeData(
                  cursorColor: Colors.white,
                  selectionColor: Colors.white.withOpacity(0.4),
                  selectionHandleColor: Colors.white,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
