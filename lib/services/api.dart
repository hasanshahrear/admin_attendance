import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

const baseUrl = 'http://192.168.0.101:5000/api';

class ApiClient {
  late String token;
  ApiClient() {
    getToken();
  }

  getToken() async{
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token').toString();
  }

  // fetch all get request
  Future<http.Response> get(String endpoint) async {
    return http.get(baseUrl + endpoint);
  }

  // fetch all post request
  Future<http.Response> post(String endpoint, {required Map<String, String> headers, body}) async {
    return http.post(baseUrl + endpoint, headers: headers, body: body);
  }

  // login url
  Future<http.Response> login(String phone, String password) async {
    final response = await post('/admin-login',
      headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'phone': phone,
        'password': password
      })
    );
    return response;
  }

  // add district
  Future<http.Response> addDistrictApi(String districtName) async {
    final response = await post('/district',
      headers: <String, String>{
        "Authorization": "Bearer $token",
      },
      body:  {
        "district_name": districtName,
      }
    );
    return response;
  }

  // add sub district
  Future<http.Response> addSubDistrictApi(String subDistrictName) async {
    final response = await post('/sub-district',
        headers: <String, String>{
          "Authorization": "Bearer $token",
        },
        body:  {
          "sub_district_name": subDistrictName,
        }
    );
    return response;
  }

  Future<void> checkIn(distanceInMeters) async {
    await post('/check-in',
        headers: <String, String>{
          "Authorization": "Bearer $token",
        },
        body: {
          "status": "presentAppdd",
          "remarks": "beepteep",
          "distance": distanceInMeters.toInt().toString()
        }
    );
  }

  Future<void> checkOut(distanceInMeters) async {
    await post('/check-out',
        headers: <String, String>{
          "Authorization": "Bearer $token",
        },
        body: {
          "distance": distanceInMeters.toInt().toString()
        }
    );
  }

   Future<http.Response> getOfficeLocationApi() async {
     return await http.get('$baseUrl/get-location',
        headers: <String, String>{
          "Authorization": "Bearer $token",
        },
    );
  }

  Future<http.Response> getEmployeeReportApi() async {
    await getToken();
    return await http.get('$baseUrl/employee-report',
      headers: <String, String>{
        "Authorization": "Bearer $token",
      },
    );
  }

}