import 'package:alicia/core/common/widgets/shimmer_skelton.dart';
import 'package:alicia/core/config/style/colors.dart';
import 'package:alicia/features/home/models/day.dart';
import 'package:alicia/features/home/providers/home_provider.dart';
import 'package:alicia/features/home/widgets/alicia_fab.dart';
import 'package:alicia/features/home/widgets/day_card.dart';
import 'package:alicia/features/home/widgets/mood_counter.dart';
import 'package:alicia/features/home/widgets/report_button.dart';
import 'package:alicia/features/home/widgets/report_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) { 
      ref.read(homeProvider.notifier).init();
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isHomeLoading = ref.watch(homeProvider).isLoading;
    final homePageProvider = ref.read(homeProvider);
    return Scaffold(
      floatingActionButton: const AliciaFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            child: Image.asset('assets/images/png/bottom_white_blur.png'),
          ),
          Positioned(
            top: 0,
            child: Image.asset('assets/images/png/top_white_blur.png'),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    isHomeLoading? ShimmerSkelton(height: 30, width: double.infinity) :
                    RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.displayLarge,
                        children: [
                          TextSpan(
                            text: 'Bienvenido de nuevo, ',
                            style:
                                TextStyle(color: AliciaColors.darkText, fontSize: 25, fontFamily: 'Poppins'),
                          ),
                          TextSpan(
                            text: homePageProvider.userName,
                            style: TextStyle(
                                color: AliciaColors.darkText,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: Day.values
                              .map((day) => Padding(
                                    padding: const EdgeInsets.only(right: 8.0, top: 8),
                                    child: DayCard(
                                        day: day,
                                        dayNumber: day.index + 2,
                                        filled: daysFilledMockedMap[day]!),
                                  ))
                              .toList(),
                        )),
                    const SizedBox(height: 30),
                    RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.displayLarge!,
                        children: [
                          TextSpan(
                            text: 'Últimos ',
                            style: TextStyle(
                              color: AliciaColors.darkText,
                              fontSize: 22,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          TextSpan(
                            text: '30 días',
                            style: TextStyle(
                              color: AliciaColors.darkText,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    Opacity(
                      opacity: 0.75,
                      child: RichText(
                        text: TextSpan(
                          style: Theme.of(context).textTheme.displayLarge,
                          children: [
                            TextSpan(
                              text: 'Basado en tu conversación con ',
                              style: TextStyle(
                                color: AliciaColors.darkText,
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            TextSpan(
                              text: 'Alicia',
                              style: TextStyle(
                                color: AliciaColors.darkText,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    MoodCounter(isLoading: isHomeLoading),
                    const SizedBox(height: 25),
                    Divider(
                        thickness: 1,
                        color: AliciaColors.darkText.withOpacity(0.25),
                        height: 1.5,
                        indent: 65,
                        endIndent: 65),
                    const SizedBox(height: 25),
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Tus informe personal",
                            style: TextStyle(
                              color: AliciaColors.darkText,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Opacity(
                            opacity: 0.7,
                            child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  style: Theme.of(context).textTheme.displayLarge,
                                  children: [
                                    TextSpan(
                                      text: 'El resumen de tus ',
                                      style: TextStyle(
                                        color: AliciaColors.darkText,
                                        height: 1.4,
                                        fontSize: 17,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'últimas sesiones',
                                      style: TextStyle(
                                        color: AliciaColors.darkText,
                                        height: 1.4,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' y la descripción de tu ',
                                      style: TextStyle(
                                        color: AliciaColors.darkText,
                                        fontSize: 17,
                                        height: 1.4,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'personalidad',
                                      style: TextStyle(
                                        color: AliciaColors.darkText,
                                        height: 1.4,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ', al alcance de ',
                                      style: TextStyle(
                                        color: AliciaColors.darkText,
                                        height: 1.4,
                                        fontSize: 17,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'tu mano',
                                      style: TextStyle(
                                        color: AliciaColors.darkText,
                                        height: 1.4,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                          const SizedBox(height: 20),
                          const ReportButton()
                        ],
                      ),
                    ),
                    const SizedBox(height: 90),
                  ],
                ),
              ),
            ),
          ),
          if (ref.watch(homeProvider).isGeneratingReport) Positioned(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: AliciaColors.backgroundGray.withOpacity(0.6),
              child: Center(
                child: CircularProgressIndicator(
                  color: AliciaColors.lightPurple,
                )
              ),
            ),),
        ],
      ),
    );
  }
}
