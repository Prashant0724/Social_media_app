import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

void logout(){
  FirebaseAuth.instance.signOut();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              //   header
              DrawerHeader(
                  child: Icon(
                Icons.favorite,
                color: Theme.of(context).colorScheme.inversePrimary,
              )),
              const SizedBox(
                height: 25,
              ),
              //   home tile
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.home,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  title: Text("H O M E"),
                  onTap: () {
                    //   this is already the home screen so just pop drawer
                    Navigator.pop(context);
                  },
                ),
              ),

              const SizedBox(
                height: 20,
              ),
              // profile tile
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.person,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  title: Text("P R O F I L E"),
                  onTap: () {
                    // pop drawer
                    Navigator.pop(context);
                    Navigator.pushNamed(context,'/profile_page');
                  },
                ),
              ),

              const SizedBox(
                height: 20,
              ),
              // profile tile
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.group,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  title: Text("U S E R S"),
                  onTap: () {
                    Navigator.pop(context);
                    //   this is already the home screen so just pop drawer
                    Navigator.pushNamed(context,'/users_page');
                  },
                ),
              ),
            ],
          ),
          //   logout
          Padding(
            padding: const EdgeInsets.only(left: 25.0,bottom: 25),
            child: ListTile(
              leading: Icon(
                Icons.logout,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              title: const Text("L O G O U T"),
              onTap: () {
                //   this is already the home screen so just pop drawer
                logout();
                Navigator.pop(context);
                // logout();
              },
            ),
          ),
        ],
      ),
    );
  }
}
