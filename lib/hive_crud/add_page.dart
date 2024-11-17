import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sing_up_login_hive/model/userModel.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  File? _galleryFile;
  final picker = ImagePicker();

  TextEditingController userName = TextEditingController();
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPassword = TextEditingController();

  void addData() async {
    var box = await Hive.openBox<UserModel>('Notes');
    var newUser = UserModel(
        name:userName.text , email: userEmail.text, password: userPassword.text, image: _galleryFile!.path);
          await box.add(newUser);
    Navigator.pop(context);
    Fluttertoast.showToast(msg: 'User Add');
  }
  @override
  Widget build(BuildContext context) {
    var heightScreen = MediaQuery.of(context).size.height;
    var widthScreen = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Add Data')),
          backgroundColor: Colors.greenAccent,
        ),
        body:
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.only(left: 20,top: 100),
            child: SizedBox(
              height: heightScreen * 0.6,
              width: widthScreen * 0.9,
              child: Card(
                color: Colors.blueAccent,
                child: Column(
                  children: [
                    SizedBox(height: 10,),
                    InkWell(
                      onTap: () {
                        _pickImageFromGallery();
                      },
                      child:  CircleAvatar(
                        radius: 60,
                        child: ClipOval(
                          child: _galleryFile != null? Image.file(_galleryFile!,height:120,width:120,fit: BoxFit.cover,):Text('No image select'),
                        ),
                      ),
                    ),
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
                          controller: userEmail,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter Email'),
                        )),
                    SizedBox(height: 20,),
                    Card(
                        elevation: 5,
                        child: TextField(
                          controller: userPassword,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter Password'),
                        )),
                    SizedBox(height: 30,),
                    OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.black,minimumSize: Size(200,45)),
                        onPressed: () {
                          addData();
                        },
                        child: const Text('Insert Data',style: TextStyle(fontSize: 18,color: Colors.white,fontStyle: FontStyle.italic),)),
                    SizedBox(height: 50,)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
Future<void> _pickImageFromGallery() async {
  final ImagePicker _pickel = ImagePicker();
  final XFile? image = await _pickel.pickImage(source: ImageSource.gallery);
  if(image != null){
    setState(() {
      _galleryFile = File(image.path);
    });
  }}

}
