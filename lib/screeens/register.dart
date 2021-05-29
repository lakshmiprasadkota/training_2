
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:training_test2/network/base_response.dart';
import 'package:training_test2/network/managers/login_manager.dart';
import 'package:training_test2/screeens/home_screen.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool loading = false;
  dynamic res;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> performRegister() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || email.length < 13) {
      Fluttertoast.showToast(msg: "Invalid Number");
      return;
    }
    if (password.isEmpty) {
      Fluttertoast.showToast(msg: "Invalid password");
      return;
    }
    setState(() {
      loading = true;
    });
    Map<String, dynamic> data = {
      "email": email,
      "password": password,
    };

    ResponseData responseData = await authManager.createSignUpToken(data);
    setState(() {
      res = responseData.data;
      loading = false;
    });
    if (responseData.status == ResponseStatus.SUCCESS) {
      print(responseData.data['message']);

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } else {
      Fluttertoast.showToast(msg: responseData.message);
      print(responseData.data['message']);
    }
    print(responseData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up "),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal:28.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: TextField(
                controller: emailController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    isDense: true,
                    hintText: "email",
                    labelText: "email",
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                            BorderSide(color: Color(0xffE3EAf2), width: 2)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                            BorderSide(color: Color(0xffFF8701), width: 2))),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Container(
              child: TextField(
                controller: passwordController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    isDense: true,
                    hintText: "password",
                    labelText: "password",
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                            BorderSide(color: Color(0xffE3EAf2), width: 2)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                            BorderSide(color: Color(0xffFF8701), width: 2))),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            InkWell(
              onTap: () {
                performRegister();
              },
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xffFF8701),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0x333B83FC),
                          offset: Offset(0, 5),
                          blurRadius: 10)
                    ]),
                child: Center(
                  child: Text(
                    "Sign In",
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
