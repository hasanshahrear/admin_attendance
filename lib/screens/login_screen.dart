import 'dart:convert';

import 'package:admin_attendance/screens/home_screen.dart';
import 'package:admin_attendance/services/api.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  _LoginScreenState createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  late String errorText = "";
  final apiClient = ApiClient();

  Future<void> login(String phone, String password) async {
    try{
      final response = await apiClient.login(phone, password);

      if(response.statusCode == 200){
        final responseBody = jsonDecode(response.body);
        final token = responseBody['token'];
        // final location = responseBody['location'];
        // final user = responseBody['user'];
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('token', token);
        // prefs.setString('location', jsonEncode(location));
        // prefs.setString('user', jsonEncode(user));
        print(token);
        // print(location);
        // print(user);
        setState(() {
          errorText="success";
        });
        print("success");
         Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => HomeScreen(),
            ),
          );
      }else {
        // Login failed
        throw Exception('Failed to login: ${response.statusCode}');

      }
    }catch(e){
      setState(() {
        errorText=e.toString();
      });
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context){
    return (
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Column(
            children:  <Widget>[
              TextFormField(
                controller: phoneController,
                obscureText: false,
                // keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Phone Number',
                ),
              ),
              const SizedBox(height: 25.0),
               TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Password',
                ),
              ),
              const SizedBox(height: 25.0),
              Text(errorText),
              MaterialButton(
                onPressed:() { login(phoneController.text.toString(), passwordController.text.toString());},
                minWidth: double.infinity,
                color: Colors.blue,
                height: (50.0),
                textColor: Colors.white,
                child: const Text("LOGIN"),
              )

            ],
          ),
        )
    );
  }
}