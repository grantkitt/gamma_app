import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gamma_v1/components/welcomeBody.dart';
import 'package:gamma_v1/constants.dart';
import 'package:gamma_v1/main.dart';
import 'package:gamma_v1/requests.dart';
import 'package:gamma_v1/screens/settings_screens.dart';
import 'package:gamma_v1/screens/welcome_screen.dart';
import 'package:gamma_v1/structs.dart';
import 'package:gamma_v1/testCases.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class profileBody extends StatefulWidget {
  @override
  State<profileBody> createState() => _profileBody();
}

class _profileBody extends State<profileBody> {
  _profileBody({
    Key? key,
  });
  bool which = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
        child: Center(
      child: Column(
        children: <Widget>[
          Container(
            height: size.height / 15,
          ),
          ClipRRect(
              borderRadius: BorderRadius.circular(size.width / 6),
              child: Container(
                  height: size.width / 3,
                  width: size.width / 3,
                  child: Image.asset(hGrant.image))),
          Container(height: size.height / 25),
          Text(
            hGrant.fname + ' ' + hGrant.lname,
            style: const TextStyle(
                fontFamily: 'Roboto',
                fontSize: 32,
                color: kWhite,
                fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '@' + hGrant.username,
                style: const TextStyle(
                    color: kGrey, fontFamily: 'Roboto', fontSize: 18),
              ),
              Container(
                width: 5,
              ),
              SvgPicture.asset(
                'assets/icons/verified2.svg',
                height: 16,
                width: 16,
                color: kTheme,
              )
            ],
          ),
          Container(
            height: size.height / 25,
          ),
          GestureDetector(
            onTap: () {},
            child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Container(
                  color: kTheme,
                  width: size.width - 100,
                  height: 50,
                  child: const Center(
                      child: Text(
                    'Invite Others',
                    style: TextStyle(
                        color: kWhite,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  )),
                )),
          ),
          Container(
            height: size.height / 25,
          ),
          Container(
            height: size.height / 2.25,
            width: size.width - 30,
            decoration: BoxDecoration(
                color: boxColor,
                border: Border.all(color: strokeColor, width: 2),
                borderRadius: BorderRadius.circular(24)),
            child: Column(children: [
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(next(personalScreen()));
                },
                child: const settingsButton(
                    name: 'Personal', icon: 'assets/icons/person.svg'),
              ),
              const Spacer(),
              Container(
                width: size.width - 20,
                height: 2,
                color: strokeColor,
              ),
              const Spacer(),
              Container(
                height: 30,
                child: Center(
                    child: Row(
                  children: [
                    Container(
                      width: size.width / 24,
                    ),
                    SvgPicture.asset(
                      'assets/icons/bell.svg',
                      height: 30,
                      width: 30,
                      color: kWhite,
                    ),
                    Container(
                      width: size.width / 20,
                    ),
                    const Text(
                      'Notifications',
                      style: TextStyle(
                        color: kWhite,
                        fontFamily: 'Roboto',
                        fontSize: 22,
                      ),
                    ),
                    const Spacer(),
                    CupertinoSwitch(
                        value: which,
                        activeColor: kTheme,
                        onChanged: (bool lol) {
                          setState(() {
                            which = lol;
                          });
                        }),
                    Container(
                      width: size.width / 24,
                    ),
                  ],
                )),
              ),
              const Spacer(),
              Container(
                width: size.width - 20,
                height: 2,
                color: strokeColor,
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(next(securityScreen()));
                },
                child: const settingsButton(
                    name: 'Security', icon: 'assets/icons/security.svg'),
              ),
              const Spacer(),
              Container(
                width: size.width - 20,
                height: 2,
                color: strokeColor,
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  _launchURL();
                },
                child: const settingsButton(
                    name: 'Support', icon: 'assets/icons/chat2.svg'),
              ),
              const Spacer(),
            ]),
          ),
          Container(height: 3),
          Container(
            height: size.height / 25,
          ),
          GestureDetector(
            onTap: () {
              _logOut();
            },
            child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Container(
                  color: kTheme,
                  width: size.width - 100,
                  height: 50,
                  child: const Center(
                      child: Text(
                    'Sign Out',
                    style: TextStyle(
                        color: kWhite,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  )),
                )),
          ),
          Container(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'terms of service ',
                style: TextStyle(
                    color: kTheme, fontFamily: 'Roboto', fontSize: 16),
              ),
              Text(
                'and ',
                style: TextStyle(
                    color: kWhite, fontFamily: 'Roboto', fontSize: 16),
              ),
              Text(
                'privacy policy',
                style: TextStyle(
                    color: kTheme, fontFamily: 'Roboto', fontSize: 16),
              )
            ],
          ),
          Container(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/icons/insta.svg',
                color: kGrey,
                width: 30,
                height: 30,
              ),
              Container(
                width: size.width / 12,
              ),
              SvgPicture.asset(
                'assets/icons/twitter.svg',
                color: kGrey,
                width: 30,
                height: 30,
              )
            ],
          ),
          Container(
            height: 20,
          ),
          const Text(
            'Gamma v1.0 ',
            style: TextStyle(color: kWhite, fontFamily: 'Alata', fontSize: 16),
          ),
          const Text(
            'Made in Austin, Texas',
            style: TextStyle(color: kWhite, fontFamily: 'Alata', fontSize: 16),
          ),
          Container(height: 20),
        ],
      ),
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

  void _launchURL() async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: 'support@gammatx.app',
    );
    String url = params.toString();
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }

  void _logOut() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: EdgeInsets.all(10),
              elevation: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                    color: kLightGrey,
                    height: 150,
                    width: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(height: 10),
                        const Text(
                          'Log out of your account?',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: 'Alata'),
                        ),
                        Container(
                          height: 10,
                        ),
                        Container(
                          height: 1,
                          width: 280,
                          color: kGrey,
                        ),
                        Container(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            storage.delete(key: 'jwt');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WelcomeScreen()),
                            );
                          },
                          child: const Text(
                            'Log out',
                            style: TextStyle(
                                color: Colors.redAccent,
                                fontSize: 20,
                                fontFamily: 'Alata'),
                          ),
                        ),
                        Container(
                          height: 10,
                        ),
                        Container(
                          height: 1,
                          width: 280,
                          color: kGrey,
                        ),
                        Container(height: 10),
                        GestureDetector(
                          onTap: () async {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                                color: kBlack,
                                fontSize: 20,
                                fontFamily: 'Alata'),
                          ),
                        ),
                        Container(
                          height: 10,
                        ),
                      ],
                    )),
              ));
        });
  }
}

class settingsButton extends StatelessWidget {
  const settingsButton({Key? key, required this.name, required this.icon})
      : super(key: key);
  final String icon, name;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Center(
          child: Row(
        children: [
          Container(
            width: size.width / 24,
          ),
          SvgPicture.asset(
            icon,
            height: 30,
            width: 30,
            color: kWhite,
          ),
          Container(
            width: size.width / 20,
          ),
          Text(
            name,
            style: const TextStyle(
              color: kWhite,
              fontFamily: 'Roboto',
              fontSize: 22,
            ),
          ),
          const Spacer(),
          SvgPicture.asset(
            'assets/icons/rightarrow.svg',
            color: kWhite,
            height: 30,
            width: 30,
          ),
          Container(
            width: size.width / 24,
          ),
        ],
      )),
    );
  }
}
