import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pharmacy/home.dart';
import 'package:http/http.dart' as http;
import 'package:pharmacy/model/products.dart';

class add_purchase extends StatefulWidget {
  const add_purchase({super.key});

  @override
  State<add_purchase> createState() => _add_purchaseState();
}

class _add_purchaseState extends State<add_purchase> {

    TextEditingController productName = TextEditingController();
  TextEditingController batchId = TextEditingController();
  TextEditingController purchaseQty = TextEditingController();
  TextEditingController purchaseDate = TextEditingController();
  TextEditingController mrp = TextEditingController();

  List<Products>? productModel;

    final String getProduct =
      'https://pharmacy-project-spring-3.onrender.com/product';

  _getData() async {
    try {
      var response = await http.get(Uri.parse(getProduct),
          headers: {"Content-Type": "application/json"});
      if (response.statusCode == 200) {
        setState(() {
          productModel = usersFromJson(response.body);
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


      final String postPurchase =
      'https://pharmacy-project-spring-3.onrender.com/purchase';

  Future<void> postdata() async {
    var reqBody = {
      "productId": productName.text,
      "batchId": batchId.text,
      "purchaseQuantity": purchaseQty.text,
      "purchaseDate": purchaseDate.text,
      "mrp": mrp.text
    };
    var response = await http.post(Uri.parse(postPurchase),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody));
    print(response.statusCode);
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal[400],
          title: const Text("NEW PURCHASE"),
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
                  padding: const EdgeInsets.only(top: 20.0),
                  child: DropdownButtonFormField(
                    value: null,
                    hint: const Text(
                        'Select Product'),
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
                    controller: batchId,
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
                      border: OutlineInputBorder(),
                      labelText: 'Batch ID',
                      labelStyle:
                          const TextStyle(color: Colors.black, fontSize: 20.0),
                      prefixIcon: Icon(Icons.info),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: TextField(
                    controller: purchaseQty,
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
                      border: OutlineInputBorder(),
                      labelText: 'Purchase Quantity',
                      labelStyle:
                          const TextStyle(color: Colors.black, fontSize: 20.0),
                      prefixIcon: const Icon(Icons.numbers),
                    ),
                  ),
                ),
                Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: TextField(
                  controller: purchaseDate,
                  readOnly: false,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.teal, width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.teal, width: 2.0),
                    ),
                    fillColor: Color.fromARGB(255, 178, 223, 219),
                    filled: true,
                    border: OutlineInputBorder(),
                    labelText: 'Purchase Date',
                    labelStyle: TextStyle(color: Colors.black, fontSize: 20.0),
                    prefixIcon: Icon(Icons.date_range),
                  ),
                  onTap: () => pDate(context: context),
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
                      border: OutlineInputBorder(),
                      labelText: 'M.R.P.',
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
    ));
  }

    pDate({required BuildContext context}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      lastDate: DateTime(2071),
      firstDate: DateTime.now(),
      initialDate: DateTime.now(),
    );
    if (pickedDate == null) return;
    purchaseDate.text = DateFormat('yyyy-MM-dd').format(pickedDate);
  }
}