import 'package:alicia/core/config/routes/router.dart';
import 'package:alicia/core/config/style/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class AliciaFab extends StatelessWidget {
  const AliciaFab({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.pushNamed(Routes.chat.name),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            bottom: 18,
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: AliciaColors.accentPurple,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: SvgPicture.asset('assets/images/svg/chat_icon.svg', height: 50, width: 50),
              ),
            ),
          ),
          SvgPicture.asset('assets/images/svg/alicia_fab.svg')
        ],
      ),
    );
  }
}
