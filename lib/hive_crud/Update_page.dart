import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sing_up_login_hive/model/userModel.dart';

class UpdatePages extends StatefulWidget {
  final String userName;
  final String userEmail;
  final String userPassword;
  final int index;
  final String userImage;

  const UpdatePages({
    super.key,
    required this.userName,
    required this.userEmail,
    required this.userPassword,
    required this.index,
    required this.userImage,
  });

  @override
  State<UpdatePages> createState() => _UpdatePagesState();
}

class _UpdatePagesState extends State<UpdatePages> {
  var updateName = TextEditingController();
  var updateEmail = TextEditingController();
  var updatePassword = TextEditingController();
  File? _galleryFile;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    updateName = TextEditingController(text: widget.userName);
    updateEmail = TextEditingController(text: widget.userEmail);
    updatePassword = TextEditingController(text: widget.userPassword);
  }

  void _pickImageFromGallery() async {
    final ImagePicker _pickel = ImagePicker();
    final XFile? image = await _pickel.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _galleryFile = File(image.path);
      });
    }
  }

  void updateData() async {
    var box = await Hive.openBox<UserModel>('notes');
    var userdata = UserModel(
        name: updateName.text,
        email: updateEmail.text,
        password: updatePassword.text,
        image: _galleryFile != null ? _galleryFile!.path : widget.userImage);
    box.putAt(widget.index, userdata);

    Fluttertoast.showToast(msg: 'update data');
    Navigator.pop(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var heightScreen = MediaQuery.of(context).size.height;
    var widthScreen = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Update Data')),
          backgroundColor: Colors.greenAccent,
        ),
        body: SingleChildScrollView(
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
                    SizedBox(
                      height: 50,
                    ),
                    InkWell(
                      onTap: () {
                        _pickImageFromGallery();
                      },
                      child: CircleAvatar(
                        radius: 60,
                        child: ClipOval(
                            child: _galleryFile != null
                                ? Image.file(
                              _galleryFile!,
                              height: 120,
                              width: 120,
                              fit: BoxFit.cover,
                            )
                                : Image.file(File(widget.userImage,) ,height: 120,
                              width: 120,fit: BoxFit.cover,)
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Card(
                        elevation: 5,
                        child: TextField(
                          controller: updateName,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(), hintText: 'Enter Name'),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Card(
                        elevation: 5,
                        child: TextField(
                          controller: updateEmail,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(), hintText: 'Enter Email'),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Card(
                        elevation: 5,
                        child: TextField(
                          controller: updatePassword,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter Password'),
                        )),
                    SizedBox(
                      height: 30,
                    ),
                    OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.redAccent, minimumSize: Size(200, 45)),
                        onPressed: () {
                          updateData();
                        },
                        child: const Text(
                          'Update Data',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontStyle: FontStyle.italic),
                        ))
                  ],
                ),
              ),
            ),
          ),

        ),
      ),
    );
  }
}
