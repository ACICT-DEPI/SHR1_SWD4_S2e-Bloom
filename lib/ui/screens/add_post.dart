import 'package:bloom/constants.dart';
import 'package:flutter/material.dart';

class AddPostScreen extends StatelessWidget {
  const AddPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Post" , style: Constants.style1,),
        foregroundColor: Constants.primaryColor,
        backgroundColor: Colors.transparent,
      ),

    );
  }
}