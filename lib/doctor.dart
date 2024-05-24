import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pharmacy/home.dart';
import 'package:pharmacy/model/doctors.dart';
import 'package:http/http.dart' as http;

class add_doctor extends StatefulWidget {
  const add_doctor({super.key});

  @override
  State<add_doctor> createState() => _add_doctorState();
}

class _add_doctorState extends State<add_doctor> {
  TextEditingController name = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController specialty = TextEditingController();
  TextEditingController contact = TextEditingController();

  final String postDoctor =
      'https://pharmacy-spring.onrender.com/doctor';

  Future<void> postdata() async {
    var reqBody = {
      "name": name.text,
      "specialty": specialty.text,
      "address": address.text,
      "contact": contact.text
    };
    var response = await http.post(Uri.parse(postDoctor),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody));
    var jsonResponse = jsonDecode(response.body);
    print(jsonResponse);
    print(response.statusCode);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.teal[200],
        appBar: AppBar(
          backgroundColor: Colors.teal[400],
          title: const Text("ADD DOCTOR"),
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
                      labelText: 'Doctor\'s Name',
                      labelStyle:
                          const TextStyle(color: Colors.black, fontSize: 20.0),
                      prefixIcon: const Icon(Icons.person),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: TextField(
                    controller: address,
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
                      labelText: 'Address',
                      labelStyle:
                          const TextStyle(color: Colors.black, fontSize: 20.0),
                      prefixIcon: const Icon(Icons.room),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: TextField(
                    controller: specialty,
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
                      labelText: 'Specialty',
                      labelStyle:
                          const TextStyle(color: Colors.black, fontSize: 20.0),
                      prefixIcon: const Icon(Icons.checklist_sharp),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: TextField(
                    controller: contact,
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
                      labelText: 'Contact no.',
                      labelStyle:
                          const TextStyle(color: Colors.black, fontSize: 20.0),
                      prefixIcon: const Icon(Icons.phone),
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
                      child: Text('SAVE'),
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

class doctor_list extends StatefulWidget {
  const doctor_list({super.key});

  @override
  State<doctor_list> createState() => _doctor_listState();
}

class _doctor_listState extends State<doctor_list> {
  late List<Doctors>? doctorModel = [];

  final String getDoctor =
      'https://pharmacy-spring.onrender.com/doctor';

  void _getData() async {
    try {
      var response = await http.get(Uri.parse(getDoctor),
          headers: {"Content-Type": "application/json"});
      doctorModel = usersFromJson(response.body);
      Future.delayed(const Duration(seconds: 1))
          .then((value) => setState(() {}));
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
      backgroundColor: Colors.teal[200],
      appBar: AppBar(
        backgroundColor: Colors.teal[400],
        title: const Text("LIST OF DOCTORS"),
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
      body: ListView.builder(
          itemCount: doctorModel!.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              color: index % 2 == 0 ? Colors.cyan[100] : Colors.deepOrange[100],
              child: ListTile(
                onTap: () async {
                  Navigator.push(
                      context,
                      DialogRoute(
                        context: context,
                        builder: (context) => const doctor_profile(),
                      ));
                  const storage = FlutterSecureStorage();
                    var jsonResponse = jsonDecode(doctorModel![index].toString());
                    await storage.write(
                        key: 'uId',
                        value: jsonResponse['id']);
                },
                leading: const Icon(Icons.person),
                title: Text(doctorModel![index].name.toString()),
                trailing: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("Contact"),
                    Text(doctorModel![index].contact.toString()),
                  ],
                ),
              ),
            );
          }),
    ));
  }
}

class doctor_profile extends StatefulWidget {
  const doctor_profile({super.key});


  @override
  State<doctor_profile> createState() => _doctor_profileState();
}

class _doctor_profileState extends State<doctor_profile> {
  String? sId;
  get uId => {};

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.teal[100],
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const SizedBox(
              height: 80.0,
            ),
            Container(
              height: 200.0,
              child: const Center(
                child: CircleAvatar(
                  radius: 100.0,
                  backgroundImage: AssetImage("images/salman.png"),
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                "Profile of User",
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Container(
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Address: ",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Container(
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Specialty: ",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Container(
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Contact: ",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton.icon(
                    onPressed: () async {
                      const storage = FlutterSecureStorage();
                      try {
                        print('-----value111---');
                        var value = await storage.read(key: 'doctor');
                        print('-----value---');
                        print(value);
                      } catch (e) {}
                    },
                    icon: const Icon(Icons.edit_note_outlined),
                    style: ButtonStyle(
                        iconColor: MaterialStateProperty.all(Colors.black)),
                    label: const Text(
                      "Edit Data",
                      style: TextStyle(color: Colors.black),
                    )),
                TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.delete_forever),
                    style: ButtonStyle(
                        iconColor: MaterialStateProperty.all(Colors.black)),
                    label: const Text(
                      "Delete Data",
                      style: TextStyle(color: Colors.black),
                    )),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
