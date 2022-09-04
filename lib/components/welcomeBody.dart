import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gamma_v1/constants.dart';
import 'package:gamma_v1/screens/register_screen.dart';

class welcomeBody extends StatefulWidget {
  @override
  State<welcomeBody> createState() => _welcomeBody();
}

class _welcomeBody extends State<welcomeBody> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(height: 220),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LinearGradientMask(
                child: SvgPicture.asset(
                  'assets/icons/logo.svg',
                  height: 100,
                  width: 100,
                ),
              ),
              Container(
                width: 20,
              ),
              const Text(
                'gamma',
                style: TextStyle(
                    color: Colors.white, fontFamily: 'Alata', fontSize: 40),
              )
            ],
          ),
          const Spacer(),
          authButton(
              name: 'continue',
              path: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterScreen()),
                );
              }),
          Container(height: 10),
          Container(height: 40)
        ],
      ),
    );
  }
}

class LinearGradientMask extends StatelessWidget {
  LinearGradientMask({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return const RadialGradient(
          center: Alignment.topLeft,
          radius: 1,
          colors: [Color(0xFFD57CFF), Color(0xFF9B5AEE), Color(0xFF9934E9)],
          tileMode: TileMode.mirror,
        ).createShader(bounds);
      },
      child: child,
    );
  }
}

class authButton extends StatelessWidget {
  const authButton({
    Key? key,
    required this.name,
    required this.path,
  }) : super(key: key);
  final String name;
  final VoidCallback path;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
        onTap: path,
        child: Material(
          borderRadius: BorderRadius.circular(25),
          elevation: 10,
          child: Container(
            width: 300,
            height: 50,
            //color: Colors.white,
            decoration: ShapeDecoration(
                color: kWhite,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                  //side: const BorderSide(width: 3, color: Colors.white)
                )),
            child: Center(
              child: Text(name,
                  style: const TextStyle(
                      fontSize: 32, color: kTheme, fontFamily: 'Roboto')),
            ),
          ),
        ));
  }
}
// ==================================================== original render, hopefully deprecated
// SvgPicture.asset(
          //   'assets/icons/logo.svg',
          //   height: 400,
          //   width: 400,
          //   color: kTheme.withOpacity(0.3),
          // ),

          // const Text(
          //   "Gamma",
          //   style: TextStyle(
          //       fontFamily: 'Alata', fontSize: 70, color: Colors.white),
          // ),
          // Container(
          //   decoration: const BoxDecoration(
          //     gradient: LinearGradient(
          //       tileMode: TileMode.mirror,
          //       begin: Alignment.topLeft,
          //       end: Alignment.bottomRight,
          //       colors: [
          //         Color(0xff755fe9),
          //         Color(0xffd11e9f),
          //       ],
          //       stops: [
          //         0,
          //         1,
          //       ],
          //     ),
          //     backgroundBlendMode: BlendMode.srcOver,
          //   ),
          //   child: PlasmaRenderer(
          //     type: PlasmaType.infinity,
          //     particles: 5,
          //     color: Color(0x44a623e4),
          //     blur: 0.4,
          //     size: 1.14,
          //     speed: 5.07,
          //     offset: 0,
          //     blendMode: BlendMode.plus,
          //     //PlasmaType: ParticleType.atlas,
          //     variation1: 0,
          //     variation2: 0,
          //     variation3: 0,
          //     rotation: -3.14,
          //     child: SvgPicture.asset(
          //       'assets/icons/logo.svg',
          //     ),
          //   ),
          // ),