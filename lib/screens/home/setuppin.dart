import 'package:client/apis/setupapi.dart';
import 'package:client/helpers/headers.dart';

class SetupPinPage extends StatefulWidget {
  static const String routeName = setuppin;
  final bool isPinSetup;
  const SetupPinPage({Key? key, required this.isPinSetup}) : super(key: key);

  @override
  _SetupPinPageState createState() => _SetupPinPageState();
}

class _SetupPinPageState extends State<SetupPinPage> {
  final TextEditingController _newpinController = TextEditingController();
  final TextEditingController _oldpinController = TextEditingController();

  final SetupPinAPI _setupPinAPI = SetupPinAPI();
  _postSetupPin({required BuildContext context,required String newPin,required String oldPin})async {
    return await _setupPinAPI.postSetupPin(context: context, newPin: newPin, oldPin: oldPin);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonNavbar(context: context, isBack: true),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: kDefaultScreenPaddingHorizontal(context),
              vertical: kDefaultScreenPaddingVertical(context)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
               Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            rowTitleText(
                                onTap: () {},
                                context: context,
                                isCapitalFont: false,
                                text: "Change Transaction Pin",
                                isViewAll: false),
                            defaultDivider(),
                            mediumCustomSizedBox(context)
                          ],
                        ),
                  
              personalInfoDynamicTitle(
                  context: context,
                  title: widget.isPinSetup ? "Old Pin" : "New Pin",
                  controller: _oldpinController,
                  hintTextField: widget.isPinSetup ? "Enter your old pin" : "Enter your new pin",
                  textInputType: TextInputType.number),
              mediumCustomSizedBox(context),
              personalInfoDynamicTitle(
                  context: context,
                  title: widget.isPinSetup ? "New Pin" : "Confirm Pin",
                  controller: _newpinController,
                  hintTextField: widget.isPinSetup ? "Enter your new pin" : "Confirm your new pin",
                  textInputType: TextInputType.number),
              mediumCustomSizedBox(context),
              mediumCustomSizedBox(context),
              primaryBtn(
                  context: context,
                  onTap: () {
                    if (!widget.isPinSetup) {
                      if (_oldpinController.text.isEmpty ||
                          _newpinController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          customsnackErrorBar(
                              context, "Please enter your new pin and confirm pin")); 
                      } else if (_oldpinController.text !=
                          _newpinController.text) {
                            ScaffoldMessenger.of(context).showSnackBar(
                          customsnackErrorBar(
                              context, "Pin does not match")); 
                      } else {
                        overlayLoader(context);
                        _postSetupPin(context: context, newPin: _newpinController.text, oldPin: _oldpinController.text);
                      }
                    }else {
                      if (_newpinController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          customsnackErrorBar(
                              context, "Please enter your new pin")); 
                      }else if (_oldpinController.text.isEmpty){
                        ScaffoldMessenger.of(context).showSnackBar(
                          customsnackErrorBar(
                              context, "Please enter your old pin"));
                      }
                       else {
                        overlayLoader(context);
                        _postSetupPin(context: context, newPin: _newpinController.text, oldPin: _oldpinController.text);
                      }
                    }
                    
                  },
                  btnText: widget.isPinSetup ? "Change Pin" : "Set Pin",
                  isOutline: true)
            ],
          ),
        ),
      ),
    );
  }
}
