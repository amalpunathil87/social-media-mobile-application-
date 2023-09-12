import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram/resources/auth_method.dart';
import 'package:instagram/responsive/responsive_screen.dart';
import 'package:instagram/screen/signup.dart';
import 'package:instagram/utils/color.dart';
import 'package:instagram/utils/global_variable.dart';
import 'package:instagram/widget/text_field_input.dart';

import '../responsive/mobile_screen_layout.dart';
import '../responsive/web_screen_layout.dart';
import '../utils/util.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  bool _isLoading = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
  }

  void loginuser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await Authmethod().loginuser(
        email: _emailcontroller.text, password: _passwordcontroller.text);

    if (res == 'success') {
      //
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) => const responsivelayout(
                MobileScreenLayout: MobileScreenLayout(),
                WebScreenLayout: WebScreenLayout())),
      );
    } else {
      //
      // ignore: use_build_context_synchronously
      showsnackbar(res, context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void navigatetosignup() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => signup()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Container(
        padding: MediaQuery.of(context).size.width > WebScreenSize
            ? EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 3)
            : const EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 124,
            ),
            // svg_image
            // SvgPicture.asset(
            //   'image/ic_instagram.svg',
            //   color: primaryColor,
            //   height: 64,
            // ),
            Image.asset(
              "image/frd5.jpg",
              height: 114,
            ),
            const SizedBox(
              height: 24,
            ),
            //  text field input for email
            textfieldinput(
                textEditingController: _emailcontroller,
                hinttext: "Enter your email",
                textInputType: TextInputType.emailAddress),
            const SizedBox(
              height: 24,
            ),
            //text field input for password
            textfieldinput(
              textEditingController: _passwordcontroller,
              hinttext: "Enter your password",
              textInputType: TextInputType.text,
              isPass: true,
            ),
            const SizedBox(
              height: 24,
            ),
            //login button
            InkWell(
              onTap: loginuser,
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
                    : const Text("login"),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Flexible(
              flex: 2,
              child: Container(),
            ),
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
                  onTap: navigatetosignup,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                    child: const Text(
                      "Sign Up.",
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
      )),
    );
  }
}
