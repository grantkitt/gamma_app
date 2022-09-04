import 'package:flutter/material.dart';
import 'package:gamma_v1/components/welcomeBody.dart';
import 'package:gamma_v1/constants.dart';
import 'package:metaballs/metaballs.dart';
import 'dart:math';
//import 'dart:ui';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      body: Stack(children: [
        Metaballs(
          color: const Color.fromARGB(255, 66, 133, 244),
          effect: MetaballsEffect.follow(
            growthFactor: 1,
            smoothing: 1,
            radius: 0.5,
          ),
          gradient: const LinearGradient(
              colors: [Color(0xFF6714f7), Color(0xFFd618bd)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight),
          metaballs: 20,
          animationDuration: const Duration(milliseconds: 200),
          speedMultiplier: 3,
          bounceStiffness: 3,
          minBallRadius: 50,
          maxBallRadius: 80,
          glowRadius: 0.7,
          glowIntensity: 0.6,
        ),
        welcomeBody()
      ]), // bottomNavigationBar: MyBottomNavBar(),
    );
  }
}

//================================= original render, hopefully deprecated

// Container(
        //   decoration: const BoxDecoration(
        //     gradient: LinearGradient(
        //       tileMode: TileMode.mirror,
        //       begin: Alignment.topLeft,
        //       end: Alignment.bottomRight,
        //       colors: [
        //         // Color(0xff755fe9),
        //         // Color(0xffd11e9f),
        //         Colors.black,
        //         Colors.black,
        //       ],
        //       stops: [
        //         0,
        //         1,
        //       ],
        //     ),
        //     backgroundBlendMode: BlendMode.srcOver,
        //   ),
        //   child: const PlasmaRenderer(
        //     type: PlasmaType.infinity,
        //     particles: 5,
        //     color: Color(0x44a623e4),
        //     blur: 0,
        //     size: 1.14,
        //     speed: 5.07,
        //     offset: 0,
        //     blendMode: BlendMode.plus,
        //     //PlasmaType: ParticleType.atlas,
        //     variation1: 0,
        //     variation2: 0,
        //     variation3: 0,
        //     rotation: -3.14,
        //   ),
        // ),
        //Container(color: Colors.red, height: 20,),
        //Image.asset('assets/images/background.gif'),
