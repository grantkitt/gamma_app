import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gamma_v1/components/cardBody.dart';
import 'package:gamma_v1/components/registerPath.dart';
import 'package:gamma_v1/constants.dart';
import 'package:gamma_v1/countries.dart';
import 'package:gamma_v1/main.dart';
import 'package:gamma_v1/requests.dart';
import 'package:gamma_v1/screens/welcome_screen.dart';
import 'package:gamma_v1/testCases.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

class personalScreen extends StatefulWidget {
  @override
  State<personalScreen> createState() => _personalScreen();
}

class _personalScreen extends State<personalScreen> {
  var username = TextEditingController();
  var firstname = TextEditingController();
  var lastname = TextEditingController();
  var birthday = "Birthday";

  var _selectedDate = hGrant.birthday;
  final ImagePicker _picker = ImagePicker();
  late XFile image;
  void initState() {
    super.initState();
    setState(() {
      username.text = hGrant.username;
      firstname.text = hGrant.fname;
      lastname.text = hGrant.lname;
    });
  }

  void setImg(int type) async {
    var mg;

    if (type == 0) {
      mg = (await _picker.pickImage(source: ImageSource.gallery))!;
    } else {
      mg = (await _picker.pickImage(source: ImageSource.camera))!;
    }
    setState(() {
      image = mg;
    });
  }

  void pickImge(context) {
    Size size = MediaQuery.of(context).size;
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Container(
              height: 180,
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      color: kLightGrey,
                      height: 100,
                      width: size.width - 30,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                setImg(0);
                              },
                              child: const Text(
                                'Choose image from library',
                                style: TextStyle(
                                    color: kBlack,
                                    fontFamily: 'Alata',
                                    fontSize: 20),
                              ),
                            ),
                            const Spacer(),
                            Container(
                              height: 1,
                              width: size.width - 40,
                              color: kBlack,
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () async {
                                setImg(1);
                              },
                              child: const Text(
                                'Choose image from camera',
                                style: TextStyle(
                                    color: kBlack,
                                    fontFamily: 'Alata',
                                    fontSize: 20),
                              ),
                            ),
                            const Spacer()
                          ]),
                    ),
                  ),
                  Container(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Container(
                      height: 50,
                      width: size.width - 30,
                      color: kLightGrey,
                      child: Center(
                          child: GestureDetector(
                        onTap: () {
                          getAccess();
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                              color: kBlack, fontFamily: 'Alata', fontSize: 20),
                        ),
                      )),
                    ),
                  )
                ],
              ));
        });
  }

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
              ],
            )),
          )),
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Padding(
          padding: EdgeInsets.only(right: size.width / 1.75),
          child: const Text(
            'Security',
            style: TextStyle(
                color: kWhite,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold,
                fontSize: 25),
          ),
        ),
        Container(height: size.height / 20),
        GestureDetector(
          onTap: () {
            pickImge(context);
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(75),
            child: Container(
              height: 150,
              width: 150,
              child: Stack(children: [
                Center(child: Image.asset(hGrant.image)),
                Center(
                  child: SvgPicture.asset(
                    'assets/icons/edit.svg',
                    color: kWhite,
                    height: 40,
                    width: 40,
                  ),
                )
              ]),
            ),
          ),
        ),
        Container(
          height: size.height / 20,
        ),
        stextField(controller: username, type: 'Username', obs: false),
        Container(
          height: size.height / 30,
        ),
        stextField(controller: firstname, type: 'First name', obs: false),
        Container(
          height: size.height / 30,
        ),
        stextField(controller: lastname, type: 'Last name', obs: false),
        Container(
          height: size.height / 30,
        ),
        GestureDetector(
          onTap: () {
            _pickDateDialog();
          },
          child: Container(
            height: size.height / 14,
            width: size.width / 1.18,
            decoration: BoxDecoration(
                color: boxColor,
                border: Border.all(color: strokeColor, width: 2),
                borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                Container(
                  width: 13,
                ),
                SvgPicture.asset(
                  'assets/icons/calendar2.svg',
                  height: 25,
                  width: 25,
                  color: textColor,
                ),
                Container(
                  width: size.width / 30,
                ),
                Text(
                  Jiffy(_selectedDate).yMMMMd,
                  style: const TextStyle(
                      color: kWhite, fontSize: 20, fontFamily: 'Roboto'),
                ),
              ],
            ),
          ),
        ),
        Container(height: 2),
        Text(
          'Note: You can only change your birthday once',
          style:
              TextStyle(color: textColor, fontSize: 12, fontFamily: 'Roboto'),
        ),
        const Spacer(),
        GestureDetector(
            onTap: () {
              hGrant.username = username.text;
              hGrant.fname = firstname.text;
              hGrant.lname = lastname.text;
              Navigator.pop(context);
            },
            child: Container(
              height: 50,
              width: size.width - 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25), color: kTheme),
              child: const Center(
                  child: Text(
                'Save',
                style: TextStyle(
                    color: kWhite,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                    fontSize: 25),
              )),
            )),
        Container(height: size.height / 40),
      ]),
      backgroundColor: kBackground,
    );
  }

  void _pickDateDialog() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1950),
            builder: (context, child) {
              return Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: const ColorScheme.dark(
                    primary: kTheme,
                    onPrimary: kWhite,
                    onSurface: kTheme,
                    secondary: kBackground,
                  ),
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      primary: kWhite,
                    ),
                  ),
                ),
                child: child!,
              );
            },
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }
}

class securityScreen extends StatefulWidget {
  @override
  State<securityScreen> createState() => _securityScreen();
}

