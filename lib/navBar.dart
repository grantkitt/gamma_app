import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gamma_v1/constants.dart';
import 'package:gamma_v1/screens/card_screen.dart';
import 'package:gamma_v1/screens/profile_screen.dart';

class navBar extends StatelessWidget {
  const navBar({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.transparent,
      height: 110,
      width: size.width,
      child: Stack(children: [
        Container(
            height: 75,
            width: size.width,
            decoration: BoxDecoration(
              color: kBlack,
            )),
        // Padding(
        //   padding: EdgeInsets.only(top: 20),
        //   child: ClipOval(
        //       child: Container(
        //     height: 60,
        //     width: size.width,
        //     color: kBlack,
        //   )),
        // ),
        Padding(
          padding: EdgeInsets.only(bottom: size.height / 100),
          child: Row(
            children: [
              Container(
                width: size.width / 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(next(CardScreen()));
                },
                child: SvgPicture.asset(
                  'assets/icons/card.svg',
                  color: kWhite,
                  height: 33,
                  width: 33,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(next(ProfileScreen()));
                },
                child: SvgPicture.asset(
                  'assets/icons/person.svg',
                  color: kWhite,
                  height: 33,
                  width: 33,
                ),
              ),
              Container(
                width: size.width / 20,
              ),
            ],
          ),
        ),
        Center(
          child: SvgPicture.asset(
            'assets/icons/logo.svg',
            height: 50,
            width: 50,
            color: kTheme,
          ),
        )
      ]),
    );
  }

  Route next(Widget widg) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => widg,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1, 0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
