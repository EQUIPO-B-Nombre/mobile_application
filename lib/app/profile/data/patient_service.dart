import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mobile_application/app/profile/data/patient_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PatientService {
  Future<List<PatientModel>> getPatients() async {
    try {
      final url = Uri.parse(
        'https://oncontigo-api.free.beeceptor.com/api/v1/patients',
      );
      http.Response response = await http.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == HttpStatus.ok) {
        List<dynamic> json = jsonDecode(response.body);
        return json.map((map) => PatientModel.fromJson(map)).toList();
      } else if (response.statusCode == HttpStatus.unauthorized) {
        print('Error 401: No autorizado');
      }
    } catch (e) {
      print('Error fetching patients: $e');
    }
    return [];
  }

  Future<PatientModel?> getPatientById(String id) async {
    try {
      final url = Uri.parse(
        'https://retoolapi.dev/TYYPRe/patients/$id',
      );
      http.Response response = await http.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == HttpStatus.ok) {
        Map<String, dynamic> json = jsonDecode(response.body);
        return PatientModel.fromJson(json);
      } else if (response.statusCode == HttpStatus.notFound) {
        print('Error 404: Paciente no encontrado');
      }
    } catch (e) {
      print('Error fetching patient: $e');
    }
    return null;
  }

  Future<bool> postPatient(PatientModel patient) async {
    try {
      final url = Uri.parse(
        'https://oncontigo-api.free.beeceptor.com/api/v1/patients',
      );
      final requestBody = jsonEncode(patient.toJson());

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: requestBody,
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      return response.statusCode == HttpStatus.ok ||
          response.statusCode == HttpStatus.created;
    } catch (e) {
      print('Error posting patient: $e');
      return false;
    }
  }

  Future<bool> deletePatient(String id) async {
    try {
      final url = Uri.parse(
        'https://oncontigo-api.free.beeceptor.com/api/v1/patients/$id',
      );

      final response = await http.delete(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      return response.statusCode == HttpStatus.ok ||
          response.statusCode == HttpStatus.noContent;
    } catch (e) {
      print('Error deleting patient: $e');
      return false;
    }
  }

  Future<bool> updatePatient(PatientModel patient) async {
    try {
      final url = Uri.parse(
        'https://retoolapi.dev/TYYPRe/patients/${patient.id}',
      );
      final requestBody = jsonEncode(patient.toJson());

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
      print('Error updating patient: $e');
      return false;
    }
  }


  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt_token');
  }
}