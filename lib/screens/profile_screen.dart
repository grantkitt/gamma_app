import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gamma_v1/components/profileBody.dart';
import 'package:gamma_v1/constants.dart';
import 'package:gamma_v1/requests.dart';
import 'package:gamma_v1/screens/welcome_screen.dart';
import 'package:gamma_v1/structs.dart';
import 'dart:convert';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: Container(
            height: 70,
            child: Center(
                child: Row(
              children: [
                Container(
                  width: size.width / 15,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: SvgPicture.asset(
                      'assets/icons/backarrow.svg',
                      color: kWhite,
                      height: 30,
                      width: 30,
                    )),
                const Spacer(),
              ],
            )),
          )),
      body: FutureBuilder<dynamic>(
        future: get('/users/me'),
        builder: (context, snapshot) {
          var items = snapshot.data;
          if (items[0] == 401) {
            return WelcomeScreen();
          }
          var user = hUser.fromJson(items[1]['data']['user']);
          print(user.fname);
          return profileBody();
        },
      ),
      backgroundColor: kBackground,
    );
  }
}
