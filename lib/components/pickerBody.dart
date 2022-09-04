import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
//import 'package:gamma/screens/qr_scan.dart';
//import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:animated_widgets/animated_widgets.dart';
import 'package:gamma_v1/constants.dart';
import 'package:gamma_v1/structs.dart';
import 'package:gamma_v1/testCases.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class pickerBody extends StatefulWidget {
  @override
  State<pickerBody> createState() => _pickerBody();
}

class _pickerBody extends State<pickerBody> {
  _pickerBody({
    Key? key,
  });
  var dact = kTheme.withOpacity(0.3);
  var selected = null;
  late hOrg porg;
  var enabled = true;
  MobileScannerController cameraController = MobileScannerController();
  // Barcode? result;
  // QRViewController? controlla;
  // final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  // String barcode = "";

  // void _onQRViewCreated(QRViewController controlla) {
  //   setState(() => this.controlla = controlla);
  //   controlla.scannedDataStream.listen((scanData) {
  //     setState(() => result = scanData);
  //   });
  // }

  // void readQr() async {
  //   if (result != null) {
  //     controlla!.pauseCamera();
  //     print(result!.code);
  //     controlla!.dispose();
  //   }
  // }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    //readQr();
    Size size = MediaQuery.of(context).size;
    return Stack(children: [
      // Container(
      //   //color: Colors.black.withOpacity(0.7),
      //   child: QRView(
      //       key: qrKey,
      //       onQRViewCreated: _onQRViewCreated,
      //       overlay: (!enabled)
      //           ? QrScannerOverlayShape(
      //               borderColor: purp,
      //               overlayColor: Colors.black.withOpacity(0.5),
      //               borderRadius: 20,
      //               borderLength: 50,
      //               borderWidth: 10,
      //               cutOutSize: 275,
      //             )
      //           : QrScannerOverlayShape(
      //               cutOutSize: 100, borderColor: Colors.transparent)),
      // ),
      MobileScanner(
          allowDuplicates: false,
          controller: cameraController,
          onDetect: (barcode, args) {
            if (barcode.rawValue == null) {
              debugPrint('Failed to scan Barcode');
            } else {
              final String code = barcode.rawValue!;
              debugPrint('Barcode found! $code');
            }
          }),
      if (enabled)
        Container(
          width: size.width,
          height: size.height,
          color: Colors.black.withOpacity(0.5),
        ),
      if (!enabled)
        Center(
          child: Container(
            height: 270,
            width: 270,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(width: 5, color: kTheme.withOpacity(0.5))),
          ),
        ),
      Scaffold(
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: Container(
                  color: Colors.transparent,
                  //height: 80,
                  width: size.width,
                  //color: darkGrey.withOpacity(0.5),
                  child: Column(children: [
                    const Spacer(),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: 40,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: SvgPicture.asset(
                              'assets/icons/backarrow.svg',
                              color: kTheme,
                              height: 30,
                              width: 30,
                            ),
                          ),
                          const Spacer(),
                          const DefaultTextStyle(
                            style: TextStyle(
                                fontFamily: 'Alata',
                                color: kTheme,
                                fontSize: 30),
                            child: Text(
                              'Gamma',
                            ),
                          ),
                          const Spacer(),
                          Container(width: 70),
                        ]),
                    Container(
                      height: 10,
                    )
                  ]))),
          backgroundColor: Colors.transparent,
          bottomNavigationBar: Container(
            height: 70,
            child: TranslationAnimatedWidget.tween(
              enabled: enabled,
              translationDisabled: Offset(0, 200),
              translationEnabled: Offset(0, 0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: () {
                          if (selected != null) {
                            //scanQR();
                            setState(() {
                              enabled = false;
                            });
                          }
                        },
                        child: Material(
                          borderRadius: BorderRadius.circular(20),
                          //elevation: ele,
                          color: dact,
                          child: Container(
                            height: 50,
                            width: 320,
                            child: const Center(
                              child: Text(
                                "Scan Code",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Alata',
                                    fontSize: 20),
                              ),
                            ),
                          ),
                        )),
                    Container(height: 10),
                  ]),
            ),
          ),
          body: SingleChildScrollView(
              child: TranslationAnimatedWidget.tween(
            enabled: this.enabled,
            duration: const Duration(milliseconds: 300),
            translationDisabled: Offset(0, -500),
            translationEnabled: Offset(0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // Container(
                //   height: 10,
                // ),
                const Text(
                  'Choose An Org',
                  style: TextStyle(
                      color: kBlack, fontFamily: 'Alata', fontSize: 20),
                ),
                Container(height: 15),
                for (var i in hGrant.orgs)
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          porg = i;
                          selected = null;
                          dact = kTheme.withOpacity(0.3);
                        });
                      },
                      child: Container(
                          height: 60,
                          color: (porg == i)
                              ? Colors.blueAccent.withOpacity(0.3)
                              : Colors.transparent,
                          child: Center(
                            child: listOrg(org: i),
                          ))),
                Container(height: 20),
                if (porg != null)
                  const Text(
                    'Choose an Event',
                    style: TextStyle(
                        color: kGrey, fontFamily: 'Alata', fontSize: 20),
                  ),
                if (porg != null) Container(height: 20),
                for (var i in hevents)
                  if (i.orgName == porg.name)
                    Material(
                        color: (i == selected && i.orgName == porg.name)
                            ? Colors.blueAccent.withOpacity(0.3)
                            : Colors.transparent,
                        child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selected = i;
                                dact = kTheme.withOpacity(0.8);
                              });
                            },
                            child: pevent(
                              event: i,
                            ))),
                Container(height: 100),
              ],
            ),
          ))),
      TranslationAnimatedWidget.tween(
          enabled: !enabled,
          translationDisabled: Offset(0, -200),
          translationEnabled: Offset(0, -10),
          duration: const Duration(milliseconds: 400),
          child: Column(
            children: [
              Container(height: 110),
              GestureDetector(
                  onTap: () {
                    setState(() {
                      enabled = true;
                    });
                  },
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                          height: 30,
                          width: 250,
                          color: Colors.white,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  selected.name,
                                  style: const TextStyle(
                                      color: kTheme,
                                      fontFamily: 'Alata',
                                      fontSize: 20),
                                ),
                                Container(
                                  width: 12,
                                ),
                                SvgPicture.asset(
                                  'assets/icons/down.svg',
                                  height: 25,
                                  width: 25,
                                  color: kTheme,
                                )
                              ]))))
            ],
          )),
    ]);
  }
}

