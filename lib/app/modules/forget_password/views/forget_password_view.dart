import 'package:ussage_app/constants/exports.dart';

import '../controllers/forget_password_controller.dart';

class ForgetPasswordView extends GetView<ForgetPasswordController> {
  const ForgetPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: PrimaryText(
          "Forget Password",
          fontSize: 20,
          color: ColorManager.black,
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: ColorManager.white,
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
            "Enter Email to send resetting code",
            color: ColorManager.grey,
            fontSize: 20,
            fontWeight: FontWeightManager.medium,
          ),
          SizedBox(height: 20.h),
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
          SizedBox(height: 20.h),
          PrimaryButton(
            onPressed: () async => controller.performForgetPassword(),
            title: "Request Code",
          ),
        ],
      ),
    );
  }
}
