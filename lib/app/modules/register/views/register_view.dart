import 'package:ussage_app/constants/exports.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register", style: TextStyle(color: ColorManager.black)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: ColorManager.black),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        physics: const NeverScrollableScrollPhysics(),
        children: [
          PrimaryText(
            "Create an account ...",
            color: ColorManager.black,
            fontSize: 24,
            fontWeight: FontWeightManager.bold,
          ),
          PrimaryText(
            "Enter below data",
            color: ColorManager.grey,
            fontSize: 20,
            fontWeight: FontWeightManager.medium,
          ),
          PrimaryTextField(
            controller: controller.emailTextController,
            keyboardType: TextInputType.emailAddress,
            prefixIcon: const Icon(Icons.email_rounded),
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
          PrimaryTextField(
            controller: controller.fullNameTextController,
            keyboardType: TextInputType.emailAddress,
            prefixIcon: const Icon(Icons.person),
            hintText: "Full Name",
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
            onPressed: () async => await controller.performRegister(),
            title: "Register",
          ),
        ],
      ),
    );
  }
}
