import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pharmacy/home.dart';
import 'package:http/http.dart' as http;
import 'package:pharmacy/model/generics.dart';

class add_generic extends StatelessWidget {
  add_generic({super.key});

  final TextEditingController name = TextEditingController();
  final TextEditingController quantity = TextEditingController();

  final String postCompany =
      'https://pharmacy-project-spring-3.onrender.com/generic';

  Future<void> postdata() async {
    var reqBody = {
      "genericName": name.text,
      "registeredQuantity": quantity.text,
    };
    var response = await http.post(Uri.parse(postCompany),
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
      appBar: AppBar(
        backgroundColor: Colors.teal[400],
        title: const Text("ADD GENERIC"),
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
      drawer: drawer(),
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
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.teal, width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.teal, width: 2.0),
                    ),
                    fillColor: Colors.teal[100],
                    filled: true,
                    border: OutlineInputBorder(),
                    labelText: 'Generic Name',
                    labelStyle: TextStyle(color: Colors.black, fontSize: 20.0),
                    prefixIcon: Icon(Icons.medication),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: TextField(
                  controller: quantity,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.teal, width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.teal, width: 2.0),
                    ),
                    fillColor: Colors.teal[100],
                    filled: true,
                    border: OutlineInputBorder(),
                    labelText: 'Quantity',
                    labelStyle: TextStyle(color: Colors.black, fontSize: 20.0),
                    prefixIcon: Icon(Icons.numbers),
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                    child: const Text('ADD'),
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

class list_generic extends StatefulWidget {
  const list_generic({super.key});

  @override
  State<list_generic> createState() => _list_genericState();
}

class _list_genericState extends State<list_generic> {

  late List<Generics>? doctorModel = [];

  final String getDoctor =
      'https://pharmacy-project-spring-3.onrender.com/generic';

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
            appBar: AppBar(
              backgroundColor: Colors.teal[400],
              title: Text("GENERIC\'S LIST"),
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.notifications,
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 5.0),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.logout,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            drawer: drawer(),
            backgroundColor: Colors.teal[100],
            body: ListView.builder(
          itemCount: doctorModel!.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              color: index % 2 == 0 ? Colors.cyan[100] : Colors.deepOrange[100],
              child: ListTile(
                leading: Icon(Icons.person),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Name: "),
                    Text(doctorModel![index].genericName.toString()),
                    Text("Contact: "),
                    Text(doctorModel![index].registeredQuantity.toString()),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.edit_note),
                    Icon(Icons.delete_sweep),
                  ],
                ),
              ),
            );
          }),
                ));
  }
}
