import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pharmacy/model/employees.dart';
import 'package:pharmacy/model/products.dart';
import 'package:http/http.dart' as http;
import 'home.dart';

TextEditingController g_name = TextEditingController();
TextEditingController g_contact = TextEditingController();
TextEditingController g_salesDate = TextEditingController();
TextEditingController g_payMethod = TextEditingController();
TextEditingController g_empId = TextEditingController();

class add_customer extends StatefulWidget {
  const add_customer({super.key});

  @override
  State<add_customer> createState() => _add_customerState();
}

class _add_customerState extends State<add_customer> {
  TextEditingController name = TextEditingController();
  TextEditingController contact = TextEditingController();
  TextEditingController salesDate = TextEditingController();
  TextEditingController payMethod = TextEditingController();
  TextEditingController empId = TextEditingController();

  List<Employees>? productModel;

  final String getEmp = 'https://pharmacy-spring.onrender.com/emp';

  _getData() async {
    try {
      var response = await http.get(Uri.parse(getEmp),
          headers: {"Content-Type": "application/json"});
      if (response.statusCode == 200) {
        setState(() {
          productModel = empFromJson(response.body);
        });
      } else {
        throw Exception('Failed to load employee list');
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
        title: const Text("ADD CUSTOMER"),
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
                    prefixIcon: const Icon(Icons.medication),
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
                      borderSide: BorderSide(color: Colors.teal, width: 2.0),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal, width: 2.0),
                    ),
                    fillColor: Colors.teal[100],
                    filled: true,
                    border: const OutlineInputBorder(),
                    labelText: 'Contact',
                    labelStyle:
                        const TextStyle(color: Colors.black, fontSize: 20.0),
                    prefixIcon: const Icon(Icons.contact_phone),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: TextField(
                  controller: salesDate,
                  readOnly: false,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal, width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal, width: 2.0),
                    ),
                    fillColor: Color.fromARGB(255, 178, 223, 219),
                    filled: true,
                    border: OutlineInputBorder(),
                    labelText: 'Sales date',
                    labelStyle: TextStyle(color: Colors.black, fontSize: 20.0),
                    prefixIcon: Icon(Icons.date_range),
                  ),
                  onTap: () => saleDate(context: context),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: TextField(
                  controller: payMethod,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal, width: 2.0),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal, width: 2.0),
                    ),
                    fillColor: Colors.teal[100],
                    filled: true,
                    border: OutlineInputBorder(),
                    labelText: 'Payment Method',
                    labelStyle:
                        const TextStyle(color: Colors.black, fontSize: 20.0),
                    prefixIcon: const Icon(Icons.attach_money),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: DropdownButtonFormField(
                  value: null,
                  hint: const Text('Employee in Charge'),
                  items: productModel?.map((emp) {
                        return DropdownMenuItem(
                          value: emp.id,
                          child: Text(emp.name ?? ''),
                        );
                      }).toList() ??
                      [],
                  onChanged: (value) {
                    setState(() {
                      empId.text = value.toString();
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 18.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    OutlinedButton.icon(
                      onPressed: () {
                        Navigator.push(
                            context,
                            DialogRoute(
                              context: context,
                              builder: (context) => const Home(),
                            ));
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.teal[700],
                        side: const BorderSide(color: Colors.teal),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      label: const Text('Cancel Order'),
                      icon: const Icon(Icons.cancel),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OutlinedButton.icon(
                        onPressed: () {
                          g_name.value = TextEditingValue(text: name.text);
                          g_contact.value =
                              TextEditingValue(text: contact.text);
                          g_salesDate.value =
                              TextEditingValue(text: salesDate.text);
                          g_payMethod.value =
                              TextEditingValue(text: payMethod.text);
                          g_empId.value = TextEditingValue(text: empId.text);
                          print(g_name.text +
                              g_contact.text +
                              g_salesDate.text +
                              g_payMethod.text +
                              g_empId.text);
                          Navigator.push(
                              context,
                              DialogRoute(
                                context: context,
                                builder: (context) => const add_sales(),
                              ));
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.teal[700],
                          side: const BorderSide(color: Colors.teal),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        label: const Text('Go to Sales'),
                        icon: const Icon(Icons.attach_money),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  saleDate({required BuildContext context}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      lastDate: DateTime(2071),
      firstDate: DateTime.now(),
      initialDate: DateTime.now(),
    );
    if (pickedDate == null) return;
    salesDate.text = DateFormat('yyyy-MM-dd').format(pickedDate);
  }
}

class add_sales extends StatefulWidget {
  const add_sales({super.key});

  @override
  State<add_sales> createState() => _add_salesState();
}

class _add_salesState extends State<add_sales> {
  TextEditingController productName = TextEditingController();
  TextEditingController productQty = TextEditingController();
  final List<Map<String, dynamic>> salesDetails = [];

  final String postCompany = 'https://pharmacy-spring.onrender.com/customer';

  Future<void> postdata() async {
    var reqBody = {
      "name": g_name.text,
      "contact": g_contact.text,
      "purchaseDate": g_salesDate.text,
      "payMethod": g_payMethod.text,
      "empId": g_empId.text,
      "salesDetailDTOS": salesDetails
    };
    print(reqBody);
    var response = await http.post(Uri.parse(postCompany),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody));
    // var jsonResponse = jsonDecode(response.body);
    // print(jsonResponse);
    print(response.statusCode);
  }

  List<Products>? productModel;

  final String getProduct = 'https://pharmacy-spring.onrender.com/product';

  _getData() async {
    try {
      var response = await http.get(Uri.parse(getProduct),
          headers: {"Content-Type": "application/json"});
      if (response.statusCode == 200) {
        setState(() {
          productModel = usersFromJson(response.body);
        });
      } else {
        throw Exception('Failed to load product list');
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
        title: const Text("ADD SALES"),
        centerTitle: true,
      ),
      backgroundColor: Colors.teal[100],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
        child: Column(
          children: [
            Container(
              height: 250.0,
              width: double.infinity,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: DropdownButtonFormField(
                      value: null,
                      hint: const Text('Select Product'),
                      items: productModel?.map((product) {
                            return DropdownMenuItem(
                              value: product.tradeName,
                              child: Text(product.tradeName ?? ''),
                            );
                          }).toList() ??
                          [],
                      onChanged: (value) {
                        setState(() {
                          productName.text = value.toString();
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: TextField(
                      controller: productQty,
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
                        labelText: 'Product Quantity',
                        labelStyle: const TextStyle(
                            color: Colors.black, fontSize: 20.0),
                        prefixIcon:
                            const Icon(Icons.production_quantity_limits),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: OutlinedButton(
                      onPressed: () {
                        print("object04");
                        Map<String, dynamic> data = new Map<String, dynamic>();
                        data['salesId'] = 0;
                        data['productId'] = productName.text;
                        data['productQuantity'] = productQty.text;
                        data['totalCharge'] = 0;
                        salesDetails.add(data);
                        print("object05");
                        productName.clear();
                        productQty.clear();
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
                  child: Text('Confirm'),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
