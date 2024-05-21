import 'package:flutter/material.dart';

class user_profile extends StatefulWidget {
  const user_profile({super.key});

  @override
  State<user_profile> createState() => _user_profileState();
}

class _user_profileState extends State<user_profile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.teal[200],
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
                  backgroundImage: AssetImage("images/cat.jpeg"),
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            const Text(
              "Profile of User",
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
                right: 8.0,
                top: 20.0,
              ),
              child: Container(
                width: double.infinity,
                child: Card(
                  color: Colors.teal[300],
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, top: 10.0, bottom: 10.0),
                        child: Container(
                          child: Text("Role: "),
                          alignment: Alignment.centerLeft,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, top: 10.0, bottom: 10.0),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text("Email: "),
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
                                Icons.contact_support,
                                color: Colors.black,
                              ),
                              label: const Text(
                                "Contact Admin",
                                style: TextStyle(color: Colors.black),
                              )),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
