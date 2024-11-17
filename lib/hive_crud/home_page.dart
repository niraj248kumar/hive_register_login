import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sing_up_login_hive/hive_crud/add_page.dart';
import 'package:sing_up_login_hive/model/userModel.dart';
import 'package:sing_up_login_hive/register_login/Register.dart';

import 'Update_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  void deleteData(int index) async{
    var box = await Hive.openBox<UserModel>('Notes');
    box.delete(index);
    setState(() {

    });
  }
  void logOutData() async{
    var box = await Hive.openBox('auth');
    box.put('isLogin', false);
    Fluttertoast.showToast(msg: 'logOut success');
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Register(),));
  }



  @override
  Widget build(BuildContext context) {
    var box = Hive.box<UserModel>('Notes');
    return Scaffold(
      appBar: AppBar( actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: TextButton.icon(onPressed: () {
            logOutData();
          }, label: Icon(Icons.logout,color: Colors.white,)),
        )
      ],
        title: Center(child: Text('Home Screen')),
        backgroundColor: Colors.cyan,
      ),
      drawer: Drawer(
        child:ValueListenableBuilder(
            valueListenable:box.listenable(), 
            builder:(context, Box<UserModel>box,_) {
             if(box.isEmpty){
               return Center(child: Text('No user'),
               );
             }
             var  drawerUser = box.getAt(0);
             return ListView(
               children: [

                 UserAccountsDrawerHeader(
                   arrowColor: Colors.blueGrey,
                   currentAccountPicture:CircleAvatar(
                       backgroundColor: Colors.greenAccent,
                       maxRadius: 30,
                       child: ClipOval(
                         child: drawerUser!= null && drawerUser.image != null && drawerUser.image !.isNotEmpty? Image.file(File(drawerUser.image!),
                           fit: BoxFit.cover,
                           width: 60,
                           height: 60,):Icon(Icons.person),
                       )) ,
                     accountName: Text(drawerUser!.name),
                     accountEmail: Text(drawerUser!.email)),
                 ListTile(leading: Icon(Icons.settings),
                    title: Text('setting'),)
               ],
             );

            } ,),
        
        
        // ListView(
        //   children: [
        //     UserAccountsDrawerHeader(
        //       currentAccountPicture: CircleAvatar(
        //           backgroundColor: Colors.greenAccent,
        //           maxRadius: 30,
        //           child: ClipOval(
        //             child: user!= null && user.image != null && user.image !.isNotEmpty? Image.file(File(user.image!),
        //               fit: BoxFit.cover,
        //               width: 55,
        //               height: 55,):Icon(Icons.person),
        //           )),
        //         accountName: Text(user!.name,),
        //         accountEmail: Text(user!.email,),)
        //     DrawerHeader(
        //       decoration: BoxDecoration(color: Colors.red),
        //       child: Column(
        //         children: [
        //           CircleAvatar(
        //             radius: 50,
        //             child: ClipOval(
        //               child: Image.network(
        //                   'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQyFH-5_P3FEF5xKoBSFRyN-HuKAZZhkgfGug&s'),
        //             ),
        //           ),
        //           Text(
        //             'Niraj kumar',
        //             style: TextStyle(fontStyle: FontStyle.italic),
        //           ),
        //         ],
        //       ),
        //     ),
        //     ListTile(
        //       leading: Icon(Icons.person),
        //       title: Text('Name'),
        //     )
        //   ],
        // ),
      ),
      body: ValueListenableBuilder(
        valueListenable: box.listenable(),

        builder: (context,Box<UserModel> box, _) {
          if(box.isEmpty){
            return Center(child: Text('No user'),);

          }else{
            return ListView.builder(
              itemCount: box.length,
              itemBuilder: (context, index) {
                var user = box.getAt(index);
                return Card(
                  color: Colors.blue,
                  margin: const EdgeInsets.all(10),
                  elevation: 5,
                  child:InkWell(
                    onLongPress: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => UpdatePages(
                        userName:user.name, userEmail: user.email, userPassword: user.password
                        , index: index, userImage: user.image,
                      ),));
                    },
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Row(children: [
                                  CircleAvatar(
                                  backgroundColor: Colors.greenAccent,
                                  maxRadius: 30,
                                  child: ClipOval(
                                    child: user!= null && user.image != null && user.image !.isNotEmpty? Image.file(File(user.image!),
                                      fit: BoxFit.cover,
                                      width: 55,
                                      height: 55,):Icon(Icons.person),
                                  )),
                                ],),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                Text(user!.name,),
                                Text(user!.email,),
                                Text(user!.password,),
                              ],),
                            ),
                             Spacer(),
                             Padding(
                               padding: const EdgeInsets.only(right: 30),
                               child: InkWell(onTap: () {
                                 deleteData(index);
                               },child: Icon(Icons.delete,size: 30,)),
                             )
                          ],
                        ),
                      ],
                    ),

                  )

                );
              },
            );

          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddPage(),
              ));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
