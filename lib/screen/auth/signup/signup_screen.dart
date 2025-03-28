import 'package:authentication_app_exam/controller/user_controller.dart';
import 'package:authentication_app_exam/model/user_model.dart';
import 'package:authentication_app_exam/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController pswController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    UserController controller = Get.put(UserController());
    return Scaffold(
      appBar: AppBar(
        title: Text('Signup Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GetBuilder<UserController>(builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('UserName'),
              TextField(
                controller: usernameController,
              ),
              SizedBox(
                height: 20,
              ),
              Text('email'),
              TextField(
                controller: emailController,
              ),
              SizedBox(
                height: 20,
              ),
              Text('PSW'),
              TextField(
                obscureText: true,
                controller: pswController,
              ),
              SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () {
                  UserModel model = UserModel(
                      name: usernameController.text,
                      email: emailController.text,
                      password: pswController.text,
                      id: 0);

                  controller.insertUser(model: model).then(
                    (value) {
                      Get.offNamed(AppRoutes.home);
                    },
                  );
                },
                child: Text('Signup'),
              )
            ],
          );
        }),
      ),
    );
  }
}
