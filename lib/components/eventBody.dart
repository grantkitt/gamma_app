import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gamma_v1/constants.dart';
import 'package:gamma_v1/structs.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

class eventBody extends StatefulWidget {
  eventBody({Key? key, required this.event});
  final hEvent event;
  @override
  State<eventBody> createState() => _eventBody(event: event);
}

class _eventBody extends State<eventBody> {
  _eventBody({Key? key, required this.event});
  final hEvent event;
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
        child: Column(
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              width: size.width - 20,
              height: (size.width - 20) * .325,
              child: Image.asset(
                event.image,
                fit: BoxFit.fill,
              ),
            )),
        Container(height: size.height / 80),
        Row(
          children: [
            Container(
              width: size.width / 20,
            ),
            Text(
              event.name,
              style: const TextStyle(
                  color: kWhite,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                  fontSize: 28),
            ),
          ],
        ),
        Container(
          height: size.height / 100,
        ),
        Row(
          children: [
            Container(
              width: size.width / 20,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                height: 40,
                width: 40,
                child: Image.asset(
                  event.orgImage,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Container(
              width: size.width / 40,
            ),
            Text(
              event.orgName,
              style: const TextStyle(
                  color: kWhite,
                  fontFamily: 'Roboto',
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Container(
              width: size.width / 40,
            ),
            SvgPicture.asset(
              'assets/icons/verified2.svg',
              height: 20,
              width: 20,
              color: kTheme,
            )
          ],
        ),
        Container(height: size.height / 60),
        Row(children: [
          Container(
            width: size.width / 20,
          ),
          SvgPicture.asset(
            'assets/icons/calendar2.svg',
            color: kGrey,
            height: 20,
            width: 20,
          ),
          Container(
            width: size.width / 40,
          ),
          Text(
            months[event.date.month - 1] +
                ' ${event.date.day} | ' +
                DateFormat("h:mm a").format(event.date),
            style: const TextStyle(
                fontFamily: 'Roboto', fontSize: 20, color: kGrey),
          ),
        ]),
        Container(height: size.height / 70),
        Row(children: [
          Container(
            width: size.width / 20,
          ),
          SvgPicture.asset(
            'assets/icons/location.svg',
            color: kTheme,
            height: 20,
            width: 20,
          ),
          Container(
            width: size.width / 40,
          ),
          Text(
            event.location,
            style: const TextStyle(
              color: kTheme,
              fontSize: 20,
              fontFamily: 'Roboto',
            ),
          )
        ]),
        Container(height: size.height / 70),
        Row(children: [
          Container(
            width: size.width / 20,
          ),
          const Text(
            'Description',
            style: TextStyle(
                color: kWhite,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold,
                fontSize: 24),
          ),
        ]),
        Container(height: size.height / 90),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
              width: size.width - 30,
              height: size.height / 2.5,
              color: kBlack,
              child: Center(
                child: Container(
                  height: size.height / 2.65,
                  width: size.width - 60,
                  child: Text(
                    event.desc,
                    style: const TextStyle(
                        color: kGrey, fontFamily: 'Roboto', fontSize: 18),
                  ),
                ),
              )),
        ),
        Container(height: size.height / 50),
        Row(
          children: [
            Container(width: size.width / 20),
            GestureDetector(
              onTap: () {
                showInvite(context);
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Container(
                  height: 50,
                  width: 50,
                  color: kTheme,
                  child: Center(
                      child: SvgPicture.asset('assets/icons/share.svg',
                          color: kWhite, height: 25, width: 25)),
                ),
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {},
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Container(
                    height: 50,
                    color: kTheme,
                    width: size.width / 1.4,
                    child: const Center(
                        child: Text(
                      'RSVP',
                      style: TextStyle(
                          color: kWhite,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold,
                          fontSize: 22),
                    )),
                  )),
            ),
            Container(width: size.width / 20),
          ],
        )
      ],
    ));
  }

  void showInvite(context) {
    Size size = MediaQuery.of(context).size;
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30),
          ),
        ),
        builder: (context) {
          return SizedBox(
              height: 230,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(height: 20),
                    Container(
                      height: 50,
                      width: size.width - 50,
                      decoration: BoxDecoration(
                          color: kGrey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(25)),
                      child: Center(
                          child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 10,
                          ),
                          Container(
                            width: 230,
                            height: 30,
                            child: const Text(
                              'gammatx.invite/41241241343522523',
                              maxLines: 1,
                              softWrap: false,
                              overflow: TextOverflow.fade,
                              style:
                                  TextStyle(fontFamily: 'Roboto', fontSize: 22),
                            ),
                          ),
                          const Spacer(),
                          Container(
                            height: 50,
                            width: 90,
                            decoration: BoxDecoration(
                                color: kTheme,
                                borderRadius: BorderRadius.circular(25)),
                            child: Center(
                                child: SvgPicture.asset(
                              'assets/icons/copy.svg',
                              height: 30,
                              width: 30,
                            )),
                          ),
                        ],
                      )),
                    ),
                    Container(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Invites: ',
                          style: TextStyle(
                              color: kGrey, fontSize: 25, fontFamily: 'Roboto'),
                        ),
                        const Text(
                          '10',
                          style: TextStyle(
                              color: kBlack,
                              fontSize: 25,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                  ]));
        });
  }
}
