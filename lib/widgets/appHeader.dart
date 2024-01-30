// ignore_for_file: file_names

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:weekly_planner/constantes/constantes.dart';
import 'package:weekly_planner/models/user_picture.dart';

import '../pages/profile.dart';

class MyHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? search;

  const MyHeader({Key? key, required this.title, this.search})
      : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leadingWidth: 14,
      actions: [
        search ?? const SizedBox.shrink(),
        const SizedBox(
          width: 5,
        ),
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: ValueListenableBuilder<Box<UserPicture>>(
              valueListenable:
                  Hive.box<UserPicture>('UserPicture').listenable(),
              builder: (context, value, child) {
                if (value.isEmpty) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        CupertinoPageRoute(
                            builder: (context) => const Profile()),
                      );
                    },
                    child: const CircleAvatar(
                      radius: 16,
                    ),
                  );
                } else {
                  final userPicture = value.values.first;
                  return InkWell(
                    onTap: () {
                      PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
                        context,
                        settings: const RouteSettings(name: ""),
                        screen: const Profile(),
                        withNavBar: false,
                        pageTransitionAnimation:
                            PageTransitionAnimation.cupertino,
                      );
                    },
                    child: CircleAvatar(
                      radius: 15,
                      backgroundImage: userPicture.path != null
                          ? FileImage(File(userPicture.path!))
                          : null,
                    ),
                  );
                }
              },
            )),
      ],
      title: Text(
        title,
        style: const TextStyle(
            fontSize: 24, color: mainColor, fontWeight: FontWeight.bold),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
    );
  }
}
