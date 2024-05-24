import 'package:flutter/material.dart';
import 'package:pharmacy/home.dart';
import 'package:pharmacy/model/invoices.dart';
import 'package:http/http.dart' as http;

class list_invoice extends StatefulWidget {
  const list_invoice({super.key});

  @override
  State<list_invoice> createState() => _list_invoiceState();
}

class _list_invoiceState extends State<list_invoice> {

    List<Invoices>? invoiceModels;

  final String getProduct = 'https://pharmacy-spring.onrender.com/product';

  _getData() async {
    try {
      var response = await http.get(Uri.parse(getProduct),
          headers: {"Content-Type": "application/json"});
      if (response.statusCode == 200) {
        setState(() {
          invoiceModels = invoiceFromJson(response.body);
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
        title: const Text("INVOICES"),
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
      body: ListView.builder(
        itemCount: invoiceModels!.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            color: index % 2 == 0 ? Colors.cyan[100] : Colors.deepOrange[100],
            child: ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          medicine(medId: invoiceModels![index]),
                    ));
              },
              leading: const Icon(Icons.medication),
              title: Text(invoiceModels![index].customerId.toString()),
              titleAlignment: ListTileTitleAlignment.center,
              subtitle: generics(),
              isThreeLine: true,
              trailing: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Sales ID"),
                  Text(invoiceModels![index].salesId.toString()),
                ],
              ),
            ),
          );
        }),
      ));
  }
}