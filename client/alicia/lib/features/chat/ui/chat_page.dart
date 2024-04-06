import 'dart:io';
import 'package:alicia/core/assets/assets.dart';
import 'package:alicia/core/config/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _messageController = TextEditingController();

  final _messagesScrollController = ScrollController();

  bool textFieldEmpty = true;

  late stt.SpeechToText _speech;
  bool _isListening = false;
  late final AnimationController _controller;


  @override
  void initState() {
    _speech = stt.SpeechToText();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 3));
    _controller.stop();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _messageController.addListener(_handleMessageChange);
      final locales = await _speech.locales();
      _scrollToEnd(millis: 0);
    });
    super.initState();
  }

  @override
  void dispose() {
    _messagesScrollController.dispose();
    _messageController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _scrollToEnd({int millis = 300}) {
    Future.delayed(
      Duration(milliseconds: millis),
      () {
        _messagesScrollController.animateTo(
          _messagesScrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      },
    );
  }

  void _handleMessageChange() {
    final text = _messageController.text.trim();
    if (textFieldEmpty && text.isNotEmpty) {
      setState(() {
        textFieldEmpty = false;
      });
    } else if (!textFieldEmpty && text.isEmpty) {
      setState(() {
        textFieldEmpty = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AliciaColors.backgroundDarkGray,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              child: Image.asset(
                Assets.purpleBlur,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: 
                    Lottie.asset(Assets.sttLottie, width: 30)
                    // IconButton(
                    //   onPressed: () => context.pop(),
                    //   icon: Icon(
                    //     Icons.arrow_back_ios_new,
                    //     color: AliciaColors.backgroundGray,
                    //   ),
                    // ),
                  ),
                  Center(
                    child: Material(
                      color: AliciaColors.buttonPurple.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(100),
                      child: InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(100),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Cargar ',
                                  style: TextStyle(
                                    color: AliciaColors.backgroundWhite,
                                    fontSize: 14,
                                  ),
                                ),
                                TextSpan(
                                  text: 'sesión anterior',
                                  style: TextStyle(
                                    color: AliciaColors.backgroundWhite,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      controller: _messagesScrollController,
                      child: const Column(
                        children: [
                          Message(
                            aliciaMessage: true,
                            content:
                                '¡Hola Lautaro! ¿Cómo venís después de la última sesión? ¿Pudiste charlar con tus amigos sobre lo que hablamos el viernes?',
                          ),
                          SizedBox(height: 24),
                          Message(
                            aliciaMessage: false,
                            content:
                                '¡Hola Alicia! Sí, pude hablar con mis amigos y me sentí muy bien. Me ayudó mucho lo que me dijiste.',
                          ),
                          SizedBox(height: 24),
                          Message(
                            aliciaMessage: true,
                            content:
                                '¡Qué bueno! Me alegra mucho saber que te ayudó. ¿Cómo te sentís ahora? ¿Hay algo que te gustaría hablar?',
                          ),
                          SizedBox(height: 24),
                          Message(
                            aliciaMessage: false,
                            content:
                                'Me siento mucho mejor, gracias. Sí, hay algo que me gustaría hablar. ¿Podemos hablar sobre cómo manejar la ansiedad?',
                          ),
                          SizedBox(height: 24),
                          Message(
                            aliciaMessage: true,
                            content:
                                '¡Claro! Vamos a hablar sobre eso. ¿Qué te parece si empezamos por hablar sobre qué es la ansiedad y cómo se manifiesta?',
                          ),
                          SizedBox(height: 24),
                          Message(
                            aliciaMessage: false,
                            content: '¡Me parece perfecto! Me gustaría saber más sobre eso.',
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 45,
                          child: TextField(
                            onTap: _scrollToEnd,
                            controller: _messageController,
                            style: TextStyle(
                              color: AliciaColors.backgroundWhite,
                              fontSize: 14,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Escribe un mensaje',
                              hintStyle: TextStyle(
                                color: AliciaColors.backgroundWhite,
                                fontSize: 14,
                              ),
                              fillColor: AliciaColors.backgroundGray,
                              filled: true,
                              contentPadding: const EdgeInsets.only(left: 16),
                              // isDense: true,
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AliciaColors.backgroundWhite.withOpacity(0.6),
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Material(
                        color: AliciaColors.buttonPurple,
                        borderRadius: BorderRadius.circular(16),
                        child: InkWell(
                          onTap: () async {
                            if (textFieldEmpty) {
                              await _handlelisten();
                            }
                          },
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            height: 45,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: !textFieldEmpty
                                ? Padding(
                                    padding: const EdgeInsets.fromLTRB(16, 0, 20, 0),
                                    child: Icon(
                                      FontAwesomeIcons.paperPlane,
                                      color: AliciaColors.backgroundWhite,
                                      size: 20,
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 12),
                                    child: Center(
                                      child: Lottie.asset(
                                        Assets.sttLottie,
                                        controller: _controller,
                                        repeat: true
                                        ),
                                    )
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  if (!Platform.isIOS) ...[
                    const SizedBox(
                      height: 15,
                    ),
                  ] else ...[
                    SizedBox(
                      height: MediaQuery.of(context).viewInsets.bottom > 50 ? 15 : 0,
                    ),
                  ]
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handlelisten() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        _controller.forward();
        setState(() => _isListening = true);
        _speech.listen(
          localeId: "es_US",
          onResult: (val) => setState(() {
            _messageController.text = val.recognizedWords;
          }),
        );
      }
    } else {
      _controller.stop();
      setState(() => _isListening = false);
      _speech.stop();
    }
  }
}

class Message extends StatelessWidget {
  const Message({super.key, required this.aliciaMessage, required this.content});

  final bool aliciaMessage;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: aliciaMessage ? Alignment.centerLeft : Alignment.centerRight,
      child: SizedBox(
        width: (MediaQuery.of(context).size.width - 36) * 0.85,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (aliciaMessage) ...[
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: SvgPicture.asset(
                  Assets.alicia,
                  width: 45,
                  height: 45,
                ),
              ),
              const SizedBox(width: 8),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: aliciaMessage ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    aliciaMessage ? 'Alicia' : 'Tú',
                    style: TextStyle(
                      color: AliciaColors.backgroundWhite,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    content,
                    style: TextStyle(
                      color: AliciaColors.backgroundWhite,
                      fontSize: 14,
                    ),
                    textAlign: aliciaMessage ? TextAlign.left : TextAlign.right,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
