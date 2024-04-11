import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

import 'package:radarweather/provider/weather_provider.dart';
import 'package:radarweather/screen/forecast/forecast.dart';

import 'package:radarweather/screen/search/search.dart';

import '../mapscreen/TileProvider/radarv2.dart';

class HomePage extends StatefulWidget {
  
  const HomePage({super.key});
  
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
   late Radarv2State radarState;
    @override
  void initState() {
    super.initState();
    // Encuentra el estado de Radarv2 utilizando la clave global
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final radarKey = GlobalKey<Radarv2State>();
      final radarStateCandidate = radarKey.currentState;
      if (radarStateCandidate != null) {
        radarState = radarStateCandidate;
        radarState.load();
      } else {
        // Manejar el caso en el que currentState sea nulo si es necesario
      }
    });
  }
  int _selectedItems = 0;
  final PageController _pageController =
      PageController(); // Agregar PageController

  WeatherProvider? weatherProvider;

  @override
  void dispose() {
    _pageController.dispose(); // Dispose del PageController
    weatherProvider?.positionStreamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      const Forecast(),
      const Radarv2(),
      const Search(),
    ];

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
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
      child: Scaffold(
        body: PageView(
          controller: _pageController, // Asignar el PageController
          children: screens, // Lista de widgets de las diferentes pestañas
          onPageChanged: (index) {
            setState(() {
              _selectedItems =
                  index; // Actualizar el índice seleccionado al cambiar de página
            });
          },
        ),
        backgroundColor: Colors.transparent,
        bottomNavigationBar: Container(
          margin: const EdgeInsets.only(bottom: 0,right: 20,left: 20,top: 20),
          child: GNav(
            selectedIndex: _selectedItems,
            rippleColor: const Color(0xFF2563eb),
            hoverColor: const Color(0xFF1d4ed8),
            haptic: true,
            tabBorderRadius: 15,
            tabActiveBorder: Border.all(color: const Color(0xFF1e3a8a), width: 1),
            tabBorder: Border.all(color: Colors.white70, width: 1),
            tabShadow: [
              BoxShadow(color: const Color(0xffbfdbfe).withOpacity(0.2), blurRadius: 8)
            ],
            curve: Curves.easeOutExpo,
            duration: const Duration(milliseconds: 900),
            gap: 8,
            color: Colors.black,
            activeColor: Colors.white70,
            iconSize: 24,
            tabBackgroundColor: Colors.blue.withOpacity(0.1),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            onTabChange: (index) {
              setState(() {
                _selectedItems = index;
                _pageController.jumpToPage(
                    index); // Cambiar directamente a la página seleccionada
              });
            },
            tabs: const [
              GButton(
                icon: LineIcons.home,
                iconColor: Colors.white70,
                text: 'Home',
              ),
              GButton(
                icon: LineIcons.broadcastTower,
                iconColor: Colors.white70,
                text: 'Radar',
              ),
              GButton(
                icon: LineIcons.search,
                iconColor: Colors.white70,
                text: 'Search',
              )
            ],
          ),
        ),
      ),
    );
  }
}
