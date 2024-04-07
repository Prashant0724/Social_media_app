import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_media_koko/components/my_list_tile.dart';
import 'package:social_media_koko/helper/helper_function.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Users"),
      //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      //   elevation:0,
      // ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Users").snapshots(),
        builder: (context,snapshot){
          if(snapshot.hasError){
            displayMessageToUser("Something went wrong", context);
          }

          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if(snapshot.data == null ){
            return Text("No data found");
          }

        //   get al users
          final users = snapshot.data!.docs;

          return Column(
            children: [

              const Padding(
                padding: const EdgeInsets.only(top: 50, left: 25),
                child: Row(
                  children: [
                    BackButton(),
                  ],
                ),
              ),

              // const SizedBox(
              //   height: 25,
              // ),
              
              // list of users in the app
              Expanded(
                child: ListView.builder(
                    itemCount: users.length,
                    padding: EdgeInsets.all(0),
                    itemBuilder:(context , index){
                    //   get individual user
                      final user = users[index];

                      // get data from each user
                      String  username = user['username'];
                      String email = user['email'];
                      return MyListTile(title: username, subTitle: email);
                    },
                
                ),
              ),
            ],
          );



        },
      ),
    );
  }
}
