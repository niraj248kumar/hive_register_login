import 'package:hive_flutter/adapters.dart';
import 'package:sing_up_login_hive/model/userModel.dart';

class BoxPage{
 static Box<UserModel>getData()=> Hive.box<UserModel>('user');
}
