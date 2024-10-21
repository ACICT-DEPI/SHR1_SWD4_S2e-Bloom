import 'package:bloom/models/user_model.dart';
import 'package:bloom/ui/screens/edit_profile.dart';
import 'package:bloom/ui/screens/setting.dart';
import 'package:bloom/ui/welcome.dart';
import 'package:bloom/ui/widgets/profile_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bloom/constants.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserModel? userData;

  bool loading = true ;

    void initState() {
// TODO: implement initState
    super.initState();
    UserModelProvider().getUserData().then((user) {
      setState(() {
        userData = user;
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: loading ? const Center(child: CircularProgressIndicator()) :
          userData != null ?
          SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment. start,
          children: [
            Stack(
              alignment: const Alignment(-1.1 , 10.0),
              
              children:[
                Container(
                height: 140,
                width: double.infinity,
                child: Image.asset("assets/images/splash.jpg" ,
                fit: BoxFit.cover,),
              ),
            Container(
              width: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Constants.primaryColor.withOpacity(.5),
                  width: 5.0,
                ),
              ),
              child:  CircleAvatar(
                radius: 60,
                //backgroundImage: ExactAssetImage('${userData!.image!}'),
              ),
            ),
              ] 
            ),
            const SizedBox(height: 30,),
            Text('${userData!.name!}' , style: Constants.style1,),
            Text('Email : ${userData!.email!}' , style: Constants.style4,),
            Text('Phone : ${userData!.phone!}' , style: Constants.style4,),
            Text('Age : ${userData!.age!}' , style: Constants.style4,),
            Text('Gender: ${userData!.gender!}' , style: Constants.style4,),
            const SizedBox(height: 20,),

            Align(
              alignment: Alignment.center,
              child: Container(
                width: double.infinity,
                child: MaterialButton(onPressed: () {
                   Navigator.push(
                     context, MaterialPageRoute(builder: (BuildContext) =>  const EditProfileScreen()));
                } ,
                color: Constants.primaryColor,
                child: Text("Edit Profile" , style: Constants.style6,),),
              ),
            ),
                

        
          // children: [
          //   Container(
          //     width: 150,
          //     decoration: BoxDecoration(
          //       shape: BoxShape.circle,
          //       border: Border.all(
          //         color: Constants.primaryColor.withOpacity(.5),
          //         width: 5.0,
          //       ),
          //     ),
          //     child: const CircleAvatar(
          //       radius: 60,
          //       backgroundImage: ExactAssetImage('assets/images/profile.jpg'),
          //     ),
          //   ),
          //   const SizedBox(
          //     height: 10,
          //   ),
          //   SizedBox(
          //     width: size.width * .5,
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         Text(
          //           'John Doe',
          //           style: TextStyle(
          //             color: Constants.blackColor,
          //             fontSize: 20,
          //           ),
          //         ),
          //         SizedBox(
          //             height: 24,
          //             child: Image.asset("assets/images/verified.png")),
          //       ],
          //     ),
          //   ),
          //   Text(
          //     'johndoe@gmail.com',
          //     style: TextStyle(
          //       color: Constants.blackColor.withOpacity(.3),
          //     ),
          //   ),
          //   const SizedBox(
          //     height: 30,
          //   ),
            Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const ProfileWidget(
                    icon: Icons.person,
                    title: 'My Profile',
                  ),
                    InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute( builder: (context) => const SettingPage()));},
                    child:
                  const ProfileWidget(
                    icon: Icons.settings,
                    title: 'Settings',
                  ),
                    ),
                  const ProfileWidget(
                    icon: Icons.notifications,
                    title: 'Notifications',
                  ),
                  const ProfileWidget(
                    icon: Icons.chat,
                    title: 'FAQs',
                  ),
                  const ProfileWidget(
                    icon: Icons.share,
                    title: 'Share',
                  ),
                  InkWell(
                    onTap: () {
                      FirebaseAuth.instance.signOut();
                      GoogleSignIn().disconnect();
                      Navigator.pushReplacement(context, MaterialPageRoute( builder: (context) => const WelcomScreen()));},
                    child: const ProfileWidget(
                      icon: Icons.logout,
                      title: 'Log Out',
                    ),
                  ),
                ],
              )
          ]
        ),
      )
    ): const Center(
                 child:  Text("Failed to load data"),
      ),
    );
  }
}
