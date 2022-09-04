import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gamma_v1/constants.dart';
import 'package:gamma_v1/requests.dart';
import 'package:gamma_v1/countries.dart';
import '../screens/home_screen.dart';
import 'dart:io';

String phoneNumber = "(xxx) xxx-xxxx";
String FIRSTNAME = "",
    LASTNAME = "",
    EMAIL = "",
    PHONE = "",
    PASSWORD = "",
    USERNAME = "";

//textfield input screen
class textFields extends StatefulWidget {
  @override
  State<textFields> createState() => _textFields();
}

class _textFields extends State<textFields> {
  final fname = TextEditingController();
  final lname = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final password = TextEditingController();
  final username = TextEditingController();
  var badInfo = Colors.transparent;
  var errMsg = "Invalid credentials";
  var selectedFlag = 'assets/icons/countries/us.svg';
  var selectedCode = 1;
  var birthday = 'Birthday';
  var _selectedDate = DateTime.now();
  var method = [kBlack, kWhite];
  var checked = Colors.transparent;

  @override
  void initState() {
    super.initState();

    fname.addListener(setFName);
    lname.addListener(setLName);
    email.addListener(setEmail);
    phone.addListener(setPhone);
    password.addListener(setPass);
    username.addListener(setUser);
  }

  @override
  void setFName() {
    setState(() {
      FIRSTNAME = fname.text;
    });
  }

  void setLName() {
    setState(() {
      LASTNAME = lname.text;
    });
  }

  @override
  void setEmail() {
    setState(() {
      EMAIL = email.text;
    });
  }

  @override
  void setPhone() {
    setState(() {
      PHONE = phone.text;
    });
  }

  @override
  void setPass() {
    setState(() {
      PASSWORD = password.text;
    });
  }

  @override
  void setUser() {
    setState(() {
      USERNAME = username.text;
    });
  }

  @override
  bool eye = true;
  String eyecon = 'assets/icons/eyeoff.svg';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(children: [
      Container(height: 18),
      Text(
        errMsg,
        style: TextStyle(color: badInfo, fontFamily: 'Alata', fontSize: 14),
        textAlign: TextAlign.center,
      ),
      Container(height: 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          textField(
              controller: fname,
              obs: false,
              icon: 'assets/icons/user.svg',
              type: 'First name',
              input: 'first name',
              changer: 2.5),
          Container(
            width: size.width / 20,
          ),
          textField(
              controller: lname,
              obs: false,
              icon: 'assets/icons/user.svg',
              type: 'Last name',
              input: 'last name',
              changer: 2.5),
        ],
      ),
      Container(height: size.height / 35),
      textField(
          controller: username,
          obs: false,
          icon: 'assets/icons/user.svg',
          type: 'Username',
          input: 'username',
          changer: 1.18),
      Container(height: size.height / 35),
      textField(
          controller: email,
          obs: false,
          icon: 'assets/icons/email.svg',
          type: 'Email',
          input: 'email',
          changer: 1.18),

      Container(height: size.height / 35),
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
                  fontSize: 16,
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

      Container(height: size.height / 35),
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
                birthday,
                style: TextStyle(
                    color: textColor, fontSize: 16, fontFamily: 'Roboto'),
              )
            ],
          ),
        ),
      ),
      Container(
        height: size.height / 35,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
              onTap: () {
                setState(() {
                  if (checked == Colors.transparent) {
                    checked = kTheme;
                  } else {
                    checked = Colors.transparent;
                  }
                });
              },
              child: Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                    border: Border.all(color: kWhite),
                    borderRadius: BorderRadius.circular(10),
                    color: checked),
              )),
          Container(
            width: size.width / 20,
          ),
          Container(
            width: 220,
            child: const Text(
              'I agree to recieve SMS and email messages from gamma platforms LLC',
              textAlign: TextAlign.center,
              style:
                  TextStyle(color: kGrey, fontFamily: 'Roboto', fontSize: 12),
            ),
          )
        ],
      ),
      const Spacer(),
      // Column(
      //   children: getCodes(),
      // ),
      GestureDetector(
        onTap: () async {
          if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(EMAIL) ||
              FIRSTNAME == '' ||
              LASTNAME == '' ||
              USERNAME == '' ||
              PHONE.length != 10 ||
              PASSWORD == '') {
            setState(() {
              badInfo = Colors.redAccent;
            });
          } else {
            int status = await attemptSignUp(
                FIRSTNAME, LASTNAME, USERNAME, EMAIL, PHONE, PASSWORD);
            if (status == 200) {
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      HomeScreen(),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
              );
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
                "Sign Up",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Roboto',
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
      Container(height: 30),
    ]);
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

