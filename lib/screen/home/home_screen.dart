import 'package:authentication_app_exam/controller/user_controller.dart';
import 'package:authentication_app_exam/helper/db_helper.dart';
import 'package:authentication_app_exam/helper/firebase_helper.dart';
import 'package:authentication_app_exam/model/user_model.dart';
import 'package:authentication_app_exam/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          userController.showUserForm();
        },
        child: Text('Add User'),
      ),
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        title: Text('Home Screen'),
        actions: [
          IconButton(
              onPressed: () {
                Get.toNamed(AppRoutes.fav);
              },
              icon: Icon(
                Icons.favorite,
                color: Colors.red,
              )),
        ],
      ),
      body: GetBuilder<UserController>(builder: (context) {
        return FutureBuilder(
          future: DbHelper.dbHelper.fetchUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text("No Users Found"));
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error : ${snapshot.error}',
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }

            if (snapshot.hasData) {
              List<UserModel> userData = snapshot.data ?? [];

              return userData.isNotEmpty
                  ? ListView.builder(
                      itemCount: userData.length,
                      itemBuilder: (context, index) {
                        var user = userData[index];
                        return ListTile(
                          leading: CircleAvatar(
                            child: Text('${user.id}'),
                          ),
                          title: Text('${user.name}'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${user.email}'),
                              Text('${user.password}'),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  userController.showUserForm(user: user);
                                },
                              ),
                              IconButton(
                                icon: Icon(
                                  user.isFavorite
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: user.isFavorite
                                      ? Colors.red
                                      : Colors.grey,
                                ),
                                onPressed: () {
                                  FirebaseHelper.firebaseHelper.toggleFavorite(
                                      user.id.toString(), user.isFavorite);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        );
      }),
    );
  }
}
