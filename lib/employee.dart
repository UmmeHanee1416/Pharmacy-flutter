import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pharmacy/home.dart';
import 'package:http/http.dart' as http;
import 'package:pharmacy/model/employeeDetails.dart';

class add_employee extends StatefulWidget {
  const add_employee({super.key});

  @override
  State<add_employee> createState() => _add_employeeState();
}

class _add_employeeState extends State<add_employee> {
  TextEditingController name = TextEditingController();
  TextEditingController education = TextEditingController();
  TextEditingController experience = TextEditingController();
  TextEditingController reference = TextEditingController();
  TextEditingController pAddress = TextEditingController();
  TextEditingController cAddress = TextEditingController();
  TextEditingController fMembers = TextEditingController();

  final String postEmpDetails =
      'https://pharmacy-project-spring-3.onrender.com/empdet';
  final String getEmpDetails =
      'https://pharmacy-project-spring-3.onrender.com/empdet';
  List<EmployeeDetails>? productModel;
  final String postEmp = 'https://pharmacy-project-spring-3.onrender.com/emp';

  Future<void> postdata() async {
    var reqBody = {
      "permanentAdd": pAddress.text,
      "currentAdd": cAddress.text,
      "familyMembers": fMembers.text
    };
    var response = await http.post(Uri.parse(postEmpDetails),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody));
    try {
      var response = await http.get(Uri.parse(getEmpDetails),
          headers: {"Content-Type": "application/json"});
      if (response.statusCode == 200) {
        setState(() {
          productModel = empDetailFromJson(response.body);
        });
      } else {
        throw Exception('Failed to load doctor list');
      }
    } catch (e) {
      print(e);
    }
    var empBody = {
      "name": name.text,
      "experience": experience.text,
      "education": education.text,
      "employeeDetail": productModel!.length,
      "reference": reference.text
    };
    var responseEmp = await http.post(Uri.parse(postEmp),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(empBody));
    var jsonResponse = jsonDecode(response.body);
    var jsonResponseEmp = jsonDecode(responseEmp.body);
    print(jsonResponse);
    print(jsonResponseEmp);
    print(response.statusCode);
    print(jsonResponseEmp.statusCode);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[400],
        title: const Text("ADD EMPLOYEE"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications,
                color: Colors.black,
              )),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.logout,
                  color: Colors.black,
                )),
          ),
        ],
      ),
      drawer: const drawer(),
      backgroundColor: Colors.teal[100],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: TextField(
                  controller: name,
                  decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal, width: 2.0),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal, width: 2.0),
                    ),
                    fillColor: Colors.teal[100],
                    filled: true,
                    border: const OutlineInputBorder(),
                    labelText: 'Name',
                    labelStyle:
                        const TextStyle(color: Colors.black, fontSize: 20.0),
                    prefixIcon: const Icon(Icons.person),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: TextField(
                  controller: experience,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal, width: 2.0),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal, width: 2.0),
                    ),
                    fillColor: Colors.teal[100],
                    filled: true,
                    border: const OutlineInputBorder(),
                    labelText: 'Experience',
                    labelStyle:
                        const TextStyle(color: Colors.black, fontSize: 20.0),
                    prefixIcon: const Icon(Icons.numbers),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: TextField(
                  controller: education,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal, width: 2.0),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal, width: 2.0),
                    ),
                    fillColor: Colors.teal[100],
                    filled: true,
                    border: const OutlineInputBorder(),
                    labelText: 'Education',
                    labelStyle:
                        const TextStyle(color: Colors.black, fontSize: 20.0),
                    prefixIcon: const Icon(Icons.numbers),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: TextField(
                  controller: pAddress,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal, width: 2.0),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal, width: 2.0),
                    ),
                    fillColor: Colors.teal[100],
                    filled: true,
                    border: const OutlineInputBorder(),
                    labelText: 'Permanent Address',
                    labelStyle:
                        const TextStyle(color: Colors.black, fontSize: 20.0),
                    prefixIcon: const Icon(Icons.home),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: TextField(
                  controller: cAddress,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal, width: 2.0),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal, width: 2.0),
                    ),
                    fillColor: Colors.teal[100],
                    filled: true,
                    border: const OutlineInputBorder(),
                    labelText: 'Current Address',
                    labelStyle:
                        const TextStyle(color: Colors.black, fontSize: 20.0),
                    prefixIcon: const Icon(Icons.home_work),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: TextField(
                  controller: reference,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal, width: 2.0),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal, width: 2.0),
                    ),
                    fillColor: Colors.teal[100],
                    filled: true,
                    border: const OutlineInputBorder(),
                    labelText: 'Reference',
                    labelStyle:
                        const TextStyle(color: Colors.black, fontSize: 20.0),
                    prefixIcon: const Icon(Icons.person_pin),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: TextField(
                  controller: fMembers,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal, width: 2.0),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal, width: 2.0),
                    ),
                    fillColor: Colors.teal[100],
                    filled: true,
                    border: const OutlineInputBorder(),
                    labelText: 'Family Members',
                    labelStyle:
                        const TextStyle(color: Colors.black, fontSize: 20.0),
                    prefixIcon: const Icon(Icons.person_3),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: OutlinedButton(
                  onPressed: () {
                    postdata();
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.teal[700],
                    side: const BorderSide(color: Colors.teal),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50.0),
                    child: Text('ADD'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