class _securityScreen extends State<securityScreen> {
  var email = TextEditingController();
  var phone = TextEditingController();
  var pass = TextEditingController();
  var passconf = TextEditingController();
  bool eye = true;
  String eyecon = 'assets/icons/eyeoff.svg';
  bool eye2 = true;
  String eyecon2 = 'assets/icons/eyeoff.svg';
  var selectedFlag = 'assets/icons/countries/us.svg';
  var selectedCode = 1;
  void initState() {
    super.initState();
    setState(() {
      email.text = hGrant.email;
      phone.text = hGrant.phone;
    });
  }

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
              ],
            )),
          )),
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Padding(
          padding: EdgeInsets.only(right: size.width / 1.75),
          child: const Text(
            'Security',
            style: TextStyle(
                color: kWhite,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold,
                fontSize: 25),
          ),
        ),
        Container(
          height: size.height / 20,
        ),
        stextField(controller: email, type: 'Email', obs: false),
        Container(
          height: size.height / 30,
        ),
        Container(
          //phone container
          height: size.height / 14,
          width: size.width / 1.18,
          decoration: BoxDecoration(
              color: boxColor,
              border: Border.all(color: strokeColor, width: 2),
              borderRadius: BorderRadius.circular(12)),
          child: Row(children: [
            Container(
              width: size.width / 20,
            ),
            GestureDetector(
              onTap: changeCountry,
              child: SvgPicture.asset(
                selectedFlag,
                height: 27,
                width: 36,
              ),
            ),
            Container(width: size.width / 20),
            Container(
              height: 30,
              width: 2,
              color: strokeColor,
            ),
            Container(
              width: 13,
            ),
            Container(
              width: 200,
              child: TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  controller: phone,
                  style: const TextStyle(
                    color: kWhite,
                    fontSize: 20,
                    fontFamily: 'Roboto',
                  ),
                  decoration: InputDecoration(
                    hintText: 'Phone number',
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                        fontSize: 16, fontFamily: 'Roboto', color: textColor),
                  )),
            )
          ]),
        ),
        Container(
          height: size.height / 30,
        ),
        Stack(
          children: [
            stextField(
              controller: pass,
              type: 'Previous Password',
              obs: eye,
            ),
            Center(
              child: Padding(
                  padding: EdgeInsets.only(
                      left: size.width - 120, top: size.height / 45),
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
        Container(
          height: size.height / 30,
        ),
        Stack(
          children: [
            stextField(
              controller: passconf,
              type: 'New Password',
              obs: eye2,
            ),
            Center(
              child: Padding(
                  padding: EdgeInsets.only(
                      left: size.width - 120, top: size.height / 45),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (eye2) {
                          eye2 = false;
                          eyecon2 = 'assets/icons/eye.svg';
                        } else {
                          eye2 = true;
                          eyecon2 = 'assets/icons/eyeoff.svg';
                        }
                      });
                    },
                    child: SvgPicture.asset(
                      eyecon2,
                      height: 22,
                      width: 22,
                      color: textColor,
                    ),
                  )),
            )
          ],
        ),

        // Text(
        //   'Note: You can only change your birthday once',
        //   style:
        //       TextStyle(color: textColor, fontSize: 12, fontFamily: 'Roboto'),
        // ),
        const Spacer(),
        GestureDetector(
          onTap: () {
            hGrant.email = email.text;
            hGrant.phone = phone.text;
            Navigator.pop(context);
          },
          child: Container(
            height: 50,
            width: size.width - 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25), color: kTheme),
            child: const Center(
                child: Text(
              'Save',
              style: TextStyle(
                  color: kWhite,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                  fontSize: 25),
            )),
          ),
        ),

        Container(height: size.height / 40),
      ]),
      backgroundColor: kBackground,
    );
  }

  void changeCountry() {
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
                      width: 200,
                      color: kBlack.withOpacity(0.9),
                      child: SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: getCodes()),
                      ))));
        });
  }

  List<Widget> getCodes() {
    List<Widget> stuff = [];
    countries.forEach((key, value) {
      stuff.add(Container(
          height: 30,
          child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedFlag =
                      'assets/icons/countries/${key.toLowerCase()}.svg';
                });
              },
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                  width: 20,
                ),
                SvgPicture.asset(
                    'assets/icons/countries/${key.toLowerCase()}.svg',
                    height: 24,
                    width: 32),
                const Spacer(),
                Text(
                  '+${codes[key]} ',
                  style: const TextStyle(
                      color: kWhite, fontFamily: 'Roboto', fontSize: 16),
                ),
                const Spacer(),
                Container(
                  width: 130,
                  child: Text(
                    '${value}',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: kWhite, fontFamily: 'Roboto', fontSize: 22),
                  ),
                ),
                Container(
                  width: 20,
                ),
              ]))));
    });

    return stuff;
  }
}

class stextField extends StatelessWidget {
  stextField({
    Key? key,
    required this.controller,
    required this.type,
    required this.obs,
  }) : super(key: key);
  TextEditingController controller;
  final bool obs;
  final String type;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      child: Container(
          height: 60,
          width: size.width / 1.18,
          decoration: BoxDecoration(
              color: boxColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: strokeColor, width: 2)),
          child: Center(
              child: Padding(
            padding: EdgeInsets.only(bottom: 10, left: 13),
            child: TextField(
                keyboardType: (type == 'Phone')
                    ? TextInputType.number
                    : TextInputType.name,
                inputFormatters: (type == 'Phone')
                    ? [FilteringTextInputFormatter.digitsOnly]
                    : [],
                controller: controller,
                obscureText: obs,
                style: const TextStyle(
                  color: kWhite,
                  fontSize: 20,
                  fontFamily: 'Roboto',
                ),
                decoration: InputDecoration(
                  hintText: type,
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                      fontSize: 16, fontFamily: 'Roboto', color: textColor),
                )),
          ))),
    );
  }
}
