import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pharmacy/home.dart';
import 'package:pharmacy/model/doctors.dart';
import 'package:http/http.dart' as http;

class add_company extends StatefulWidget {
  const add_company({super.key});

  @override
  State<add_company> createState() => _add_companyState();
}

class _add_companyState extends State<add_company> {
  TextEditingController name = TextEditingController();
  TextEditingController doctorId = TextEditingController();
  TextEditingController repName = TextEditingController();
  TextEditingController repContact = TextEditingController();
  TextEditingController supplyAddress = TextEditingController();

    final String postCompany =
      'https://pharmacy-project-spring-3.onrender.com/company';

  Future<void> postdata() async {
    var reqBody = {
      "name": name.text,
      "doctorID": doctorId.text,
      "representativeName": repName.text,
      "representativeContact": repContact.text,
      "supplyAddress": supplyAddress.text
    };
    var response = await http.post(Uri.parse(postCompany),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody));
    var jsonResponse = jsonDecode(response.body);
    print(jsonResponse);
    print(response.statusCode);
  }

  List<Doctors>? doctorModel; // Removed 'late' modifier

  final String getDoctor =
      'https://pharmacy-project-spring-3.onrender.com/doctor';

  _getData() async {
    try {
      var response = await http.get(Uri.parse(getDoctor),
          headers: {"Content-Type": "application/json"});
      if (response.statusCode == 200) {
        setState(() {
          doctorModel = usersFromJson(response.body);
        });
      } else {
        throw Exception('Failed to load doctor list');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal[400],
          title: const Text("ADD COMPANY"),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications,
                color: Colors.black,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.logout,
                  color: Colors.black,
                ),
              ),
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
                        borderSide:
                            BorderSide(color: Colors.teal, width: 2.0),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.teal, width: 2.0),
                      ),
                      fillColor: Colors.teal[100],
                      filled: true,
                      border: const OutlineInputBorder(),
                      labelText: 'Company Name',
                      labelStyle:
                          const TextStyle(color: Colors.black, fontSize: 20.0),
                      prefixIcon: const Icon(Icons.medication),
                    ),
                  ),
                ),

                // Other form fields
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: DropdownButtonFormField(
                    value: null,
                    hint: const Text(
                        'Select Doctor'), // Displayed when no item is selected
                    items: doctorModel?.map((doctor) {
                          return DropdownMenuItem(
                            value: doctor.id,
                            child: Text(doctor.name ?? ''),
                          );
                        }).toList() ??
                        [], // Use doctorModel to populate dropdown items
                    onChanged: (value) {
                      // Handle dropdown value change
                      setState(() {
                        doctorId.text = value.toString();
                      });
                    },
                  ),
                ),
                // Other form fields

                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: TextField(
                    controller: repName,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.teal, width: 2.0),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.teal, width: 2.0),
                      ),
                      fillColor: Colors.teal[100],
                      filled: true,
                      border: const OutlineInputBorder(),
                      labelText: 'Representative\'s Name',
                      labelStyle:
                          const TextStyle(color: Colors.black, fontSize: 20.0),
                      prefixIcon: const Icon(Icons.production_quantity_limits),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: TextField(
                    controller: repContact,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.teal, width: 2.0),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.teal, width: 2.0),
                      ),
                      fillColor: Colors.teal[100],
                      filled: true,
                      border: const OutlineInputBorder(),
                      labelText: 'Representative\'s Contact',
                      labelStyle:
                          const TextStyle(color: Colors.black, fontSize: 20.0),
                      prefixIcon: const Icon(Icons.attach_money),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: TextField(
                    controller: supplyAddress,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.teal, width: 2.0),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.teal, width: 2.0),
                      ),
                      fillColor: Colors.teal[100],
                      filled: true,
                      border: const OutlineInputBorder(),
                      labelText: 'Supply Address',
                      labelStyle:
                          const TextStyle(color: Colors.black, fontSize: 20.0),
                      prefixIcon: const Icon(Icons.attach_money),
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
      ),
    );
  }
}