//individual textfields
class textField extends StatelessWidget {
  textField(
      {Key? key,
      required this.controller,
      required this.obs,
      required this.icon,
      required this.type,
      required this.input,
      required this.changer})
      : super(key: key);
  TextEditingController controller;
  final double changer;
  final String icon, type;
  final String input;
  final bool obs;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      child: Container(
          height: 58,
          width: size.width / changer,
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

//phone verification screen
// class phoneVerify extends StatefulWidget {
//   @override
//   State<phoneVerify> createState() => _phoneVerify();
// }

// class _phoneVerify extends State<phoneVerify> {
//   var nums = [' ', ' ', ' ', ' ', ' '];
//   var count = 0;
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: <Widget>[
//         Container(height: 100),
//         const Text(
//           "Enter verification code",
//           textAlign: TextAlign.center,
//           style: TextStyle(
//             fontFamily: 'Alata',
//             color: kBlack,
//             fontSize: 24,
//           ),
//         ),
//         Text(
//           "code sent to +1 $phoneNumber",
//           textAlign: TextAlign.center,
//           style: const TextStyle(
//             fontFamily: 'Alata',
//             color: kGrey,
//             fontSize: 16,
//           ),
//         ),
//         Container(height: 60),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             inputBox(input: nums[0]),
//             Container(width: 15),
//             inputBox(input: nums[1]),
//             Container(width: 15),
//             inputBox(input: nums[2]),
//             Container(width: 15),
//             inputBox(input: nums[3]),
//             Container(width: 15),
//             inputBox(input: nums[4])
//           ],
//         ),
//         Container(height: 60),
//         GestureDetector(
//           onTap: () {},
//           child: Column(children: <Widget>[
//             const Text(
//               'resend code',
//               style: TextStyle(
//                 fontFamily: 'Alata',
//                 fontSize: 16,
//                 color: kGrey,
//               ),
//             ),
//             Container(
//               height: 1,
//               width: 88,
//               color: kGrey,
//             ),
//           ]),
//         ),
//         Container(height: 100),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             GestureDetector(
//               onTap: () {
//                 setState(() {
//                   nums[count] = '1';
//                   if (count != 4) count++;
//                 });
//               },
//               child: const Text(
//                 '1',
//                 style: TextStyle(
//                   fontSize: 40,
//                   color: kGrey,
//                 ),
//               ),
//             ),
//             Container(width: 100),
//             GestureDetector(
//               onTap: () {
//                 setState(() {
//                   nums[count] = '2';
//                   if (count != 4) count++;
//                 });
//               },
//               child: const Text(
//                 '2',
//                 style: TextStyle(
//                   fontSize: 40,
//                   color: kGrey,
//                 ),
//               ),
//             ),
//             Container(width: 100),
//             GestureDetector(
//               onTap: () {
//                 setState(() {
//                   nums[count] = '3';
//                   if (count != 4) count++;
//                 });
//               },
//               child: const Text(
//                 '3',
//                 style: TextStyle(
//                   fontSize: 40,
//                   color: kGrey,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         Container(height: 30),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             GestureDetector(
//               onTap: () {
//                 setState(() {
//                   nums[count] = '4';
//                   if (count != 4) count++;
//                 });
//               },
//               child: const Text(
//                 '4',
//                 style: TextStyle(
//                   fontSize: 40,
//                   color: kGrey,
//                 ),
//               ),
//             ),
//             Container(width: 100),
//             GestureDetector(
//               onTap: () {
//                 setState(() {
//                   nums[count] = '5';
//                   if (count != 4) count++;
//                 });
//               },
//               child: const Text(
//                 '5',
//                 style: TextStyle(
//                   fontSize: 40,
//                   color: kGrey,
//                 ),
//               ),
//             ),
//             Container(width: 100),
//             GestureDetector(
//               onTap: () {
//                 setState(() {
//                   nums[count] = '6';
//                   if (count != 4) count++;
//                 });
//               },
//               child: const Text(
//                 '6',
//                 style: TextStyle(
//                   fontSize: 40,
//                   color: kGrey,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         Container(
//           height: 30,
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             GestureDetector(
//               onTap: () {
//                 setState(() {
//                   nums[count] = '7';
//                   if (count != 4) count++;
//                 });
//               },
//               child: const Text(
//                 '7',
//                 style: TextStyle(
//                   fontSize: 40,
//                   color: kGrey,
//                 ),
//               ),
//             ),
//             Container(width: 100),
//             GestureDetector(
//               onTap: () {
//                 setState(() {
//                   nums[count] = '8';
//                   if (count != 4) count++;
//                 });
//               },
//               child: const Text(
//                 '8',
//                 style: TextStyle(
//                   fontSize: 40,
//                   color: kGrey,
//                 ),
//               ),
//             ),
//             Container(width: 100),
//             GestureDetector(
//               onTap: () {
//                 setState(() {
//                   nums[count] = '9';
//                   if (count != 4) count++;
//                 });
//               },
//               child: const Text(
//                 '9',
//                 style: TextStyle(
//                   fontSize: 40,
//                   color: kGrey,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         Container(height: 30),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             GestureDetector(
//               onTap: () {},
//               child: const Text(
//                 ' ',
//                 style: TextStyle(
//                   fontSize: 40,
//                   color: kGrey,
//                 ),
//               ),
//             ),
//             Container(width: 100),
//             GestureDetector(
//               onTap: () {
//                 setState(() {
//                   nums[count] = '0';
//                   if (count != 4) count++;
//                 });
//               },
//               child: const Text(
//                 '  0',
//                 style: TextStyle(
//                   fontSize: 40,
//                   color: kGrey,
//                 ),
//               ),
//             ),
//             Container(width: 90),
//             GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     nums[count] = ' ';
//                     if (count != 0) count--;
//                   });
//                 },
//                 child: SvgPicture.asset(
//                   'assets/icons/delete.svg',
//                   height: 40,
//                   width: 40,
//                   color: kBlack,
//                 )),
//           ],
//         ),
//       ],
//     );
//   }
// }

// class inputBox extends StatelessWidget {
//   const inputBox({
//     Key? key,
//     required this.input,
//     //required this.val,
//   }) : super(key: key);
//   final String input;
//   //final bool val;
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(10),
//       child: Container(
//           height: 75,
//           width: 50,
//           color: kTheme.withOpacity(0.47),
//           child: Center(
//               child: Text(
//             input,
//             style: const TextStyle(
//               fontSize: 24,
//               color: Colors.black,
//             ),
//           ))),
//     );
//   }
// }

// class bioInfo extends StatefulWidget {
//   @override
//   State<bioInfo> createState() => _bioInfo();
// }

// class _bioInfo extends State<bioInfo> {
//   bool male = false;
//   bool female = false;
//   bool none = false;
//   var selected = 0;
//   String date = "";
//   DateTime currentDate = DateTime.now();
//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? pickedDate = await showDatePicker(
//         context: context,
//         initialDate: currentDate,
//         firstDate: DateTime(1900),
//         lastDate: DateTime.now());
//     if (pickedDate != null && pickedDate != currentDate) {
//       setState(() {
//         currentDate = pickedDate;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Stack(
//       alignment: Alignment.center,
//       children: <Widget>[
//         Row(children: <Widget>[
//           Container(width: 64),
//           Column(
//             children: <Widget>[
//               Container(height: 150),
//               const Text(
//                 "Birthday              ",
//                 textAlign: TextAlign.left,
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontFamily: 'Alata',
//                   color: kGrey,
//                 ),
//               ),
//               Container(
//                 height: 1,
//                 width: 150,
//                 color: kWhite,
//               ),
//               Container(height: 110),
//               const Text(
//                 "Sex                        ",
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontFamily: 'Alata',
//                   color: kGrey,
//                 ),
//               ),
//               Container(
//                 height: 1,
//                 width: 150,
//                 color: kWhite,
//               ),
//             ],
//           ),
//         ]),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             Container(height: 215),
//             GestureDetector(
//               onTap: () {
//                 _selectDate(context);
//               },
//               child: Container(
//                 width: 228,
//                 height: 50,
//                 decoration: ShapeDecoration(
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15),
//                         side: const BorderSide(width: 2, color: kTheme))),
//                 child: Row(
//                   children: <Widget>[
//                     Container(width: 15),
//                     Text(
//                       "${currentDate.month}/${currentDate.day}/${currentDate.year}",
//                       style: const TextStyle(
//                         fontSize: 20,
//                         fontFamily: 'Alata',
//                         color: kGrey,
//                       ),
//                     ),
//                     const Spacer(),
//                     SvgPicture.asset(
//                       'assets/icons/calendar.svg',
//                       color: kWhite,
//                     ),
//                     Container(width: 10)
//                   ],
//                 ),
//               ),
//             ),
//             Container(height: 70),
//             GestureDetector(
//               onTap: () {
//                 _setSelect(0);
//               },
//               child: Row(
//                 children: <Widget>[
//                   Container(
//                     width: 80,
//                   ),
//                   Container(
//                       height: 20,
//                       width: 20,
//                       decoration: BoxDecoration(
//                         borderRadius:
//                             const BorderRadius.all(Radius.circular(10.0)),
//                         border: Border.all(
//                           color: kTheme,
//                           width: 2,
//                         ),
//                       ),
//                       child: (() {
//                         if (male) {
//                           return ClipRRect(
//                               borderRadius: BorderRadius.circular(2.5),
//                               child: Container(
//                                 height: 5,
//                                 width: 5,
//                                 color: kTheme,
//                               ));
//                         }
//                       }())),
//                   Container(width: 15),
//                   const Text(
//                     "male",
//                     style: TextStyle(
//                         fontSize: 20, fontFamily: 'Alata', color: kGrey),
//                   )
//                 ],
//               ),
//             ),
//             Container(height: 10),
//             GestureDetector(
//               onTap: () {
//                 _setSelect(1);
//               },
//               child: Row(
//                 children: <Widget>[
//                   Container(
//                     width: 80,
//                   ),
//                   Container(
//                       height: 20,
//                       width: 20,
//                       decoration: BoxDecoration(
//                         borderRadius:
//                             const BorderRadius.all(Radius.circular(10.0)),
//                         border: Border.all(
//                           color: kTheme,
//                           width: 2,
//                         ),
//                       ),
//                       child: (() {
//                         if (female) {
//                           return ClipRRect(
//                               borderRadius: BorderRadius.circular(2.5),
//                               child: Container(
//                                 height: 5,
//                                 width: 5,
//                                 color: kTheme,
//                               ));
//                         }
//                       }())),
//                   Container(width: 15),
//                   const Text(
//                     "female",
//                     style: TextStyle(
//                         fontSize: 20, fontFamily: 'Alata', color: kGrey),
//                   )
//                 ],
//               ),
//             ),
//             Container(height: 5),
//             GestureDetector(
//               onTap: () {
//                 _setSelect(2);
//               },
//               child: Row(
//                 children: <Widget>[
//                   Container(
//                     width: 80,
//                   ),
//                   Container(
//                       height: 20,
//                       width: 20,
//                       decoration: BoxDecoration(
//                         borderRadius:
//                             const BorderRadius.all(Radius.circular(10.0)),
//                         border: Border.all(
//                           color: kTheme,
//                           width: 2,
//                         ),
//                       ),
//                       child: (() {
//                         if (none) {
//                           return ClipRRect(
//                               borderRadius: BorderRadius.circular(2.5),
//                               child: Container(
//                                 height: 5,
//                                 width: 5,
//                                 color: kTheme,
//                               ));
//                         }
//                       }())),
//                   Container(width: 15),
//                   const Text(
//                     "prefer not to answer",
//                     style: TextStyle(
//                         fontSize: 20, fontFamily: 'Alata', color: kGrey),
//                   )
//                 ],
//               ),
//             ),
//             Container(height: 200),
//             GestureDetector(
//               onTap: () {},
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(10),
//                 child: Container(
//                   width: 300,
//                   height: 50,
//                   color: kTheme,
//                   child: const Center(
//                     child: Text(
//                       "continue",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontFamily: 'Alata',
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ],
//     );
//   }

//   void _setSelect(int which) {
//     setState(() {
//       selected = which;
//       if (which == 0) {
//         male = true;
//         female = false;
//         none = false;
//       } else if (which == 1) {
//         male = false;
//         female = true;
//         none = false;
//       } else if (which == 2) {
//         male = false;
//         female = false;
//         none = true;
//       }
//     });
//   }
// }
