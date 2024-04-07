import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:social_media_koko/auth/login_or_register.dart';
import 'package:social_media_koko/pages/home_page.dart';
import 'package:social_media_koko/pages/login_page.dart';
import 'package:social_media_koko/pages/profile_page.dart';
import 'package:social_media_koko/pages/register_page.dart';
import 'package:social_media_koko/pages/users_page.dart';
import 'package:social_media_koko/theme/dark_mode.dart';
import 'package:social_media_koko/theme/light_mode.dart';

import 'auth/auth.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
    await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyBVrBY2BVxATUyqWo-m5fFbcJI1M1dnKHg",
          appId: "1:351220738916:web:dcd9cf16e8180eb7572871",
          messagingSenderId: "351220738916",
          projectId: "social-app-koko",
      )
    );
  }
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: lightMode,
      darkTheme: darkMode,
      // home: LoginPage(),
      // home: RegisterPage(),
      // home: LoginOrRegister(),
      home: AuthPage(),
      // home: HomePage(),
      routes: {
        '/login_register_page':(context)=>LoginOrRegister(),
        '/home_page':(context)=>HomePage(),
        '/profile_page':(context)=>ProfilePage(),
        '/users_page':(context)=>UserPage(),
      },
    );
  }
}
