// ignore_for_file: prefer_const_constructors

import 'package:ussage_app/app/routes/app_pages.dart';
import 'package:ussage_app/constants/exports.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: PrimaryText(
          "Login",
          color: ColorManager.black,
          fontSize: 25,
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: ColorManager.white,
        iconTheme: IconThemeData(color: ColorManager.black),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        physics: NeverScrollableScrollPhysics(),
        children: [
          PrimaryText(
            "Welcome Back ..",
            color: ColorManager.primary,
            fontSize: 20,
            fontWeight: FontWeightManager.medium,
          ),
          PrimaryText(
            "Enter Email & Password",
            fontSize: 18,
            color: ColorManager.black,
          ),
          PrimaryTextField(
            controller: controller.emailTextController,
            keyboardType: TextInputType.emailAddress,
            prefixIcon: Icon(Icons.email_rounded),
            hintText: "Email",
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                width: 1,
                color: Colors.grey,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                width: 1,
                color: Colors.blue,
              ),
            ),
          ),
          PasswordTextField(
            hintText: "Password",
            controller: controller.passwordTextController,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                width: 1,
                color: Colors.grey,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                width: 1,
                color: Colors.blue,
              ),
            ),
          ),
          SizedBox(height: 20.h),
          PrimaryButton(
            onPressed: () async => controller.performLogin(),
            title: "Login",
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              PrimaryText(
                "Don't Have an account?",
                color: ColorManager.black,
              ),
              TextButton(
                onPressed: () => Get.toNamed(Routes.REGISTER),
                child: PrimaryText(
                  "Create Now!",
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          TextButton(
            onPressed: () => Get.toNamed(Routes.FORGET_PASSWORD),
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: const Size(0, 10),
            ),
            child: PrimaryText(
              "Forget Password?",
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
