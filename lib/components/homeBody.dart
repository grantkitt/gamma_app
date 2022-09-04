import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gamma_v1/constants.dart';
import 'package:gamma_v1/screens/event_screen.dart';
import 'package:gamma_v1/structs.dart';
import 'package:gamma_v1/testCases.dart';

class homeBody extends StatefulWidget {
  @override
  State<homeBody> createState() => _homeBody();
}

class _homeBody extends State<homeBody> {
  _homeBody({
    Key? key,
  });
  void changeColor(int which) {
    if (which == 0) {
      setState(() {
        type[0] = kWhite;
        type[1] = kInactive;
      });
    } else {
      setState(() {
        type[1] = kWhite;
        type[0] = kInactive;
      });
    }
  }

  List<Color> type = [kWhite, kInactive];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            height: size.height / 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                  onTap: () {
                    changeColor(0);
                  },
                  child: Text(
                    'Discover',
                    style: TextStyle(
                        fontFamily: 'Roboto', fontSize: 20, color: type[0]),
                  )),
              Container(
                width: size.width / 20,
              ),
              GestureDetector(
                  onTap: () {
                    changeColor(1);
                  },
                  child: Text(
                    'Saved',
                    style: TextStyle(
                        fontFamily: 'Roboto', fontSize: 20, color: type[1]),
                  )),
            ],
          ),
          Container(
            height: size.height / 100,
          ),
          for (var i in hevents)
            GestureDetector(
                onTap: () {
                  Navigator.of(context).push(next(EventScreen(event: i)));
                },
                child: showEvent(
                  event: i,
                ))
        ],
      ),
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

class showEvent extends StatelessWidget {
  const showEvent({
    required this.event,
    Key? key,
  }) : super(key: key);
  final hEvent event;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(children: [
      Center(
        child: Container(
            height: ((size.width - 20) * 0.337) + ((size.width - 20) * .208),
            width: (size.width - 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 6,
                  offset: Offset(7, 7), // changes position of shadow
                ),
              ],
            )),
      ),
      Column(
        children: [
          ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16), topRight: Radius.circular(16)),
              child: Container(
                height: (size.width - 20) * 0.337,
                width: size.width - 20,
                child: Image.asset(
                  event.image,
                  fit: BoxFit.fill,
                ),
              )),
          ClipRRect(
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16)),
            child: Container(
              width: size.width - 20,
              height: (size.width - 20) * .208,
              color: kBlack,
              child: Column(children: [
                Container(height: size.height / 100),
                Row(
                  children: [
                    Container(
                      width: size.width / 25,
                    ),
                    Container(
                      width: size.width / 1.75,
                      child: Text(
                        event.name,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: kWhite,
                            fontFamily: 'Roboto',
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: Row(children: [
                        const Spacer(),
                        SvgPicture.asset(
                          'assets/icons/rightarrow.svg',
                          height: 20,
                          width: 20,
                          color: kWhite,
                        ),
                        Container(
                          width: size.width / 20,
                        ),
                        Text(
                          months[event.date.month - 1] + ' ${event.date.day}',
                          style: const TextStyle(
                            color: kLightGrey,
                            fontFamily: 'Roboto',
                            fontSize: 18,
                          ),
                        ),
                        Container(
                          width: size.width / 25,
                        ),
                      ]),
                    )
                  ],
                ),
                Container(height: size.height / 270),
                Row(
                  children: [
                    Container(
                      width: size.width / 25,
                    ),
                    Text(
                      event.orgName,
                      style: const TextStyle(
                        color: kWhite,
                        fontFamily: 'Roboto',
                        fontSize: 18,
                      ),
                    ),
                    Container(
                      width: size.width / 70,
                    ),
                    SvgPicture.asset(
                      'assets/icons/verified2.svg',
                      height: 14,
                      width: 14,
                      color: kTheme,
                    )
                  ],
                ),
              ]),
            ),
          ),
          Container(
            height: size.height / 20,
          )
        ],
      )
    ]);
  }
}
