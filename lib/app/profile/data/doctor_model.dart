class DoctorModel {
    DoctorModel({
        required this.email,
        required this.password,
        required this.name,
        required this.idDoctor,
    });

    final String email;
    final String password;
    final String name;
    final String idDoctor;

    factory DoctorModel.fromJson(Map<String, dynamic> json){ 
        return DoctorModel(
            email: json["email"] ?? "",
            password: json["password"] ?? "",
            name: json["name"] ?? "",
            idDoctor: json["idDoctor"] ?? "",
        );
    }

}
