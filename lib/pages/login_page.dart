import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_media_koko/components/my_textfield.dart';
import 'package:social_media_koko/helper/helper_function.dart';
import 'package:social_media_koko/pages/home_page.dart';
import '../components/my_button.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();

  TextEditingController paswordController = TextEditingController();

  void login() async {
//   show loading circle
    showDialog(
        context: context,
        builder: (context) => Center(
              child: CircularProgressIndicator(),
            ));
    //   try to sign in

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: paswordController.text);

      //   pop loading
      if (context.mounted) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }
    }
    // for display any error
    on FirebaseAuthException catch (e) {
      //   pop loading circle
      Navigator.pop(context);
      displayMessageToUser(e.code, context);
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
                height: 50,
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
                text: "Login",
                onTap: login,
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                  GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        "Register",
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
