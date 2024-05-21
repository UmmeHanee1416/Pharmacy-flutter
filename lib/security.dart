import 'package:flutter/material.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  @override
  Widget build(BuildContext context) {
    TextEditingController userName = TextEditingController();
    TextEditingController password = TextEditingController();

    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.teal[300],
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 230.0),
        child: Column(
          children: [
            TextField(
              controller: userName,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.teal, width: 2.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.teal, width: 2.0),
                ),
                fillColor: Colors.teal[100],
                filled: true,
                border: OutlineInputBorder(),
                labelText: 'User Name',
                labelStyle: TextStyle(color: Colors.black, fontSize: 20.0),
                hintText: 'Enter User Name',
                prefixIcon: Icon(Icons.person),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: TextField(
                controller: password,
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
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.black, fontSize: 20.0),
                  hintText: 'Enter Password',
                  prefixIcon: Icon(Icons.password),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 5, backgroundColor: Colors.teal[100]),
                onPressed: () {},
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 50.0, right: 50.0, top: 10.0, bottom: 10.0),
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.black, fontSize: 20.0),
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

class sign_up extends StatefulWidget {
  const sign_up({super.key});

  @override
  State<sign_up> createState() => _sign_upState();
}

class _sign_upState extends State<sign_up> {
  TextEditingController userName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.teal[300],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 170.0),
          child: Column(
            children: [
              TextField(
                controller: userName,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.teal, width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.teal, width: 2.0),
                  ),
                  fillColor: Colors.teal[100],
                  filled: true,
                  border: OutlineInputBorder(),
                  labelText: 'User Name',
                  labelStyle: TextStyle(color: Colors.black, fontSize: 20.0),
                  hintText: 'Enter User Name',
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: TextField(
                  controller: email,
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
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.black, fontSize: 20.0),
                    hintText: 'Enter Valid Email',
                    helperText: 'Must contain @',
                    prefixIcon: Icon(Icons.alternate_email),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: TextField(
                  controller: password,
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
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.black, fontSize: 20.0),
                    hintText: 'Enter Password',
                    helperText: 'Must be more than 8 characters',
                    prefixIcon: Icon(Icons.password),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 5, backgroundColor: Colors.teal[100]),
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 50.0, right: 50.0, top: 10.0, bottom: 10.0),
                    child: Text(
                      'Register',
                      style: TextStyle(color: Colors.black, fontSize: 20.0),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
