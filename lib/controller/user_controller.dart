import 'package:authentication_app_exam/helper/db_helper.dart';
import 'package:authentication_app_exam/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  Future<List<UserModel>>? allUser;

  void fetchUserData() {
    allUser = DbHelper.dbHelper.fetchUser();
    update();
  }

  Future<void> insertUser({required UserModel model}) async {
    int? res = await DbHelper.dbHelper.insertUser(model: model);
    if (res != null) {
      Get.snackbar(
        "Inserted",
        "User inserted....",
        backgroundColor: Colors.green.shade300,
      );
      fetchUserData();
      update();
    } else {
      Get.snackbar(
        "Failed",
        "User failed....",
        backgroundColor: Colors.red.shade300,
      );
    }
  }

  Future<void> updateUser({required UserModel model}) async {
    int? res = await DbHelper.dbHelper.updateUser(model: model);
    if (res != null) {
      Get.snackbar(
        'Update',
        "User is updated...",
        colorText: Colors.white,
        backgroundColor: Colors.green.withOpacity(0.7),
      );
      fetchUserData();
    } else {
      Get.snackbar(
        'Failed',
        "User is updation failed...",
        colorText: Colors.white,
        backgroundColor: Colors.red.withOpacity(0.7),
      );
    }
  }

  Future<void> deleteUser({required int id}) async {
    int? res = await DbHelper.dbHelper.deleteUser(id: id);
    if (res != null) {
      Get.snackbar(
        'Delete',
        "User is Delete...",
        colorText: Colors.white,
        backgroundColor: Colors.green.withOpacity(0.7),
      );
      fetchUserData();
      update();
    } else {
      Get.snackbar(
        'Failed',
        "User Deletion is failed...",
        colorText: Colors.white,
        backgroundColor: Colors.red.withOpacity(0.7),
      );
    }
    Get.back();
  }

  void showUserForm({UserModel? user}) {
    TextEditingController nameController =
        TextEditingController(text: user?.name ?? "");
    TextEditingController emailController =
        TextEditingController(text: user?.email ?? "");
    TextEditingController passwordController =
        TextEditingController(text: user?.password ?? "");

    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(16),
        height: 400,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user == null ? "Add User" : "Update User",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (user != null)
                  ElevatedButton(
                    onPressed: () {
                      deleteUser(id: user.id!);
                      Get.back();
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: Text("Delete"),
                  ),
                ElevatedButton(
                  onPressed: () {
                    if (user == null) {
                      insertUser(
                        model: UserModel(
                          name: nameController.text,
                          email: emailController.text,
                          password: passwordController.text,
                        ),
                      );
                    } else {
                      updateUser(
                        model: UserModel(
                          id: user.id,
                          name: nameController.text,
                          email: emailController.text,
                          password: passwordController.text,
                        ),
                      );
                    }
                    Get.back();
                  },
                  child: Text(user == null ? "Add" : "Update"),
                ),
              ],
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }
}
