import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:patient_registration_flutter/patient_entity.dart';
import '../util/api_response.dart';
import '../util/url.dart';

class PatientService {
  final String apiUrl = '${ApiURL.baseURL}/api/patients';

  Future<ApiResponse> getAllPatients() async {
    try {
      final response = await http.get(Uri.parse('$apiUrl/list'));
      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse.fromJson(json.decode(response.body));
      } else {
        return ApiResponse(successful: false, message: 'Failed to load patients');
      }
    } catch (e) {
      return ApiResponse(successful: false, message: e.toString());
    }
  }

  Future<ApiResponse> savePatient(Patient patient, {File? imageFile}) async {
    var uri = Uri.parse('$apiUrl/save');
    var request = http.MultipartRequest('POST', uri);

    request.fields['patient'] = json.encode(patient.toJson());

    if (imageFile != null) {
      var stream = http.ByteStream(imageFile.openRead());
      var length = await imageFile.length();
      var multipartFile = http.MultipartFile('imageFile', stream, length,
          filename: basename(imageFile.path));
      request.files.add(multipartFile);
    }

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return ApiResponse.fromJson(json.decode(response.body));
    } else {
      return ApiResponse(successful: false, message: 'Failed to save patient');
    }
  }

  Future<ApiResponse> updatePatient(Patient patient, {File? imageFile}) async {
    var uri = Uri.parse('$apiUrl/update');
    var request = http.MultipartRequest('PUT', uri);

    request.fields['updatedPatient'] = json.encode(patient.toJson());

    if (imageFile != null) {
      var stream = http.ByteStream(imageFile.openRead());
      var length = await imageFile.length();
      var multipartFile = http.MultipartFile('imageFile', stream, length,
          filename: basename(imageFile.path));
      request.files.add(multipartFile);
    }

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return ApiResponse.fromJson(json.decode(response.body));
    } else {
      return ApiResponse(successful: false, message: 'Failed to update patient');
    }
  }

  Future<ApiResponse> deletePatientById(int id) async {
    try {
      final response = await http.delete(Uri.parse('$apiUrl/delete/$id'));
      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse.fromJson(json.decode(response.body));
      } else {
        return ApiResponse(successful: false, message: 'Failed to delete patient');
      }
    } catch (e) {
      return ApiResponse(successful: false, message: e.toString());
    }
  }

  Future<ApiResponse> getPatientById(int id) async {
    try {
      final response = await http.get(Uri.parse('$apiUrl/$id'));
      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse.fromJson(json.decode(response.body));
      } else {
        return ApiResponse(successful: false, message: 'Failed to fetch patient');
      }
    } catch (e) {
      return ApiResponse(successful: false, message: e.toString());
    }
  }
}
