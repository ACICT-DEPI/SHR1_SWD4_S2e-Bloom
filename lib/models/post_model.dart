import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PostModel {

  late final String userName;
  late final String userImage;
  late final String userid;
  late final String text;
  late final String time;
  late final String image;

  PostModel({
    required this.userName,
    required this.userImage,
    required this.userid,
    required this.text,
    required this.time,
    required this.image
  });


  Map<String, dynamic> toMap() =>
      {
        'userName': userName,
        'userImage' : userImage,
        'userid' : userid,
        'text' : text,
        'image' : image,
        'time' : time,
      };


  factory PostModel.fromJason(Map<String, dynamic> jason) =>
      PostModel(
        userName : jason["userName"],
        userImage : jason["userImage"],
        userid : jason["userid"],
        text : jason["text"],
        image : jason["image"],
        time :jason["time"],

      
      );


}

// class UserModelProvider {


//   UserModel? userModel;
//   String? user = FirebaseAuth.instance.currentUser!.uid;

//   Future<UserModel?> getUserData() async {
//     await FirebaseFirestore.instance
//           .collection('users')
//           .doc(user)
//           .get()
//           .then((value) {
//         userModel = UserModel.fromJason(value.data()!);
//         print("****************************************************");
//         print(userModel);
//         print(value.data());
//         print("****************************************************");
//       }
//       );
//       return userModel;
//     }
//   }


class CommentModel {
  CommentModel({
    required this.text,
    required this.time,
    required this.ownerName,
    required this.ownerImage,
  });

  late final String text;
  late final String time;
  late final String ownerName;
  late final String ownerImage;

  CommentModel.fromJson(Map<String, dynamic> json) {
    text = json['text'] ?? '';
    time = json['time'] ?? '';
    ownerName = json['ownerName'] ?? '';
    ownerImage = json['ownerImage'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'time': time,
      'ownerName': ownerName,
      'ownerImage': ownerImage,
    };
  }
}
