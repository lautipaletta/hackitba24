import 'package:alicia/core/assets/assets.dart';
import 'package:alicia/core/common/repositories/hive_repository.dart';
import 'package:alicia/core/common/widgets/alicia_textfield.dart';
import 'package:alicia/core/config/routes/router.dart';
import 'package:alicia/core/config/style/colors.dart';
import 'package:alicia/features/auth/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AuthPage extends ConsumerStatefulWidget {
  AuthPage({super.key});

  @override
  ConsumerState<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends ConsumerState<AuthPage> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
    });
  }
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    bool hasError = false;
    nameController.addListener(() {
      if (hasError) {
        formKey.currentState!.validate();
      }
    });
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          if (ref.watch(authProvider).isLoading) ...[
            const Positioned.fill(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          ],
          Positioned(
            top: 0,
            child: Image.asset(Assets.helloBlur),
          ),
          Positioned(bottom: 0, child: Image.asset(
            Assets.helloBlueBlur,
            color: Color.fromRGBO(255, 255, 255, 0.5), // Cambia la opacidad aquí
  colorBlendMode: BlendMode.modulate,)),
          Positioned(top: 300, right: 0, child: Image.asset(Assets.circle)),
          Positioned(bottom: 40, left: 0, child: Image.asset(Assets.circles)),
          Positioned(bottom: 120, right: 20, child: Image.asset(Assets.moods)),
          Padding(
            padding: const EdgeInsets.only(top: 55, left: 25, right: 25, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      "¡Hola!",
                      style: TextStyle(fontSize: 22),
                    ),
                    const SizedBox(width: 10),
                    Image.asset(Assets.hello, height: 26)
                  ],
                ),
                RichText(
                    text: TextSpan(
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 17, color: AliciaColors.backgroundGray),
                        children: const [
                      TextSpan(text: "Bienvenido a "),
                      TextSpan(
                          text: "Alicia",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: ": tu nueva terapeuta"),
                    ])),
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 80),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          RichText(
                              text: TextSpan(
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(fontSize: 28),
                                  children: const [
                                TextSpan(text: "¿Cómo te"),
                                TextSpan(
                                    text: " llamas",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(text: "?"),
                              ])),
                          const SizedBox(height: 15),
                          RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          fontSize: 17,
                                          color: AliciaColors.backgroundGray),
                                  children: const [
                                    TextSpan(
                                        text:
                                            "Vas a tener sesiones completamente"),
                                    TextSpan(
                                        text: " personalizadas",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                        text:
                                            ", y luego podrás exportar tu reporte individual para contactar con"),
                                    TextSpan(
                                        text: " especialistas",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ])),
                          const SizedBox(height: 50),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6.0),
                                  child: RichText(
                                      textAlign: TextAlign.start,
                                      text: TextSpan(
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(fontSize: 16),
                                          children: const [
                                            TextSpan(text: "Mi"),
                                            TextSpan(
                                                text: " nombre",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            TextSpan(text: " es:"),
                                          ])),
                                ),
                                const SizedBox(height: 10),
                                Form(
                                  key: formKey,
                                  child: AliciaTextField(
                                      controller: nameController,
                                      validator: (value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return 'Ingrese un nombre válido';
                                        }
                                      },
                                      hintText: "Ingresá tu nombre"),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(
                            const Size(double.infinity, 65)),
                        backgroundColor: MaterialStateProperty.all(
                            AliciaColors.accentPurple),
                        padding:
                            MaterialStateProperty.all(const EdgeInsets.all(15)),
                        shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))))),
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        hasError = false;
                        final response = await ref.read(authProvider.notifier).signup(name: nameController.text);
                        if (response.isLeft) {
                          return;
                        }
                        final userId = ref.read(authProvider).userId!;
                        
                        var hiveResponse = await ref.read(hiveRepositoryProvider).write(
                            boxName: AliciaHiveBox.ALICIA_BOX,
                            key: AliciaHiveBox.USER_NAME,
                            value: nameController.text.trim());
                        if (response.isLeft) {
                          return;
                        }
                        hiveResponse = await ref.read(hiveRepositoryProvider).write(
                            boxName: AliciaHiveBox.ALICIA_BOX,
                            key: AliciaHiveBox.USER_ID,
                            value: userId
                        );
                        if (response.isLeft) {
                          return;
                        }
                        hiveResponse = await ref.read(hiveRepositoryProvider).write(
                            boxName: AliciaHiveBox.ALICIA_BOX,
                            key: AliciaHiveBox.HAS_LOGGED_IN,
                            value: true);
                            
                        if (response.isLeft) {
                          return;
                        }
                        print("Ok, nombre ingresado correctamente: ${nameController.text}");
                        context.pushNamed(Routes.home.name);
                      } else {
                        hasError = true;
                      }
                    },
                    child: const Text(
                      "Comenzar",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
