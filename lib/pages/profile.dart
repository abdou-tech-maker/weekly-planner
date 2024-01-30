import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';
import 'package:weekly_planner/constantes/constantes.dart';

import '../models/user_model.dart';
import '../models/user_picture.dart';
import '../widgets/customAppBar.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final ImagePicker imagePicker = ImagePicker();
  XFile? image;

  void selectImages() async {
    final XFile? selectedImage = await imagePicker.pickImage(
        imageQuality: 80, source: ImageSource.gallery);
    if (selectedImage != null) {
      setState(() {
        image = selectedImage;
      });
    }

    if (image != null) {
      final userPicture = UserPicture(path: image!.path);
      UserPicture.set(userPicture);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGround,
      appBar: const MyAppBar(
        title: 'My Profile',
        edit: false,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5, top: 0, bottom: 0),
        child: ValueListenableBuilder<Box<UserModel>>(
          valueListenable: Hive.box<UserModel>('UserModel').listenable(),
          builder: (context, value, child) {
            if (value.isEmpty) {
              return const SizedBox();
            }

            return _body(context, value.values.first);
          },
        ),
      ),
    );
  }

  Widget _body(BuildContext context, UserModel user) {
    return ListView(children: [
      Center(
        child: SizedBox(
          height: 150,
          child: Stack(children: [
            ValueListenableBuilder<Box<UserPicture>>(
              valueListenable:
                  Hive.box<UserPicture>('UserPicture').listenable(),
              builder: (context, box, child) {
                if (box.isEmpty) {
                  return const CircleAvatar(
                    radius: 75,
                    backgroundColor: mainColor,
                  );
                }

                final userPictures = box.values.toList();
                log("${box.values.toList()}");
                if (userPictures.isEmpty) {
                  return const CircleAvatar(
                    radius: 75,
                    backgroundColor: mainColor,
                  );
                }

                final userPicture = userPictures.first;

                return CircleAvatar(
                  radius: 75,
                  backgroundImage: userPicture.path != null
                      ? FileImage(File(userPicture.path!))
                      : null,
                );
              },
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: CircleAvatar(
                backgroundColor: mainColor,
                child: IconButton(
                  icon: const Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    selectImages();
                  },
                ),
              ),
            ),
          ]),
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      _profileTile(
        user.fullname,
        "Nom",
        const Icon(
          Icons.group,
          color: mainColor,
        ),
        true,
      ),
      _profileTile(
          user.username,
          "Prènom",
          const Icon(
            Icons.person,
            color: mainColor,
          ),
          true),
      _profileTile(
          user.role,
          "Role",
          const Icon(
            Icons.roller_shades,
            color: mainColor,
          ),
          true),
      _profileTile(
        user.phone ?? "+213666666666",
        "Phone number",
        const Icon(
          Icons.phone,
          color: mainColor,
        ),
        true,
      ),

      // Padding(
      //   padding: const EdgeInsets.all(12.0),
      //   child: InkWell(
      //     onTap: () {
      //       signOut();
      //     },
      //     child: Container(
      //         padding:
      //             const EdgeInsets.only(left: 4, right: 4, top: 12, bottom: 12),
      //         decoration: ShapeDecoration(
      //           shape: RoundedRectangleBorder(
      //             side: const BorderSide(width: 1, color: Color(0xFFE30000)),
      //             borderRadius: BorderRadius.circular(4),
      //           ),
      //         ),
      //         child: Row(
      //           children: [
      //             const Icon(
      //               Icons.power_settings_new,
      //               color: Colors.red,
      //               size: 20,
      //             ),
      //             const SizedBox(
      //               width: 25,
      //             ),
      //             Text(
      //               "Log Out",
      //               style: GoogleFonts.roboto(
      //                   color: Colors.red,
      //                   fontSize: 18,
      //                   fontWeight: FontWeight.w400),
      //             )
      //           ],
      //         )),
      //   ),
      // ),
    ]);
  }

  Widget _profileTile(
      dynamic maintext, String header, Widget? icon, bool isTitle) {
    return SizedBox(
      height: 60,
      child: ListTile(
        leading: icon,
        dense: true,
        isThreeLine: true,
        title: isTitle
            ? Text(
                header,
                style: GoogleFonts.roboto(
                    color: liteTxt, fontSize: 12, fontWeight: FontWeight.w500),
              )
            : const SizedBox.shrink(),
        subtitle: Text(
          maintext ?? "full Name",
          style: GoogleFonts.roboto(
              color: blackText, fontSize: 18, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
