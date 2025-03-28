import 'package:authentication_app_exam/controller/user_controller.dart';
import 'package:authentication_app_exam/helper/firebase_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavUser extends StatefulWidget {
  const FavUser({super.key});

  @override
  State<FavUser> createState() => _FavUserState();
}

class _FavUserState extends State<FavUser> {
  final userController = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favourite User'),
      ),
      body: Obx(() {
        var favoriteUsers = FirebaseHelper.firebaseHelper.allFavUsers
            .where((user) => user.isFavorite)
            .toList();
        return ListView.builder(
          itemCount: favoriteUsers.length,
          itemBuilder: (context, index) {
            var user = favoriteUsers[index];
            return ListTile(
              title: Text(user.name),
              subtitle: Text('abc@gmail.com'),
              trailing: Icon(Icons.favorite, color: Colors.red),
            );
          },
        );
      }),
    );
  }
}
