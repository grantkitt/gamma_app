import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gamma_v1/components/registerPath.dart';
import 'package:gamma_v1/constants.dart';
import 'package:gamma_v1/requests.dart';
import 'package:gamma_v1/screens/home_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gamma_v1/main.dart';
import 'dart:convert' show json, base64, ascii;

import '../screens/welcome_screen.dart';

String phoneNumber = "(xxx) xxx-xxxx";
String EMAIL = "", PASSWORD = '';

//textfield input screen
class ltextFields extends StatefulWidget {
  @override
  State<ltextFields> createState() => _ltextFields();
}

class _ltextFields extends State<ltextFields> {
  final email = TextEditingController();
  final password = TextEditingController();
  @override
  void initState() {
    super.initState();
    email.addListener(setEmail);
    password.addListener(setPass);
  }

  @override
  void setEmail() {
    EMAIL = email.text;
  }

  @override
  void setPass() {
    PASSWORD = password.text;
  }

  @override
  bool eye = true;
  String eyecon = 'assets/icons/eyeoff.svg';
  var badInfo = Colors.transparent;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(height: 50),
        textField(
            controller: email,
            obs: false,
            icon: 'assets/icons/user.svg',
            type: 'Phone, email, or username',
            input: 'username',
            changer: 1.18),
        Container(height: size.height / 35),
        Stack(
          children: [
            textField(
                controller: password,
                obs: eye,
                icon: 'assets/icons/lock.svg',
                type: 'Password',
                input: 'password',
                changer: 1.18),
            Center(
              child: Padding(
                  padding: EdgeInsets.only(left: size.width - 120, top: 20),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (eye) {
                          eye = false;
                          eyecon = 'assets/icons/eye.svg';
                        } else {
                          eye = true;
                          eyecon = 'assets/icons/eyeoff.svg';
                        }
                      });
                    },
                    child: SvgPicture.asset(
                      eyecon,
                      height: 22,
                      width: 22,
                      color: textColor,
                    ),
                  )),
            )
          ],
        ),
        Container(height: 20),
        Text(
          'Username or password is incorrect',
          style: TextStyle(color: badInfo, fontFamily: 'Alata', fontSize: 16),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () async {
            if (EMAIL == '' && PASSWORD == '') {
              setState(() {
                badInfo = Colors.redAccent;
              });
            }
            //print(EMAIL + ' ' + PASSWORD);
            if (EMAIL == '1' && PASSWORD == '1') {
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      HomeScreen(),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
              );
            } else {
              var codes = await attemptSignIn(PASSWORD, EMAIL);
              if (codes == 200) {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        HomeScreen(),
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                  ),
                );
              } else {
                setState(() {
                  badInfo = Colors.red;
                });
              }
            }
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Container(
              width: 300,
              height: 50,
              color: kTheme,
              child: const Center(
                child: Text(
                  "Sign In",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Roboto',
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(height: 10),
        GestureDetector(
          onTap: () {},
          child: Text(
            "forgot password?",
            style: TextStyle(color: kWhite, fontFamily: 'Roboto', fontSize: 16),
          ),
        ),
        Container(height: 30),
      ],
    );
  }

  // to obscure/unobscure password text
  void changeEye() {
    setState(() {
      if (eye) {
        eye = false;
        eyecon = 'assets/icons/eye.svg';
      } else {
        eye = true;
        eyecon = 'assets/icons/eyeoff.svg';
      }
    });
  }
}
