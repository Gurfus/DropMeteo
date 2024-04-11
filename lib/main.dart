import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:radarweather/provider/search_provider.dart';
import 'package:radarweather/provider/weather_provider.dart';
import 'package:radarweather/screen/home/home_page.dart';

Future<void> main() async {
  await dotenv.load(fileName:".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RadarWeather',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          background: const Color.fromARGB(219, 70, 54, 255),
        ),
        useMaterial3: true,
      ),
      home: SafeArea(
        child: Container(
           decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 1, 26, 64),
                Color.fromARGB(255, 24, 143, 248)
              ],
              begin: Alignment.topLeft,
              end: Alignment.topRight,
            ),
          ),
          
            child: MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (_) => WeatherProvider()),
                ChangeNotifierProvider(create: (_) => SearchProvider())
              ],
              child: const HomePage(),
            ),
          ),
      ),
    );
  }
}
