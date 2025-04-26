class PatientModel {
  final String? id;
  final String? name;
  final String dni;
  final String? appointmentDate;
  final String? telephone;

  PatientModel({
    this.id,
    this.name,
    required this.dni,
    this.appointmentDate,
    this.telephone,
  });

  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return PatientModel(
      id: json['id']?.toString(),
      name: json['name'],
      dni: json['dni'].toString(), // Convertir a String
      appointmentDate: json['appointmentDate'],
      telephone: json['telephone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'dni': dni,
      'appointmentDate': appointmentDate,
      'telephone': telephone,
    };
  }
}