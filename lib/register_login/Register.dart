import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sing_up_login_hive/register_login/Login.dart';

class Register extends StatefulWidget {
  const Register({super.key});
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _isObscured = true;
  TextEditingController userName = TextEditingController();
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPassword = TextEditingController();

  void registerData()async{
    String name = userName.text;
    String email = userEmail.text;
    String password = userPassword.text;
    if(name.isNotEmpty && email.isNotEmpty && password.isNotEmpty){
      var box = await Hive.openBox('auth');
      box.put('userName', name);
      box.put('userEmail',email);
      box.put('userPassword', password);
      Fluttertoast.showToast(msg: 'Sign Up Success');
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));

    }else{
      Fluttertoast.showToast(msg: 'Please fell all details');
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
          title: Center(child: Text('Register')),
          backgroundColor: Colors.green,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(height: 50,),
              Padding(
                padding: const EdgeInsets.only(left: 23),
                child: SizedBox(
                  height: heightScreen * 0.6,
                  width: widthScreen * 0.9,
                  child: Card(
                    color: Colors.cyan,
                    elevation: 5,
                    child: Column(
                      children: [
                      const SizedBox(height: 50,),
                        // InkWell(
                        //   onTap: () {
                        //     // _pickImageFromGallery();
                        //   },
                        //   child:  CircleAvatar(
                        //     radius: 60,
                        //     child: ClipOval(
                        //       // child: _galleryFile != null? Image.file(_galleryFile!,height:120,width:120,fit: BoxFit.cover,):Text('No image select'),
                        //     ),
                        //   ),
                        // ),
                        SizedBox(height: 30,),
                        Card(
                            elevation: 5,
                            child: TextField(
                              controller: userName,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Enter Name'),
                            )),
                        SizedBox(height: 20,),
                        Card(
                            elevation: 5,
                            child: TextField(
                              keyboardType: TextInputType.emailAddress,
                              controller: userEmail,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.email),
                                  border: OutlineInputBorder(),
                                  hintText: 'Enter Email'),
                            )),
                        SizedBox(height: 20,),
                        Card(
                            elevation: 5,
                            child: TextField(
                              obscureText: _isObscured,
                              controller: userPassword,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(onPressed: () {
                                  setState(() {
                                    _isObscured =! _isObscured;
                                  });
                                }, icon: Icon(
                                  _isObscured ? Icons.visibility_off : Icons.visibility,
                                )),
                                border: OutlineInputBorder(),
                                  hintText: 'Enter Password'),
                            )),
                        SizedBox(height: 30,),
                        OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.blue,minimumSize: Size(200,45)),
                            onPressed: () {
                              registerData();
                            },
                            child: const Text('Register',style: TextStyle(fontSize: 18,color: Colors.white),))
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



