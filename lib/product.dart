import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pharmacy/home.dart';
import 'package:pharmacy/model/companies.dart';
import 'package:http/http.dart' as http;
import 'package:pharmacy/model/generics.dart';

class create_product extends StatefulWidget {
  const create_product({super.key});

  @override
  State<create_product> createState() => _create_productState();
}

class _create_productState extends State<create_product> {
  TextEditingController product_name = TextEditingController();
  TextEditingController company_name = TextEditingController();
  TextEditingController generic_name = TextEditingController();
  TextEditingController registered_Qty = TextEditingController();
  TextEditingController mfd = TextEditingController();
  TextEditingController expd = TextEditingController();
  TextEditingController mrp = TextEditingController();

  String postProduct = 'https://pharmacy-spring.onrender.com/product';
 
  Future<void> postdata() async {
    var reqBody = {
      "tradeName": product_name.text,
      "companyName": company_name.text,
      "regsrtQuantity": registered_Qty.text,
      "mfd": mfd.text,
      "exp": expd.text,
      "sellPrice": mrp.text,
      "generics": [generic_name.text],
    };
    print(reqBody);

    var response = await http.post(Uri.parse(postProduct),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody));
    var jsonResponse = jsonDecode(response.body);
    print(jsonResponse);
    print(response.statusCode);
  }

  List<Companies>? companyModel;

  final String getCompany =
      'https://pharmacy-spring.onrender.com/company';

  _getCompanies() async {
    try {
      var response = await http.get(Uri.parse(getCompany),
          headers: {"Content-Type": "application/json"});
      if (response.statusCode == 200) {
        print(response.statusCode);
        setState(() {
          companyModel = usersFromJsonC(response.body);
        });
      } else {
        throw Exception('Failed to load doctor list');
      }
    } catch (e) {
      print(e);
    }
  }

  late List<Generics>? genericModel = [];

  final String getGeneric =
      'https://pharmacy-spring.onrender.com/generic';

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

  @override
  void initState() {
    super.initState();
    _getCompanies();
    _getGenerics();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[400],
        title: Text("Create New Product"),
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
                padding: const EdgeInsets.only(top: 10.0),
                child: TextField(
                  controller: product_name,
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
                    labelText: 'Product Name',
                    labelStyle: TextStyle(color: Colors.black, fontSize: 20.0),
                    prefixIcon: Icon(Icons.medication),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: DropdownButtonFormField(
                  value: null,
                  hint: Text('Select Company'),
                  items: companyModel?.map((company) {
                        return DropdownMenuItem(
                          value: company.name,
                          child: Text(company.name ?? ''),
                        );
                      }).toList() ??
                      [],
                  onChanged: (value) {
                    setState(() {
                      company_name.text = value.toString();
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: DropdownButtonFormField(
                  value: null,
                  hint: Text('Select Generic'),
                  items: genericModel?.map((generic) {
                        return DropdownMenuItem(
                          value: generic.id,
                          child: Text(generic.genericName ?? ''),
                        );
                      }).toList() ??
                      [],
                  onChanged: (value) {
                    setState(() {
                      generic_name.text = value.toString();
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: TextField(
                  controller: registered_Qty,
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
                    labelText: 'Registered Quantity',
                    labelStyle: TextStyle(color: Colors.black, fontSize: 20.0),
                    prefixIcon: Icon(Icons.production_quantity_limits),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: TextField(
                  controller: mfd,
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
                    labelText: 'Manufacture Date',
                    labelStyle: TextStyle(color: Colors.black, fontSize: 20.0),
                    prefixIcon: Icon(Icons.date_range),
                  ),
                  onTap: () => mfDate(context: context),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: TextField(
                  controller: expd,
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
                    labelText: 'Expiry Date',
                    labelStyle: TextStyle(color: Colors.black, fontSize: 20.0),
                    prefixIcon: Icon(Icons.date_range),
                  ),
                  onTap: () => expDate(context: context),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: TextField(
                  controller: mrp,
                  keyboardType: TextInputType.number,
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
                    labelText: 'MRP',
                    labelStyle: const TextStyle(color: Colors.black, fontSize: 20.0),
                    prefixIcon: const Icon(Icons.attach_money),
                  ),
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
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50.0),
                    child: Text('CREATE'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  mfDate({required BuildContext context}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      lastDate: DateTime.now(),
      firstDate: DateTime(1970),
      initialDate: DateTime.now(),
    );
    if (pickedDate == null) return;
    mfd.text = DateFormat('yyyy-MM-dd').format(pickedDate);
  }

  expDate({required BuildContext context}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      lastDate: DateTime(2070),
      firstDate: DateTime(1970),
      initialDate: DateTime.now(),
    );
    if (pickedDate == null) return;
    expd.text = DateFormat('yyyy-MM-dd').format(pickedDate);
  }
}
