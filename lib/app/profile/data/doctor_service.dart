import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mobile_application/app/profile/data/doctor_model.dart';

class DoctorService {
  Future<DoctorModel?> getDoctor(String idDoctor) async {
    try {
      final url = Uri.parse(
        'https://retoolapi.dev/J7VynP/doctors/$idDoctor',
      );
      http.Response response = await http.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == HttpStatus.ok) {
        Map<String, dynamic> json = jsonDecode(response.body);
        return DoctorModel.fromJson(json);
      } else if (response.statusCode == HttpStatus.notFound) {
        print('Error 404: Doctor no encontrado');
      }
    } catch (e) {
      print('Error fetching doctor: $e');
    }
    return null;
  }

  Future<bool> updateDoctor(String idDoctor, {
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final url = Uri.parse(
        'https://retoolapi.dev/J7VynP/doctors/$idDoctor',
      );
      final requestBody = jsonEncode({
        'email': email,
        'password': password,
        'name': name,
      });

      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: requestBody,
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      return response.statusCode == HttpStatus.ok ||
          response.statusCode == HttpStatus.noContent;
    } catch (e) {
      print('Error updating doctor: $e');
      return false;
    }
  }
}