import 'package:admin_attendance/services/api.dart';
import 'package:flutter/material.dart';

class SubDistrict extends StatelessWidget{
  SubDistrict({super.key});
  final subDistrictController = TextEditingController();

  final apiClient = ApiClient();

 Future<void> getDistrictName() async{
   try{
     await apiClient.getToken();
     final response  = await apiClient.addSubDistrictApi(subDistrictController.text.toString());

     if(response.statusCode == 200){
       print(response.body);
     }
     print(response.body);
     print(subDistrictController.text.toString());
   }catch(e){

     print(e.toString());
   }
  }

  @override
  Widget build(BuildContext context){
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
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
            children: [
              TextFormField(
                controller: subDistrictController,
                obscureText: false,
                // keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Sub District Name',
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  getDistrictName();
                },
                child: Text('Add', style: TextStyle(color: Colors.white)),
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