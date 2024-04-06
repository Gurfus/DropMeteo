class EstadoCielo {
  final String? value;
  final String? periodo;
  final String? descripcion;

  EstadoCielo({
    this.value,
    this.periodo,
    this.descripcion,
  });

  factory EstadoCielo.fromJson(Map<String, dynamic> json) => EstadoCielo(
        value: json["value"],
        periodo: json["periodo"],
        descripcion: json["descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "periodo": periodo,
        "descripcion": descripcion,
      };
}
