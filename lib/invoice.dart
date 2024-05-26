import 'package:flutter/material.dart';
import 'package:pharmacy/home.dart';
import 'package:http/http.dart' as http;
import 'package:pharmacy/model/sales.dart';
import 'package:pharmacy/model/salesDetails.dart';

class list_invoice extends StatefulWidget {
  const list_invoice({super.key});

  @override
  State<list_invoice> createState() => _list_invoiceState();
}

class _list_invoiceState extends State<list_invoice> {
  late List<Sales>? invoiceModels = [];

  final String getProduct = 'https://pharmacy-spring.onrender.com/sales';

  _getData() async {
    try {
      var response = await http.get(Uri.parse(getProduct),
          headers: {"Content-Type": "application/json"});
      if (response.statusCode == 200) {
        setState(() {
          invoiceModels = salesFromJson(response.body);
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
        title: const Text("SALES"),
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
                onTap: () {},
                leading: const Icon(Icons.medication),
                title: Text(invoiceModels![index].id.toString()),
                titleAlignment: ListTileTitleAlignment.center,
                trailing: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("Total Charge"),
                    Text(invoiceModels![index].totalCharge.toString()),
                  ],
                ),
              ),
            );
          }),
    ));
  }
}

class sales_invoice extends StatefulWidget {
  const sales_invoice({super.key, this.salesId});
  final salesId;

  @override
  State<sales_invoice> createState() => _sales_invoiceState();
}

class _sales_invoiceState extends State<sales_invoice> {
  late List<SalesDetails>? invoiceModels = [];

  final String getProduct = 'https://pharmacy-spring.onrender.com/sales';

  _getData() async {
    try {
      var response = await http.get(Uri.parse(getProduct + widget.salesId.id),
          headers: {"Content-Type": "application/json"});
      if (response.statusCode == 200) {
        setState(() {
          invoiceModels = salesDetailsFromJson(response.body);
          print(invoiceModels!.length);
          print(widget.salesId.totalCharge.toString());
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Text("Invoice"),
            ),
            ListView.builder(
                itemCount: invoiceModels!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    color: index % 2 == 0
                        ? Colors.cyan[100]
                        : Colors.deepOrange[100],
                    child: ListTile(
                      onTap: () {},
                      leading: const Icon(Icons.medication),
                      title: Text(invoiceModels![index].productId.toString()),
                      titleAlignment: ListTileTitleAlignment.center,
                      trailing: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text("Available QTY"),
                          Text(
                              invoiceModels![index].productQuantity.toString()),
                        ],
                      ),
                    ),
                  );
                }),
            Text("Total: " + widget.salesId.totalCharge.toString()),
          ],
        ),
      ),
    ));
  }
}
