import 'package:flutter/material.dart';
import 'package:gamma_v1/components/homeBody.dart';
import 'package:gamma_v1/constants.dart';
import 'package:gamma_v1/navBar.dart';
import 'package:metaballs/metaballs.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar:
            PreferredSize(preferredSize: Size.fromHeight(60), child: navBar()),
        body: Stack(children: [
          // Metaballs(
          //   color: const Color.fromARGB(255, 66, 133, 244),
          //   effect: MetaballsEffect.follow(
          //     growthFactor: 1,
          //     smoothing: 1,
          //     radius: 0.5,
          //   ),
          //   gradient: const LinearGradient(
          //       colors: [Color(0xFF6714f7), Color(0xFFd618bd)],
          //       begin: Alignment.centerLeft,
          //       end: Alignment.centerRight),
          //   metaballs: 40,
          //   animationDuration: const Duration(milliseconds: 200),
          //   speedMultiplier: 1,
          //   bounceStiffness: 3,
          //   minBallRadius: 50,
          //   maxBallRadius: 60,
          //   glowRadius: 0.7,
          //   glowIntensity: 0.6,
          // ),
          homeBody()
        ]),
        backgroundColor: kBackground);
  }
}