class listOrg extends StatelessWidget {
  const listOrg({
    Key? key,
    required this.org,
  }) : super(key: key);
  final hOrg org;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              height: 50,
              width: 50,
              child: Image.asset(
                org.image,
                fit: BoxFit.fill,
              ),
            )),
        Container(width: 10),
        Text(
          org.name,
          style: const TextStyle(
              fontSize: 24, color: Colors.white, fontFamily: 'Alata'),
        ),
        Container(width: 5),
        SvgPicture.asset(
          'assets/icons/verified.svg',
          height: 24,
          width: 24,
          color: Colors.blue,
        )
      ],
    );
  }
}

class pevent extends StatelessWidget {
  const pevent({
    Key? key,
    required this.event,
  }) : super(key: key);

  final hEvent event;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: <Widget>[
        const SizedBox(height: 75, width: 20),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            event.image,
            width: (size.width * 0.925) / 2,
            height: (size.height * 0.162) / 2,
            fit: BoxFit.fill,
          ),
        ),
        Container(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              event.name,
              style: const TextStyle(
                  fontSize: 16, color: Colors.white, fontFamily: 'Alata'),
            ),
            Row(
              children: <Widget>[
                Text(
                  event.orgName,
                  style: const TextStyle(
                      color: Colors.white, fontSize: 16, fontFamily: 'Alata'),
                ),
                Container(width: 5),
                SvgPicture.asset(
                  'assets/icons/verified.svg',
                  color: Colors.blue,
                  height: 14,
                  width: 14,
                )
              ],
            ),
          ],
        ),
      ],
    );
  }
}
