import 'dart:io';
import 'package:alicia/core/assets/assets.dart';
import 'package:alicia/core/config/style/colors.dart';
import 'package:alicia/features/chat/providers/chat_provider.dart';
import 'package:alicia/features/home/providers/home_provider.dart';
import 'package:alicia/core/utils/debouncer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:speech_to_text/speech_to_text.dart';

class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({super.key});

  @override
  ChatPageState createState() => ChatPageState();
}

class ChatPageState extends ConsumerState<ChatPage> with TickerProviderStateMixin {
  final _messageController = TextEditingController();

  final _messagesScrollController = ScrollController();

  bool textFieldEmpty = true;

  late SpeechToText _speech;
  late FlutterTts _flutterTts;
  bool _isListening = false;
  bool _isPlaying = false;
  late final AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 3));
    _speech = SpeechToText();

    _initTts();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(chatProvider.notifier).init();
      _scrollToEnd(millis: 0);
      _messageController.addListener(_handleMessageChange);
    });
    super.initState();
  }

  @override
  void dispose() {
    _messagesScrollController.dispose();
    _messageController.dispose();
    _controller.dispose();
    _speech.stop();
    _flutterTts.stop();
    super.dispose();
  }

  void _initTts() async {
    _flutterTts = FlutterTts();
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.awaitSpeakCompletion(true);
    await _flutterTts.setVolume(1.0);
    await _flutterTts.setPitch(1.0);
    await _flutterTts.setLanguage('es-ES');

    await _flutterTts.setSharedInstance(true);
    await _flutterTts.setIosAudioCategory(
      IosTextToSpeechAudioCategory.playback,
      [
        IosTextToSpeechAudioCategoryOptions.allowBluetooth,
        IosTextToSpeechAudioCategoryOptions.allowBluetoothA2DP,
        IosTextToSpeechAudioCategoryOptions.mixWithOthers,
        IosTextToSpeechAudioCategoryOptions.defaultToSpeaker
      ],
      IosTextToSpeechAudioMode.defaultMode,
    );

    _flutterTts.setStartHandler(() {
      setState(() {
        _isPlaying = true;
      });
    });

    _flutterTts.setCompletionHandler(() {
      setState(() {
        _isPlaying = false;
      });
    });

    _flutterTts.setErrorHandler((msg) {
      setState(() {
        _isPlaying = false;
      });
    });

    _flutterTts.setCancelHandler(() {
      setState(() {
        _isPlaying = false;
      });
    });

    _flutterTts.setPauseHandler(() {
      setState(() {
        _isPlaying = false;
      });
    });
  }

  void _scrollToTop() {
    _messagesScrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void _scrollToEnd({bool animate = true, int millis = 300}) {
    Future.delayed(
      Duration(milliseconds: millis),
      () {
        if (animate) {
          _messagesScrollController.animateTo(
            _messagesScrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        } else {
          _messagesScrollController.jumpTo(_messagesScrollController.position.maxScrollExtent);
        }
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
    final state = ref.watch(chatProvider);
    final controller = ref.read(chatProvider.notifier);
    return Scaffold(
      backgroundColor: AliciaColors.backgroundDarkGray,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: state.error == null
            ? state.isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: AliciaColors.backgroundWhite,
                      strokeCap: StrokeCap.round,
                    ),
                  )
                : Stack(
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
                              child: IconButton(
                                onPressed: () {
                                  ref.read(homeProvider.notifier).getAttendance();
                                  context.pop();
                                },
                                icon: Icon(
                                  Icons.arrow_back_ios_new,
                                  color: AliciaColors.backgroundGray,
                                ),
                              ),
                            ),
                            if (state.prevSessionId != null)
                              state.isLoadingMore
                                  ? Center(
                                      child: SizedBox(
                                        width: 15,
                                        height: 15,
                                        child: CircularProgressIndicator(
                                          color: AliciaColors.backgroundWhite,
                                          strokeWidth: 1.2,
                                          strokeCap: StrokeCap.round,
                                        ),
                                      ),
                                    )
                                  : Center(
                                      child: Material(
                                        color: AliciaColors.buttonPurple.withOpacity(0.4),
                                        borderRadius: BorderRadius.circular(100),
                                        child: InkWell(
                                          onTap: () async {
                                            await controller.loadMoreSessions();
                                            _scrollToTop();
                                          },
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
                                child: Column(
                                  children: [
                                    ...state.messages.map<Widget>(
                                      (element) {
                                        return Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Message(
                                              aliciaMessage: element.role == 'assistant',
                                              content: element.content,
                                            ),
                                            const SizedBox(height: 16),
                                          ],
                                        );
                                      },
                                    ),
                                    if (state.aliciaTyping)
                                      const Message(
                                        aliciaMessage: true,
                                        content: '',
                                        typing: true,
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
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
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
                                      if (_isPlaying) {
                                        await _flutterTts.stop();
                                        setState(() {
                                          _isPlaying = false;
                                        });
                                      }
                                      if (!textFieldEmpty && !_isListening) {
                                        final content = _messageController.text.trim();
                                        if (content.isEmpty) return;
                                        _messageController.clear();
                                        controller.addUserMessage(content: content);
                                        _scrollToEnd(millis: 50);
                                        final result = await controller.sendMessage(
                                          content: content,
                                        );
                                        _scrollToEnd(millis: 50);
                                        if (result.isRight) {
                                          await _flutterTts.speak(result.right);
                                        }
                                      } else {
                                        await _handlelisten();
                                      }
                                    },
                                    borderRadius: BorderRadius.circular(16),
                                    child: Container(
                                      height: 45,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: !textFieldEmpty && !_isListening
                                          ? Padding(
                                              padding: const EdgeInsets.fromLTRB(16, 0, 20, 0),
                                              child: Icon(
                                                FontAwesomeIcons.paperPlane,
                                                color: AliciaColors.backgroundWhite,
                                                size: 20,
                                              ),
                                            )
                                          : _isListening
                                              ? ColorFiltered(
                                                  colorFilter: ColorFilter.mode(
                                                    AliciaColors.backgroundWhite,
                                                    BlendMode.srcIn,
                                                  ),
                                                  child: Lottie.asset(
                                                    Assets.sttLottie,
                                                    controller: _controller,
                                                    repeat: true,
                                                    width: 60,
                                                  ),
                                                )
                                              : Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 12),
                                                  child: SvgPicture.asset(
                                                    Assets.voice,
                                                    width: 60,
                                                  ),
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
                  )
            : Center(
                child: Text(
                  'Error: ${state.error}',
                  style: TextStyle(
                    color: AliciaColors.backgroundWhite,
                    fontSize: 18,
                  ),
                ),
              ),
      ),
    );
  }

  Future<void> _handlelisten() async {
    final debouncer = Debouncer(milliseconds: 2500);
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        _controller.repeat();
        setState(() => _isListening = true);
        _speech.listen(
          localeId: "es_US",
          onResult: (val) {
            setState(() {
              _messageController.text = val.recognizedWords;
            });
            debouncer.run(() {
              _controller.stop();
              setState(() => _isListening = false);
              _speech.stop();
            });
          },
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
  const Message({super.key, required this.aliciaMessage, required this.content, this.typing = false});

  final bool aliciaMessage;
  final String content;
  final bool typing;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: aliciaMessage ? Alignment.centerLeft : Alignment.centerRight,
      child: SizedBox(
        width: (MediaQuery.of(context).size.width - 36) * 0.85,
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                if (typing) ...[
                  const SizedBox(height: 8),
                  Lottie.asset(
                    Assets.typing,
                    width: 50,
                  ),
                ] else ...[
                  Text(
                    content,
                    style: TextStyle(
                      color: AliciaColors.backgroundWhite,
                      fontSize: 14,
                    ),
                    textAlign: aliciaMessage ? TextAlign.left : TextAlign.right,
                  ),
                ]
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
