import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class UserModel {

  String? email;
  String? name;
  String? phone;
  String? age;
  String? gender;
  String? userid;
  String? image;


  UserModel({this.email, this.name, this.phone, this.age, this.gender, this.userid, this.image } );

  Map<String, dynamic> toJason() =>
      {
        'name': name,
        'phone': phone,
        'email': email,
        'age': age,
        'gender': gender,
        'userid' : userid,
        'image' : image,
      };


  factory UserModel.fromJason(Map<String, dynamic> jason) =>
      UserModel(
        name: jason["name"],
        email: jason["email"],
        phone: jason["phone"],
        age: jason["age"],
        gender: jason["gender"],
        userid: jason["userid"],
        image : jason["image"],
      );


}

class UserModelProvider {


  UserModel? userModel;
  String? user = FirebaseAuth.instance.currentUser!.uid;

  Future<UserModel?> getUserData() async {
    await FirebaseFirestore.instance
          .collection('users')
          .doc(user)
          .get()
          .then((value) {
        userModel = UserModel.fromJason(value.data()!);
        print("****************************************************");
        print(userModel);
        print(value.data());
        print("****************************************************");
      }
      );
      return userModel;
    }
  }
