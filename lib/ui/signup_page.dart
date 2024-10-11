import 'package:bloom/constants.dart';
import 'package:bloom/ui/signin_page.dart';
import 'package:bloom/ui/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  bool passToggle = true;
   bool confirmpassToggle = true;
   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TextEditingController nameController ;
  late TextEditingController phoneController ;
  late TextEditingController emailController ;
  late TextEditingController passwordController ;
  late TextEditingController confirmPasswordController ;
  late TextEditingController ageController ;
  late TextEditingController genderController ;

  late String userid ;

  Future addUser({
    required String name ,
    required String phone ,
    required String email ,
    required String age ,
    required String gender
  }) async {

    FirebaseFirestore firestore = FirebaseFirestore.instance;

    await firestore.collection('users').doc(email).set({
      'name' : name ,
      'phone' : phone ,
      'email' : email,
      'age' : age ,
      'gender' : gender,
    });
  }

    @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    ageController = TextEditingController();
    genderController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    ageController.dispose();
    genderController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
       appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Constants.blackColor,
      ),
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric( horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/images/signup.png', width: size.width * 0.6 , height: size.width * 0.6 ,),
                 const SizedBox(height: 10,),
                 const Align(
                  alignment: Alignment.centerLeft,
                   child: Text(
                      'Sign Up',
                       style: TextStyle(
                        fontSize: 35.0,
                        fontWeight: FontWeight.w700, 
                      ),
                    ),
                 ),
                  const SizedBox(
                    height: 20,
                  ),
                   TextFormField(
                     controller: nameController,
                     keyboardType: TextInputType.name,
                     validator: (value) {
                       if (value!.isEmpty)  {
                         return "Name must not be empty";
                       } return null ;},
                     decoration: const InputDecoration(
                       border: OutlineInputBorder(),
                       labelText: "Full Name",
                       prefixIcon: Icon(Icons.person),
                     ),
                   ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value!.isEmpty)  {
                      return "Phone Number must not be empty";
                    } else if (value.length < 11) {
                      return " Phone Number must be 11 digit";
                    }
                     return null ;
                    },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Phone Number",
                    prefixIcon: Icon(Icons.phone),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: emailController ,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty)  {
                      return "Email address must not be empty";
                    } else if (!value.contains('@')) {
                      return "Unveiled email address , must contains @ symbol";
                    }
                    return null ;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Email Address",
                    prefixIcon: Icon(Icons.alternate_email),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: passwordController ,
                  obscureText: passToggle ? true : false,
                  obscuringCharacter: "*",
                  validator: (value) {
                    if (value!.isEmpty)  {
                      return "Password must not be empty";
                    } else if (value.length < 6) {
                      return "Password must be at least 6 characters" ;
                    }
                    return null ;
                  },
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: "Password",
                      prefixIcon: const Icon(Icons.lock_open),
                    suffixIcon: InkWell(
                      onTap: () {
                        passToggle = !passToggle ;
                        setState(() {});
                      },
                      child: passToggle
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: confirmPasswordController ,
                  obscureText: confirmpassToggle ? true : false,
                  obscuringCharacter: "*",
                  validator: (value) {
                    if (value!.isEmpty)  {
                      return "Password must not be empty";
                    } else if (value != passwordController.text) {
                      return "Password does not match" ;
                    }
                    return null ;
                  },
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: "Confirm Password",
                    prefixIcon: const Icon(Icons.lock_open),
                    suffixIcon: InkWell(
                      onTap: () {
                        confirmpassToggle = !confirmpassToggle ;
                        setState(() {});
                      },
                      child: confirmpassToggle
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: ageController,
                  keyboardType: TextInputType.number,
                  // validator: (value) {
                  //   if (value!.isEmpty)  {
                  //     return "Name must not be empty";
                  //   } return null ;},
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Age",
                    prefixIcon: Icon(Icons.calendar_month_outlined),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: genderController,
                  keyboardType: TextInputType.name,
                  // validator: (value) {
                  //   if (value!.isEmpty)  {
                  //     return "Name must not be empty";
                  //   } return null ;},
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Gender",
                    prefixIcon: Icon(Icons.male),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (_formKey.currentState!.validate())  {
                        await FirebaseAuth.instance.createUserWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text
                        ).then((value) {
                          Navigator.pushReplacement(context, MaterialPageRoute(
                              builder: (context) => const SignIn()),);
                        }).catchError((error) {
                          print(error.toString());
                        });
                        addUser(
                          name : nameController.text ,
                          phone : phoneController.text ,
                          email : emailController.text,
                          age : ageController.text ,
                          gender : genderController.text ,);
                      }
                    },
                     child: Button(
                      itext: "Sign Up",
                      bgColor: Constants.primaryColor,
                      containerWidth: size.width,
                     ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Row(
                    children: [
                      Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text('OR'),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                   Container(
                    height: 60,
                    width: size.width,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          height: 30,
                          child: Image.asset('assets/images/google.png'),
                        ),
                        const Text(
                          'Sign Up with Google',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          PageTransition(
                              child: const SignIn(),
                              type: PageTransitionType.bottomToTop));
                    },
                    child: Center(
                      child: Text.rich(
                        TextSpan(children: [
                          TextSpan(
                            text: 'Arealdy Have an Account? ',
                            style: TextStyle(
                              color: Constants.blackColor,
                            ),
                          ),
                          TextSpan(
                            text: 'Sign In',
                            style: TextStyle(
                              color: Constants.primaryColor,
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}



class PassUserData {

   String? userid;
   String? name ;
   String? phone ;
   String? email ;
   String? age ;
   String? gender ;
}