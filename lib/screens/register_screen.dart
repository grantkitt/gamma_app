import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gamma_v1/components/loginPath.dart';
import 'package:gamma_v1/components/registerPath.dart';
import 'package:gamma_v1/constants.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreen();
}

class _RegisterScreen extends State<RegisterScreen> {
  var method = [kWhite, kBlack];
  PageController _controller = PageController(
    initialPage: 0,
  );
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120),
        child: Column(children: [
          Container(height: size.height / 20),
          Padding(
              padding: EdgeInsets.only(right: size.width - 90),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: SvgPicture.asset(
                  'assets/icons/backarrow.svg',
                  color: kWhite,
                  height: 30,
                  width: 30,
                ),
              )),
          Container(
            height: size.height / 30,
          ),
          Row(
            children: [
              Container(
                width: size.width / 10,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    method[0] = kWhite;
                    method[1] = kBlack;
                    _controller.jumpToPage(0);
                  });
                },
                child: Text(
                  'Sign In',
                  style: TextStyle(
                      color: method[0],
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
              ),
              Container(
                width: size.width / 20,
              ),
              GestureDetector(
                  onTap: () {
                    setState(() {
                      method[1] = kWhite;
                      method[0] = kBlack;
                      _controller.jumpToPage(1);
                    });
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                        color: method[1],
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  )),
            ],
          ),
        ]),
      ),
      resizeToAvoidBottomInset: false,
      // body: ltextFields(),
      body: PageView(
        controller: _controller,
        onPageChanged: (index) {
          if (index == 0) {
            setState(() {
              method[0] = kWhite;
              method[1] = kBlack;
            });
          } else {
            setState(() {
              method[1] = kWhite;
              method[0] = kBlack;
            });
          }
        },
        children: [
          ltextFields(),
          textFields(),
        ],
      ), // bottomNavigationBar: MyBottomNavBar(),
      backgroundColor: backgroundColor,
    );
  }
}
