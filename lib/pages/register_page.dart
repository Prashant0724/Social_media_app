import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../components/my_button.dart';
import '../components/my_textfield.dart';
import '../helper/helper_function.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController userNameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController paswordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  void register() async {
    //    show loading circle
    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));

    //   make sure password match
    if (paswordController.text == confirmPasswordController.text) {
      //   pop loading circle
      Navigator.pop(context);

      //   show error msg
      displayMessageToUser("Password don't match", context);
    }

    //   try creating the user
    try {
      UserCredential? userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text, password: paswordController.text);

      // create a user document and add to fireStore
      createUserDocument(userCredential);

      //   pop loading circle
      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      //   pop loading circle
      Navigator.pop(context);

      //   display error message to user
      displayMessageToUser(e.code, context);
    }
  }

  // create a user document and collect them in fireStore
  Future<void> createUserDocument(UserCredential? userCredential) async {
    if (userCredential != null && userCredential.user != null) {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(userCredential.user!.email)
          .set({
        'Email': userCredential.user!.email,
        'userName': userNameController.text
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              Icon(
                Icons.person_outline,
                size: 80,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                "M I N I M A L",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 40,
              ),
              MyTextField(
                  hintText: "User name",
                  obscureText: false,
                  controller: userNameController),
              const SizedBox(
                height: 15,
              ),
              MyTextField(
                  hintText: "Email",
                  obscureText: false,
                  controller: emailController),
              SizedBox(
                height: 15,
              ),
              MyTextField(
                  hintText: "Password",
                  obscureText: true,
                  controller: paswordController),
              const SizedBox(
                height: 15,
              ),
              MyTextField(
                  hintText: "Password",
                  obscureText: true,
                  controller: confirmPasswordController),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Forgot Password?",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              MyButton(
                text: "Register",
                onTap: register,
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                  GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        "LogIn",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
