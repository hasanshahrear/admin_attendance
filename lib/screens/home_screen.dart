import 'dart:convert';
import 'package:admin_attendance/screens/district_screen.dart';
import 'package:admin_attendance/screens/login_screen.dart';
import 'package:admin_attendance/screens/sub_district_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late double longitude = 0.0;
  late double latitude = 0.0;

  late double offLongitude = 0.0;
  late double offLatitude = 0.0;
  late double distanceInMeters = 0.0;
  late bool isSetLocation = false;

  // user info
  late String firstName = "";
  late String lastName = "";
  late String designation = "";
  late String phone = "";
  late String officeAddress = "";

  // final apiClient = ApiClient();

  @override
  void initState() {
    super.initState();
  }


  Future<void> addDistrict(BuildContext context) async{
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => District())
    );
  }
  Future<void> addSubDistrict(BuildContext context) async{
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => SubDistrict())
    );
  }

  // logout
  Future<void> logout(BuildContext context) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("token");
    final success = await prefs.remove("location");
    if(success){
      Navigator.of(context).pop(
        MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Dashboard", style: TextStyle(color: Colors.black),),
             
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Welcome"),
              ElevatedButton(
                onPressed: () {
                  addDistrict(context);
                },
                child: Text('Add District', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue, // Use your app's primary color here
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // Adjust the radius as needed
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  addSubDistrict(context);
                },
                child: Text('Add Sub District', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue, // Use your app's primary color here
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // Adjust the radius as needed
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  logout(context);
                },
                child: Text('Log out', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue, // Use your app's primary color here
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // Adjust the radius as needed
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


