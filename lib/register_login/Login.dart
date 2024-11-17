import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sing_up_login_hive/hive_crud/home_page.dart';
import 'package:sing_up_login_hive/register_login/Register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _hide = true;
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPassword = TextEditingController();
  bool isLogin = false;

  void loginData() async {
    setState(() {
      isLogin = true;
    });
    var email = userEmail.text;
    var password = userPassword.text;
    var box = await Hive.openBox('auth');
    var gEmail = box.get('userEmail');
    var gPassword = box.get('userPassword');
    box.put('isLogin', isLogin);
    if (gEmail == email && gPassword == password) {
      Fluttertoast.showToast(msg: 'Login success');
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ));
    } else {
      Fluttertoast.showToast(msg: 'wrong password');
    }
  }

  @override
  Widget build(BuildContext context) {
    var heightScreen = MediaQuery.of(context).size.height;
    var widthScreen = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Sing Up ')),
          backgroundColor: Colors.green,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 23),
                child: SizedBox(
                  height: heightScreen * 0.5,
                  width: widthScreen * 0.9,
                  child: Card(
                    color: Colors.cyan,
                    elevation: 5,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        Card(
                            elevation: 5,
                            child: TextField(
                              controller: userEmail,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Enter Email'),
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        Card(
                            elevation: 5,
                            child: TextField(
                              obscureText: _hide,
                              keyboardType: TextInputType.number,
                              controller: userPassword,
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _hide = !_hide;
                                        });
                                      },
                                      icon: Icon(_hide
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility_outlined)),
                                  border: OutlineInputBorder(),
                                  hintText: 'Enter Password'),
                            )),
                        SizedBox(
                          height: 30,
                        ),
                        OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                minimumSize: Size(200, 45)),
                            onPressed: () {
                              loginData();
                            },
                            child: const Text(
                              'Login',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 0),
                          child: InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Register(),
                                  ));
                            },
                            child: Text(
                              'OR Register',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.red.shade700),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
