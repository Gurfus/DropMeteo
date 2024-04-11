class BmeWeather {
    String? fecha;
    String? hora;
    double? humedad;
    double? presion;
    double? temperatura;
    String? epochTime;

    BmeWeather({
         this.fecha,
         this.hora,
         this.humedad,
         this.presion,
         this.temperatura,
         this.epochTime
    });

    factory BmeWeather.fromJson(Map<String, dynamic> json) => BmeWeather(
        fecha: json["Fecha"],
        hora: json["Hora"],
        humedad: json["Humedad"]?.toDouble(),
        presion: json["Presion"]?.toDouble(),
        temperatura: json["Temperatura"]?.toDouble(),
        epochTime: json["EpochTime"],
    );

    Map<String, dynamic> toJson() => {
        "Fecha": fecha,
        "Hora": hora,
        "Humedad": humedad,
        "Presion": presion,
        "Temperatura": temperatura,
        "EpochTime":epochTime,
    };

    BmeWeather getBme280Weather() =>
      BmeWeather(
        fecha: fecha,
        temperatura: temperatura,
        humedad:humedad,
        hora: hora,
        presion: presion,
        epochTime: epochTime
      );
}