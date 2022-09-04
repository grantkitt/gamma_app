import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gamma_v1/components/cardBody.dart';
import 'package:gamma_v1/components/eventBody.dart';
import 'package:gamma_v1/constants.dart';
import 'package:gamma_v1/structs.dart';

class EventScreen extends StatelessWidget {
  EventScreen({Key? key, required this.event});
  final hEvent event;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
                // GestureDetector(
                //     onTap: () {
                //       Navigator.pop(context);
                //     },
                //     child: SvgPicture.asset(
                //       'assets/icons/qr.svg',
                //       color: kWhite,
                //       height: 30,
                //       width: 30,
                //     )),
                Container(
                  width: size.width / 15,
                ),
              ],
            )),
          )),
      body: eventBody(event: event),
      backgroundColor: kBackground,
    );
  }
}
