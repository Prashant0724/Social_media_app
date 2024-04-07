import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_media_koko/components/my_list_tile.dart';
import 'package:social_media_koko/components/my_post_button.dart';
import 'package:social_media_koko/components/my_textfield.dart';
import 'package:social_media_koko/database/firestore.dart';

import '../components/my_drawer.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  //  logout user
  // void logout(){
  //   FirebaseAuth.instance.signOut();
  // }

  //

  // firestore access
  final FireStoreDatabase database = FireStoreDatabase();

  final TextEditingController newPostController = TextEditingController();

  // post message
  void postMessage() {
    //   only post message if there is something in the textField
    if (newPostController.text.isNotEmpty) {
      String message = newPostController.text;
      database.addPost(message);
    }

    //   clear the controller
    newPostController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
        title: Text("W A L L"),

        // actions: [
        // //   logout button
        //   IconButton(onPressed: logout, icon: Icon(Icons.logout),)
        // ],
      ),
      drawer: MyDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              children: [
                // textField
                Expanded(
                  child: MyTextField(
                      hintText: "Say Something.",
                      obscureText: false,
                      controller: newPostController),
                ),

                //   post button
                PostButton(onTap: postMessage),
              ],
            ),
          ),

          //   posts
          StreamBuilder(
              stream: database.getPostsStream(),
              builder: (context, snapshot) {
                //show loading circle
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                // get all posts
                final posts = snapshot.data!.docs;

                // if no data?
                if (snapshot.data == null || posts.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.all(25),
                      child: Text("No posts... Post something!"),
                    ),
                  );
                }

                //   return as a list
                return Expanded(
                    child: ListView.builder(itemBuilder: (context, index) {
                  //   get each individual post
                  final post = posts[index];

                  //   get data from each post
                  String message = post['PostMessage'];
                  String userEmail = post['UserEmail'];
                  Timestamp timestamp = post['TimeStamp'];

                  //   return as a list tile
                  return MyListTile(title: message, subTitle: userEmail);
                }));
              })
        ],
      ),
    );
  }
}
