import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pharmacy/home.dart';
import 'package:pharmacy/model/products.dart';
import 'package:http/http.dart' as http;

class add_company_return extends StatefulWidget {
  const add_company_return({super.key});

  @override
  State<add_company_return> createState() => _add_company_returnState();
}

class _add_company_returnState extends State<add_company_return> {
  TextEditingController product_name = TextEditingController();
  TextEditingController returnQty = TextEditingController();
  TextEditingController returnDate = TextEditingController();

  late List<Products>? genericModel = [];

  final String getGeneric =
      'https://pharmacy-project-spring-3.onrender.com/product';

  void _getGenerics() async {
    try {
      var response = await http.get(Uri.parse(getGeneric),
          headers: {"Content-Type": "application/json"});
      genericModel = usersFromJson(response.body);
      Future.delayed(const Duration(seconds: 1))
          .then((value) => setState(() {}));
    } catch (e) {
      print(e);
    }
  }

  String postProduct = 'https://pharmacy-project-spring-3.onrender.com/retcomp';

  Future<void> postdata() async {
    var reqBody = {
      "tradeName": product_name.text,
      "returnedDate": returnDate.text,
      "returnedAmount": returnQty.text,
    };
    var response = await http.post(Uri.parse(postProduct),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody));
    var jsonResponse = jsonDecode(response.body);
    print(jsonResponse);
    print(response.statusCode);
  }

   @override
  void initState() {
    super.initState();
    _getGenerics();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[400],
        title: const Text("Return to Company"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications,
                color: Colors.black,
              )),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.logout,
                  color: Colors.black,
                )),
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
                padding: const EdgeInsets.only(top: 20.0),
                child: DropdownButtonFormField(
                  value: null,
                  hint: Text('Select Product'),
                  items: genericModel?.map((generic) {
                        return DropdownMenuItem(
                          value: generic.tradeName,
                          child: Text(generic.tradeName ?? ''),
                        );
                      }).toList() ??
                      [],
                  onChanged: (value) {
                    setState(() {
                      product_name.text = value.toString();
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: TextField(
                  controller: returnQty,
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
                    labelText: 'Returned Quantity',
                    labelStyle: TextStyle(color: Colors.black, fontSize: 20.0),
                    prefixIcon: Icon(Icons.production_quantity_limits),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: TextField(
                  controller: returnDate,
                  readOnly: false,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.teal, width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.teal, width: 2.0),
                    ),
                    fillColor: Color.fromARGB(255, 178, 223, 219),
                    filled: true,
                    border: OutlineInputBorder(),
                    labelText: 'Return Date',
                    labelStyle: TextStyle(color: Colors.black, fontSize: 20.0),
                    prefixIcon: Icon(Icons.date_range),
                  ),
                  onTap: () => retate(context: context),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: OutlinedButton(
                  onPressed: () {
                    postdata();
                    // print(product_name.text +
                    //     company_name.text +
                    //     generic_name.text +
                    //     registered_Qty.text +
                    //     mfd.text +
                    //     expd.text +
                    //     mrp.text);
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
                    child: const Text('RETURN'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  retate({required BuildContext context}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      lastDate: DateTime(2070),
      firstDate: DateTime.now(),
      initialDate: DateTime.now(),
    );
    if (pickedDate == null) return;
    returnDate.text = DateFormat('yyyy-MM-dd').format(pickedDate);
  }
}
