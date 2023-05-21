import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:client/apis/paymentapi.dart';
import 'package:client/helpers/headers.dart';
import 'package:client/screens/home/peopletransaction.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanQrPage extends StatefulWidget {
  static const String routeName = scanqrpage;
  const ScanQrPage({Key? key}) : super(key: key);

  @override
  _ScanQrPageState createState() => _ScanQrPageState();
}

class _ScanQrPageState extends State<ScanQrPage> {
  // late QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  final PaymentAPI _paymentAPI = PaymentAPI();

  PermissionStatus _status = PermissionStatus.denied;
  bool _isStarted = false;

  @override
  void initState() {
    super.initState();
    _checkPermission();
  }

  @override
  void dispose() {
    // controller.dispose();
    super.dispose();
  }

  Future<void> _checkPermission() async {
    final status = await Permission.camera.status;
    print(status);
    setState(() {
      _status = status;
    });
    if (_status.isDenied) {
      _requestPermission();
    }
  }

  Future<void> _requestPermission() async {
    final status = await Permission.camera.request();
    setState(() {
      _status = status;
    });
  }

  _checkQrCode({required String pid}) async {
    print("------checking----");
    print(pid);
    return await _paymentAPI.postQrScan(context: context, toPid: pid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.transparent,
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.close, color: Colors.white, size: isMobile(context) ? 22 : 27,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: AiBarcodeScanner(
        borderColor: kPrimaryColor,

        validator: (value) {
          print("------validating----");
          print(value);
          if(_isStarted == false){
            setState(() {
              _isStarted = true;
            });
            return _checkQrCode(pid: value);
          }else{
            return false;
          }
          // return value.startsWith('https://');
        },
        canPop: false,
        onScan: (String value) {
          print("------scanning----");
          print(value);
          // setState(() {
          //   barcode = value;
          // });
        },
        onDetect: (p0) {
          print("------detecting----");
          print(p0);
        },
        onDispose: () {
          debugPrint("Barcode scanner disposed!");
        },
        controller: MobileScannerController(
          detectionSpeed: DetectionSpeed.noDuplicates,
        ),
      ),
    );
  }

  // void _onQRViewCreated(QRViewController controller) {
  //   this.controller = controller;
  //   controller.scannedDataStream.listen((scanData) {
  //     print(scanData.code);
  //     overlayLoader(context);
  //     _checkQrCode(pid: "${scanData.code}");
  //     //ScaffoldMessenger.of(context).showSnackBar(customsnackErrorBar(context, "${scanData.code}"));
  //     // Navigator.push(
  //     //     context,
  //     //     CustomRightPageRoute(
  //     //         page: PeopleTransactionPage(toPid:"${scanData.code}" ), routeName: peopletransactionpage));
  //   });
  // }/
}
