import 'package:hive_flutter/adapters.dart';
part 'userModel.g.dart';
@HiveType(typeId: 0)
class UserModel extends HiveObject {
  @HiveField(0)
   String name;
  @HiveField(1)
  String email;
  @HiveField(2)
  String password;
  @HiveField(3)
  String image;
  UserModel({required this.name, required this.email,required this.password,required this.image});


}
