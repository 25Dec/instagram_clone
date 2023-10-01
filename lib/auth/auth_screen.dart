// ignore_for_file: deprecated_member_use, use_build_context_synchronously
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/services/functions/auth_methods.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:instagram_clone/widgets/global/custom_text_field_input.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  Uint8List? image;
  bool isLoading = false;

  bool isSignIn = true;

  void signUp() async {
    setState(() {
      isLoading = true;
    });

    String res = await AuthMethods.signUp(
      email: emailController.text,
      password: passwordController.text,
      username: usernameController.text,
      bio: bioController.text,
      file: image!,
    );

    setState(() {
      isLoading = false;
    });

    if (res != "success") {
      AppUtils.showSnackBar(context, res);
    }
  }

  void signIn() async {
    setState(() {
      isLoading = true;
    });

    String res = await AuthMethods.signIn(
        email: emailController.text, password: passwordController.text);

    setState(() {
      isLoading = false;
    });

    if (res == "success") {
    } else {
      AppUtils.showSnackBar(context, res);
    }
  }

  void selectImage() async {
    Uint8List img = await AppUtils.pickImage(ImageSource.gallery);

    setState(() {
      image = img;
    });
  }

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    bioController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 1,
                child: Container(),
              ),
              SvgPicture.asset(
                "assets/icons/ic_instagram.svg",
                color: AppColors.primaryColor,
                height: 64,
              ),
              const SizedBox(
                height: 64,
              ),
              if (!isSignIn)
                Stack(
                  children: [
                    image != null
                        ? CircleAvatar(
                            radius: 64,
                            backgroundImage: MemoryImage(image!),
                          )
                        : const CircleAvatar(
                            radius: 64,
                            backgroundImage: NetworkImage(
                              "https://as2.ftcdn.net/v2/jpg/04/33/52/01/1000_F_433520193_85OMr4384m2WI8I0vxvge9dcvlm2xqqv.jpg",
                            ),
                          ),
                    Positioned(
                      bottom: -10,
                      right: -12,
                      child: IconButton(
                        onPressed: selectImage,
                        icon: const Icon(Icons.add_a_photo),
                      ),
                    ),
                  ],
                ),
              const SizedBox(
                height: 32,
              ),
              if (!isSignIn)
                CustomTextFieldInput(
                  hintText: "Username",
                  controller: usernameController,
                  textInputType: TextInputType.text,
                ),
              const SizedBox(
                height: 16,
              ),
              CustomTextFieldInput(
                hintText: "Email",
                controller: emailController,
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 16,
              ),
              CustomTextFieldInput(
                hintText: "Password",
                controller: passwordController,
                textInputType: TextInputType.text,
                isSecure: true,
              ),
              const SizedBox(
                height: 16,
              ),
              if (!isSignIn)
                CustomTextFieldInput(
                  hintText: "Bio",
                  controller: bioController,
                  textInputType: TextInputType.text,
                ),
              const SizedBox(
                height: 32,
              ),
              InkWell(
                onTap: isSignIn ? () => signIn() : () => signUp(),
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                    ),
                    color: AppColors.blueColor,
                  ),
                  child: isLoading
                      ? const SpinKitDualRing(
                          color: Colors.white,
                        )
                      : Text(isSignIn ? "Sign In" : "Sign Up"),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Flexible(
                flex: 2,
                child: Container(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      isSignIn ? "Don't have an account?" : "Already have an account?",
                    ),
                  ),
                  GestureDetector(
                    onTap: () => setState(() {
                      isSignIn = !isSignIn;
                    }),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      margin: const EdgeInsets.only(left: 2),
                      child: Text(
                        isSignIn ? "Sign Up" : "Sign In",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
