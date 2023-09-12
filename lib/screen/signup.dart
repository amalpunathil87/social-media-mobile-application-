import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/responsive/mobile_screen_layout.dart';
import 'package:instagram/screen/login.dart';
import 'package:instagram/utils/util.dart';
import 'package:instagram/widget/text_field_input.dart';

import '../resources/auth_method.dart';
import '../responsive/responsive_screen.dart';
import '../responsive/web_screen_layout.dart';
import '../utils/color.dart';

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _biocontroller = TextEditingController();
  final TextEditingController _usernamecontroller = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    _biocontroller.dispose();
    _usernamecontroller.dispose();
  }

  void selectimage() async {
    Uint8List as = await pickimage(ImageSource.gallery);
    setState(() {
      _image = as;
    });
  }

  void signupuser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await Authmethod().signupuser(
      email: _emailcontroller.text,
      password: _passwordcontroller.text,
      username: _usernamecontroller.text,
      bio: _biocontroller.text,
      file: _image!,
    );
    setState(() {
      _isLoading = false;
    });
    if (res != 'success') {
      // ignore: use_build_context_synchronously
      showsnackbar(res, context);
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) => const responsivelayout(
                MobileScreenLayout: MobileScreenLayout(),
                WebScreenLayout: WebScreenLayout())),
      );
    }
  }

  void navigatetoslogin() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const login()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 64,
              ),
              // svg_image
              // SvgPicture.asset(
              //   'image/ic_instagram.svg',
              //   color: primaryColor,
              //   height: 64,
              // ),
              Image.asset(
                "image/frd5.jpg",
              ),
              const SizedBox(
                height: 4,
              ),
              //circular widget to accept and show our selected file
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(_image!),
                        )
                      : const CircleAvatar(
                          radius: 64,
                          backgroundImage:
                              // AssetImage('image/dog1.jpg')
                              NetworkImage(
                                  'https://imgs.search.brave.com/ma7sEjlAFcmBAqpdxMvbQfehHQhOJ3dq-l8rWJdCTq0/rs:fit:860:0:0/g:ce/aHR0cHM6Ly90NC5m/dGNkbi5uZXQvanBn/LzAwLzY0LzY3LzYz/LzM2MF9GXzY0Njc2/MzgzX0xkYm1oaU5N/NllwemIzRk00UFB1/RlA5ckhlN3JpOEp1/LmpwZw')),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: selectimage,
                      icon: const Icon(Icons.add_a_photo),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 14,
              ),
              //text field input for username
              textfieldinput(
                  textEditingController: _usernamecontroller,
                  hinttext: "Enter your username",
                  textInputType: TextInputType.text),
              const SizedBox(
                height: 14,
              ),
              //  text field input for email
              textfieldinput(
                  textEditingController: _emailcontroller,
                  hinttext: "Enter your email",
                  textInputType: TextInputType.emailAddress),
              const SizedBox(
                height: 14,
              ),
              //text field input for password
              textfieldinput(
                textEditingController: _passwordcontroller,
                hinttext: "Enter your password",
                textInputType: TextInputType.text,
                isPass: true,
              ),
              const SizedBox(
                height: 14,
              ),
              //text field for bio
              textfieldinput(
                  textEditingController: _biocontroller,
                  hinttext: "Enter your bio",
                  textInputType: TextInputType.text),
              const SizedBox(
                height: 14,
              ),
              const SizedBox(
                height: 14,
              ),
              //login button
              InkWell(
                onTap: signupuser,
                // () async {
                //   String res = await Authmethod().signupuser(
                //     email: _emailcontroller.text,
                //     password: _passwordcontroller.text,
                //     username: _usernamecontroller.text,
                //     bio: _biocontroller.text,
                //     file:_image!,
                //   );
                //   print(res);}

                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    color: Colors.blue,
                  ),
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        )
                      : const Text("SignUp"),
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              // Flexible(
              //   flex: 2,
              //   child: Container(),
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                    child: const Text("Dont have an account?"),
                  ),
                  GestureDetector(
                    onTap: navigatetoslogin,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                      ),
                      child: const Text(
                        "Log in.",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              )
              //transitioning to signing
            ],
          ),
        ),
      )),
    );
  }
}
