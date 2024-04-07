import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  // current user/ logged user
  final User? currentUser = FirebaseAuth.instance.currentUser;

  //future to fetch user details
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
    return await FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUser!.email)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Profile"),
      //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      //   elevation: 0,
      // ),

      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: getUserDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          }
          //   data received
          else if (snapshot.hasData) {
            //   extract data
            Map<String, dynamic>? user = snapshot.data!.data();
            return Center(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 const Padding(
                    padding: const EdgeInsets.only(top: 50, left: 25),
                    child: Row(
                      children: [
                        BackButton(),
                      ],
                    ),
                  ),

                 const SizedBox(
                    height: 25,
                  ),

                  Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(24)),
                    padding: EdgeInsets.all(25),
                    child: Icon(
                      Icons.person,
                      size: 60,
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  // username
                  Text(
                    user!['userName'],
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  // email
                  Text(
                    user!['Email'],
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade600),
                  ),
                ],
              ),
            );
          } else {
            return Text("No data");
          }
        },
      ),
    );
  }
}
