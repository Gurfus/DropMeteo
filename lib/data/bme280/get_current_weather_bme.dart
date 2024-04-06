

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:radarweather/firebase_options.dart';
import 'package:radarweather/model/bme280/bmeWeather.dart';



class GetCurrentWeatherBme {
  
  BmeWeather? bmeWeather;



  Future<BmeWeather?> getCurrentWeatherBme() async {
   
     final firebaseApp = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('STJABDS01/').get();
    
      if (snapshot.exists) {
        final dynamicValue = snapshot.value as Map<dynamic, dynamic>;
        print(snapshot.value);
        final convertedValue = Map<String, dynamic>.from(dynamicValue);
        bmeWeather = BmeWeather.fromJson(convertedValue);
        return bmeWeather;
      } else {
        return null;
      }
   
  }


  BmeWeather getBme280Weather() =>
      BmeWeather(
        fecha: bmeWeather?.fecha,
        temperatura: bmeWeather?.temperatura,
        humedad: bmeWeather?.humedad,
        hora: bmeWeather?.hora,
        presion: bmeWeather?.presion,
        epochTime: bmeWeather?.epochTime
      );
}
