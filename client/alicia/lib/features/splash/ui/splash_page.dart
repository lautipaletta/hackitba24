import 'dart:async';
import 'package:alicia/core/assets/assets.dart';
import 'package:alicia/core/common/repositories/hive_repository.dart';
import 'package:alicia/core/config/routes/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _fadeController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1100),
      vsync: this,
    );

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 3.5), // Comienza desde abajo
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeInOutBack,
    ));

    _fadeAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(_fadeController);

    _slideController.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        await Future.delayed(const Duration(milliseconds: 800));
        _fadeController.forward();
      }
    });

    Timer(const Duration(milliseconds: 2500), () async {
      final result = await ref
          .read(hiveRepositoryProvider)
          .read(boxName: AliciaHiveBox.ALICIA_BOX, key: AliciaHiveBox.HAS_LOGGED_IN);

      if (result != null && (result.isLeft || (result.isRight && (result.right as bool?) == true))) {
        context.pushNamed(Routes.home.name);
      } else {
        context.pushNamed(Routes.auth.name);
      }
    });

    _slideController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: SvgPicture.asset(
              Assets.alicia,
              width: MediaQuery.of(context).size.width * 0.4,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _slideController.dispose();
    _fadeController.dispose();
    super.dispose();
  }
}
