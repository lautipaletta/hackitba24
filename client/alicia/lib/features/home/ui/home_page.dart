import 'package:alicia/core/config/routes/router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text('Home Page'),
            ElevatedButton(
              onPressed: () {
                context.pushNamed(Routes.chat.name);
              },
              child: Text('Login'),
            ),
          ],
        ))
    );
  }
}
