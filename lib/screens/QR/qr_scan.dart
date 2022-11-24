import 'package:flutter/material.dart';
import 'package:SiBuy/scanned/scan_details.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:io';

class QR_scan extends StatefulWidget {
  const QR_scan({Key? key, required this.title, required this.token})
      : super(key: key);
  final String token;
  final String title;

  @override
  State<QR_scan> createState() => _QR_scan();
}

class _QR_scan extends State<QR_scan> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        BuildQRview(context),
        Positioned(
          height: 100,
          left: 200,
          bottom: 20,
          child: IconButton(
              iconSize: 50,
              color: Colors.white,
              icon: const Icon(Icons.flash_on),
              onPressed: () async {
                await controller!.toggleFlash();
                setState(() {
                  controller!.getFlashStatus().then((value) => print(value));
                });
              }),
        ),
      ],
    )
        // Column(
        //   children: <Widget>[
        //     Expanded(
        //       flex: 5,
        //       child: QRView(
        //         key: qrKey,
        //         overlay: QrScannerOverlayShape(
        //           borderColor: Colors.red,
        //           borderRadius: 10,
        //           borderLength: 30,
        //           borderWidth: 10,
        //           cutOutSize: 400,
        //         ),
        //         onQRViewCreated: _onQRViewCreated,
        //       ),
        //     ),
        // IconButton(
        //     icon: Icon(Icons.flash_on, color: Colors.black),
        //     onPressed: () async {
        //       await controller!.toggleFlash();
        //       setState(() {
        //         controller!.getFlashStatus().then((value) => print(value));
        //       });
        //     }),
        //   ],
        // ),
        );
  }

  Widget BuildQRview(BuildContext context) {
    return QRView(
      key: qrKey,
      overlay: QrScannerOverlayShape(
        borderColor: Colors.red,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: 400,
      ),
      onQRViewCreated: _onQRViewCreated,
    );
  }

  // void _onQRViewCreated(QRViewController controller) {
  //   this.controller = controller;
  //   controller.scannedDataStream.listen((scanData) {
  //     setState(() {
  //       result = scanData;
  //     });
  //   });
  // }
  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    // final expectedCodes = recognisedCodes.map((e) => e.type);

    controller.scannedDataStream.listen((scanData) {
      controller.pauseCamera();
      // if (expectedCodes.any((element) => scanData.code == element)) {
      result = scanData;
      if (result!.format == BarcodeFormat.qrcode) {
        try {
          // QrModel qrModel = QrModel.fromJson(jsonDecode(result!.code ?? ''));
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Scanned_details(
                token: widget.token,
                scannedData: scanData,
              ),
            ),
          );
        } on FormatException {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('invalid qr code')));
        } on Exception {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('error')));
        }
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
