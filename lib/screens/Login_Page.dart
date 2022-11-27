import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/MyButton.dart';
import '../components/CheckBox.dart';
import '../components/Paddings.dart';
import '../components/TxtField.dart';
import 'SaveStudent_Page.dart';

// ignore: camel_case_types
class Login_Page extends StatefulWidget {
  const Login_Page({super.key});

  @override
  State<Login_Page> createState() => _Login_PageState();
}

// ignore: camel_case_types
class _Login_PageState extends State<Login_Page> {
  final String loginpagetitle = 'Login Page';

  TextEditingController txtUserName = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  // ignore: avoid_init_to_null
  var sharedPref = null;
  bool isRemember = true;

  @override
  void initState() {
    super.initState();
    prepareSharedInstance();
  }

  Future<void> prepareSharedInstance() async {
    sharedPref = await SharedPreferences.getInstance();

    setState(() {
      isRemember = sharedPref.getBool("remember") ?? false;
      if (isRemember) {
        txtUserName.text = sharedPref.getString("username") ?? "";
        txtPassword.text = sharedPref.getString("pass") ?? "";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(loginpagetitle),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 135, 18, 31),
      ),
      body: Padding(
        padding: ProjectPadding.pagePadding,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: ProjectPadding.elementPadding,
                child: TxtField(
                  txt: "Enter username : ",
                  controller: txtUserName,
                  obsecureText: false,
                ),
              ),
              Padding(
                padding: ProjectPadding.elementPadding,
                child: TxtField(
                  txt: 'Enter Password :',
                  controller: txtPassword,
                  obsecureText: true,
                ),
              ),
              Padding(
                padding: ProjectPadding.elementPadding,
                child: CheckBox(
                  onChanged: (newValue) {
                    setState(() {
                      isRemember = newValue!;
                      sharedPref.setBool("remember", newValue);
                    });
                  },
                  value: isRemember,
                ),
              ),
              MyButton(
                onPressed: () {
                  login();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const StudentPage()));
                },
                txt: 'Login',
                color: const Color.fromARGB(66, 38, 237, 45), //green
              ),
            ],
          ),
        ),
      ),
    );
  }

  login() {
    if (isRemember) {
      sharedPref.setString("username", txtUserName.text.toString());
      sharedPref.setString("pass", txtPassword.text.toString());
    }
  }
}
