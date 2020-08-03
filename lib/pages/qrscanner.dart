import 'package:flutter_qr_bar_scanner/qr_bar_scanner_camera.dart';
import 'package:qrscan/qrscan.dart';
import 'package:flutter/material.dart';
class qrscanner extends StatefulWidget {
  @override
  _qrscannerState createState() => _qrscannerState();
}

class _qrscannerState extends State<qrscanner> {
  String qrcode = "Scan a QR/Bar code";
  bool back=false;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
          elevation: 2.0,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Container(
            padding: const EdgeInsets.all(10.0),
            width: 300,
            height: 500,
            child: Column(
              children: <Widget>[
                Container(
                  height: 300,
                  width: 280,
                  margin: const EdgeInsets.only(bottom: 10),
                  child: QRBarScannerCamera(
                    onError: (context, error) => Text(
                      error.toString(),
                      style: TextStyle(color: Colors.red),
                    ),
                    qrCodeCallback: (code) {
                      _qrCallback(code);
                    },
                  ),
                ),
                Text(
                  qrcode,
                  style: TextStyle(color: Colors.black26),
                ),
                Center(
                  child: RaisedButton(
                    onPressed: () {
                      if(back) {
                        Navigator.pop(context, qrcode);
                      }
                    },
                    child: Text('SCAN',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
  _qrCallback(String code) {
    setState(() {
      qrcode = code;
      back=true;
    });
  }
}