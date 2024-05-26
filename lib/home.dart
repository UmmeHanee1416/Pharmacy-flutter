import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pharmacy/customer.dart';
import 'package:pharmacy/employee.dart';
import 'package:pharmacy/generic.dart';
import 'package:pharmacy/invoice.dart';
import 'package:pharmacy/model/products.dart';
import 'package:pharmacy/product.dart';
import 'package:pharmacy/profile.dart';
import 'package:pharmacy/purchse.dart';
import 'package:pharmacy/return.dart';
import 'package:pharmacy/security.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.teal[200],
            appBar: AppBar(
              backgroundColor: Colors.teal[400],
              title: const Text("PHARMACY"),
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
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const login(),
                            ));
                      },
                      icon: const Icon(
                        Icons.logout,
                        color: Colors.black,
                      )),
                ),
              ],
            ),
            body: const med_list(),
            drawer: const drawer(),
            floatingActionButton: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 31, bottom: 70.0),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: FloatingActionButton(
                      heroTag: "search",
                      backgroundColor: Colors.teal[50],
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  content: TextField(
                                    controller: search,
                                  ),
                                  actions: [
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => medicine(
                                                  medId: search,
                                                ),
                                              ));
                                        },
                                        child: const Text("Search"))
                                  ],
                                ));
                      },
                      child: const Icon(Icons.search),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    heroTag: "add",
                    backgroundColor: Colors.teal[50],
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const list_generic(),
                          ));
                    },
                    child: const Icon(Icons.medication_liquid),
                  ),
                ),
              ],
            )));
  }
}

class med_list extends StatefulWidget {
  const med_list({super.key});
  @override
  State<med_list> createState() => _med_listState();
}

class _med_listState extends State<med_list> {
  late List<Products>? _productModel = [];

  final String meds = 'https://pharmacy-spring.onrender.com/product';

  void _getData() async {
    try {
      var response = await http
          .get(Uri.parse(meds), headers: {"Content-Type": "application/json"});
      _productModel = usersFromJson(response.body);
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
    return ListView.builder(
        itemCount: _productModel!.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            color: index % 2 == 0 ? Colors.cyan[100] : Colors.deepOrange[100],
            child: ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          medicine(medId: _productModel![index]),
                    ));
              },
              leading: const Icon(Icons.medication),
              title: Text(_productModel![index].tradeName.toString()),
              titleAlignment: ListTileTitleAlignment.center,
              subtitle: generics(),
              isThreeLine: true,
              trailing: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Available QTY"),
                  Text(_productModel![index].remainedQuantity.toString()),
                ],
              ),
            ),
          );
        });
  }
}

class medicine extends StatefulWidget {
  const medicine({super.key, this.medId});
  final medId;
  @override
  State<medicine> createState() => _medicineState();
}

class _medicineState extends State<medicine> {
  getMed() {}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(45.0),
              child: Card(
                child: Image.asset("images/paracetamol.jpg"),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 20.0),
                child: Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      widget.medId.tradeName.toString(),
                      style: const TextStyle(
                        fontSize: 15.0,
                      ),
                    )),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 20.0),
                child: Container(
                    alignment: Alignment.topLeft,
                    child: const Text(
                      "Paracetamol , xyz, lmn",
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    )),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 20.0),
                child: Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Sold Qty: ${widget.medId.soldQuantity}",
                      style: const TextStyle(
                        fontSize: 15.0,
                      ),
                    )),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 20.0),
                child: Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Available Qty: ${widget.medId.remainedQuantity}",
                      style: const TextStyle(
                        fontSize: 15.0,
                      ),
                    )),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 20.0),
                child: Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Price: ${widget.medId.sellPrice}",
                      style: const TextStyle(
                        fontSize: 15.0,
                      ),
                    )),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.edit_document,
                    color: Colors.black,
                  ),
                  label: const Text(
                    "Request Edit",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.delete_forever,
                      color: Colors.black,
                    ),
                    label: const Text(
                      "Product Deletion",
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

Text generics() {
  var myList = List.filled(3, "null", growable: true);
  for (var element in myList) {
    return Text(element);
  }
  return const Text("");
}

class drawer extends StatefulWidget {
  const drawer({super.key});

  @override
  State<drawer> createState() => _drawerState();
}

class _drawerState extends State<drawer> {
  @override
  Widget build(BuildContext context) {
    var allheight = MediaQuery.of(context).size.height;
    return Drawer(
      backgroundColor: Colors.teal[600],
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 23.0),
              child: Image.asset(
                "images/med_drawer.jpg",
                height: allheight / 3.5,
              ),
            ),
            Card(
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  gradient: LinearGradient(colors: [
                    Colors.blue,
                    Colors.white,
                  ]),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 70.0, right: 70.0),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Home(),
                          ));
                    },
                    child: const Text(
                      "Home",
                      style: TextStyle(
                          fontFamily: "font1",
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: allheight / 100,
            ),
            Card(
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  gradient: LinearGradient(colors: [
                    Colors.blue,
                    Colors.white,
                  ]),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 70.0, right: 70.0),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const add_customer(),
                          ));
                    },
                    child: const Text(
                      "Sales",
                      style: TextStyle(
                          fontFamily: "font1",
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: allheight / 100,
            ),
            Card(
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  gradient: LinearGradient(colors: [
                    Colors.blue,
                    Colors.white,
                  ]),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 65.0, right: 65.0),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const add_purchase(),
                          ));
                    },
                    child: const Text(
                      "Purchase",
                      style: TextStyle(
                          fontFamily: "font1",
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: allheight / 100,
            ),
            Card(
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  gradient: LinearGradient(colors: [
                    Colors.blue,
                    Colors.white,
                  ]),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 70.0, right: 70.0),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const add_company_return(),
                          ));
                    },
                    child: const Text(
                      "Returns",
                      style: TextStyle(
                          fontFamily: "font1",
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: allheight / 100,
            ),
            Card(
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  gradient: LinearGradient(colors: [
                    Colors.blue,
                    Colors.white,
                  ]),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 60.0, right: 65.0),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          DialogRoute(
                            context: context,
                            builder: (context) => const add_employee(),
                          ));
                    },
                    child: const Text(
                      "Employees",
                      style: TextStyle(
                          fontFamily: "font1",
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: allheight / 100,
            ),
            Card(
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  gradient: LinearGradient(colors: [
                    Colors.blue,
                    Colors.white,
                  ]),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 70.0, right: 70.0),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          DialogRoute(
                            context: context,
                            builder: (context) => const user_profile(),
                          ));
                    },
                    child: const Text(
                      "Profile",
                      style: TextStyle(
                          fontFamily: "font1",
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: allheight / 100,
            ),
            Card(
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  gradient: LinearGradient(colors: [
                    Colors.blue,
                    Colors.white,
                  ]),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 70.0, right: 70.0),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          DialogRoute(
                            context: context,
                            builder: (context) => const Home(),
                          ));
                    },
                    child: const Text(
                      "Settings",
                      style: TextStyle(
                          fontFamily: "font1",
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
