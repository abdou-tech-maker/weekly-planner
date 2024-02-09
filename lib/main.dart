// ignore_for_file: library_prefixes

import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:weekly_planner/mainScreen.dart';

import 'firebase_options.dart';
import 'models/user_model.dart';
import 'models/user_picture.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Directory directory = await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);

  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(UserPictureAdapter());
  await Hive.openBox<UserModel>('UserModel');
  await Hive.openBox<UserPicture>('UserPicture');
  var user =
      UserModel(id: 1, username: 'Maher', fullname: 'Bekkouche', role: 'Manager'
          // Add other properties here
          );

  // Save the user to the Hive box
  await UserModel.set(user);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
      home: const MainScreen(),
    );
  }
}
