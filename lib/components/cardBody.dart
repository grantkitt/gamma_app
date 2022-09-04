import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gamma_v1/components/pickerBody.dart';
import 'package:gamma_v1/constants.dart';
import 'package:qr_flutter/qr_flutter.dart';

class cardBody extends StatefulWidget {
  @override
  State<cardBody> createState() => _cardBody();
}

class _cardBody extends State<cardBody> {
  _cardBody({
    Key? key,
  });
  Widget qr = QrImage(
    data: 'https://gammatx.app',
    foregroundColor: kTheme,
  );
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(height: size.height / 80),
        Row(
          children: [
            Container(
              width: size.width / 9,
            ),
            const Text(
              'gamma card',
              style: TextStyle(
                  color: kWhite,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
            ),
            const Spacer(),
            Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Container(
                  width: size.width / 3,
                  child: Image.asset('assets/images/applewallet.png'),
                )),

            Container(
              width: size.width / 9,
            ),
            // GestureDetector(
            //     onTap: () {},
            //     child: Container(
            //         height: 30,
            //         width: 100,
            //         child: Image.asset(
            //           'assets/images/applewallet.png',
            //           fit: BoxFit.fill,
            //         )))
          ],
        ),
        Center(child: Image.asset('assets/images/gammacard.png')),
        //Container(height: 10),
        Container(
          height: size.height / 55,
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(next(pickerBody()));
          },
          child: Container(
            height: size.height / 20,
            width: size.width / 1.25,
            // decoration: BoxDecoration(
            //     border: Border.all(color: kGrey),
            //     borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/scan.svg',
                  color: kGrey,
                  height: 25,
                  width: 25,
                ),
                Container(width: size.width / 25),
                const Text(
                  'scan code',
                  style: TextStyle(
                      color: kGrey, fontFamily: 'Roboto', fontSize: 24),
                )
              ],
            ),
          ),
        ),
        Container(
          height: size.height / 55,
        ),
        Container(
          height: size.width - 90,
          width: size.width - 90,
          decoration: BoxDecoration(
              gradient: const LinearGradient(
                  colors: [kTheme, Color(0xFF8800ff), Color(0xFF7100ff)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight),
              borderRadius: BorderRadius.circular(20)),
          child: Center(
            child: Container(
              height: size.width - 97,
              width: size.width - 97,
              //color: kBackground,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18), color: kBackground),
              child: Center(
                  child: Container(
                      height: size.width - 120,
                      width: size.width - 120,
                      child: qr)),
            ),
          ),
        ),
        Container(height: size.height / 40),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: size.width / 2.9,
                child: const Text(
                  'wrap your willy',
                  style: TextStyle(
                      color: kGrey, fontFamily: 'Roboto', fontSize: 20),
                ),
              ),
              Container(
                width: size.width / 30,
              ),
              Container(
                width: size.width / 10,
                child: Image.asset('assets/images/logo.png'),
              )
            ]),

        //SizedBox(height: size.width - 80, width: size.width - 80, child: qr)
      ],
    ));
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
