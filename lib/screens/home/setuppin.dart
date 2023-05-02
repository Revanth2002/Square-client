import 'package:client/helpers/headers.dart';

class SetupPinPage extends StatefulWidget {
  static const String routeName = setuppin;
  const SetupPinPage({Key? key}) : super(key: key);

  @override
  _SetupPinPageState createState() => _SetupPinPageState();
}

class _SetupPinPageState extends State<SetupPinPage> {
  final TextEditingController _newpinController = TextEditingController();
  final TextEditingController _oldpinController = TextEditingController();

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
                  title: "Old Pin",
                  controller: _oldpinController,
                  hintTextField: "Enter your old pin",
                  textInputType: TextInputType.number),
              mediumCustomSizedBox(context),
              personalInfoDynamicTitle(
                  context: context,
                  title: "New Pin",
                  controller: _newpinController,
                  hintTextField: "Enter your new pin",
                  textInputType: TextInputType.number),
              mediumCustomSizedBox(context),
              mediumCustomSizedBox(context),
              primaryBtn(
                  context: context,
                  onTap: () {},
                  btnText: "Change Pin",
                  isOutline: true)
            ],
          ),
        ),
      ),
    );
  }
}
