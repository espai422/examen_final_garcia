import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';

/// A button that recives two functions as arguments, first one to handle
/// a success scan and the second one a function tot handle a user cancel
/// when scanning.
///
/// When the user clicks this button the camera is opened and starts the QR scan
/// process
class ScanButton extends StatelessWidget {
  final void Function(String result) onScan;
  final void Function() onCancel;

  const ScanButton({Key? key, required this.onScan, required this.onCancel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      child: const Icon(
        Icons.filter_center_focus,
      ),
      onPressed: () async {
        String barcodeScanRes = await _scan();

        // Avoiding the error when the user cancels the scan
        if (barcodeScanRes == '-1') {
          onCancel();
        } else {
          onScan(barcodeScanRes);
        }
      },
    );
  }

  /// Starts the scan and returns the result as a String
  Future<String> _scan() async {
    return await FlutterBarcodeScanner.scanBarcode(
        '#3D8BEF', 'Cancelar', false, ScanMode.QR);
  }
}
