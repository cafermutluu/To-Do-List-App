import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/models/color_theme_data.dart';
import 'package:to_do_list/models/duty_data.dart';
import 'package:to_do_list/screens/home_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ColorThemeData().createSharedPrefObject();
  await DutyData().createPrefObject();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<DutyData>(create: (context) => DutyData()),
    ChangeNotifierProvider<ColorThemeData>(
        create: (context) => ColorThemeData()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<DutyData, ColorThemeData>(builder: (BuildContext context,
        DutyData dutyData, ColorThemeData colorThemeData, child) {
      dutyData.loadDutiesFromSharedPref();
      colorThemeData.loadSharedPrefObject();

      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Provider.of<ColorThemeData>(context).selectedThemeData,
        home: const SplashScreenWidget(),
      );
    });
  }
}

class SplashScreenWidget extends StatelessWidget {
  const SplashScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      nextScreen: const HomePage(),
      splash: 'assets/splash_screen_2.jpg',
      backgroundColor: Colors.white24,
      splashTransition: SplashTransition.scaleTransition,
      animationDuration:const Duration(seconds: 2),
      duration: 250,
      curve: Curves.ease,
    );
  }
}

