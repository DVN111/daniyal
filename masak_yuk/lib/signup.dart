import 'dart:convert';

import 'package:async_programming_futurebuilder_resepmasak/view/home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login(String email, password) async {
    try {
      Response response = await post(Uri.parse('https://reqres.in/api/login'),
          body: {'email': email, 'password': password});

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Home()),
        );
        print(data['token']);
        final snackBar = SnackBar(
          backgroundColor: Color.fromARGB(255, 0, 171, 88),
          content: Text(
            'Login Berhasil',
            style: TextStyle(
              fontFamily: 'Poppins-Regular',
              color: Colors.white,
            ),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        print('Login successfully');
      } else {
        print('failed');
        final snackBar = SnackBar(
          backgroundColor: Color.fromARGB(255, 242, 45, 45),
          content: Text(
            'Login Gagal',
            style: TextStyle(
              fontFamily: 'Poppins-Regular',
              color: Colors.white,
            ),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        title: const Text(''),
        backgroundColor: Colors.transparent,
      ),
      body: Expanded(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(25),
          color: Color.fromARGB(255, 255, 243, 219),
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    height: 150,
                    width: 150,
                    child: Image.asset(
                      "images/logo.png",
                    )),
                SizedBox(
                  height: 70,
                ),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                      hintText: 'Email',
                      focusColor: Colors.amber[300],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: Icon(Icons.email),
                      filled: true,
                      fillColor: Colors.white),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                      hintText: 'Password',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      prefixIcon: Icon(Icons.password),
                      filled: true,
                      fillColor: Colors.white),
                ),
                SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    login(emailController.text.toString(),
                        passwordController.text.toString());
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 0, 0, 0),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        'L O G I N',
                        style: TextStyle(
                            color: Colors.amber[300],
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
