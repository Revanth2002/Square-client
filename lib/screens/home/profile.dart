import 'package:client/apis/authapi.dart';
import 'package:client/apis/homeapi.dart';
import 'package:client/helpers/headers.dart';
import 'package:client/screens/home/checkbalance.dart';
import 'package:client/screens/home/setuppin.dart';
import 'package:qr_flutter/qr_flutter.dart';

class MyProfilePage extends StatefulWidget {
  static const String routeName = profilepage;
  const MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  Future? _getProfileFuture;
  final HomeScreenAPI _homeScreenAPI = HomeScreenAPI();

  @override
  void initState() {
    super.initState();
    _getProfileFuture = _getProfile();
  }

  _getProfile() async {
    return await _homeScreenAPI.getProfilePage(context: context);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: commonNavbar(context: context, isBack: true),
      body: SafeArea(
        child: FutureBuilder(
          future: _getProfileFuture,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: kDefaultScreenPaddingHorizontal(context),
                          vertical: kDefaultScreenPaddingVertical(context)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        snapshot.data["name"],
                                        style: mediumLargeTextStyle(context),
                                      ),
                                      smallCustomSizedBox(context),
                                      Text(
                                        snapshot.data["mobile"],
                                        style: mediumTextStyle(context)
                                            .copyWith(color: kDimGray),
                                      ),
                                      Text(
                                        isEmptyOrNull(snapshot.data['email'])
                                            ? "Email not updated"
                                            : snapshot.data['email'],
                                        style: mediumTextStyle(context)
                                            .copyWith(color: kDimGray),
                                      )
                                    ]),
                              ),
                              // IconButton(
                              //   // onPressed: () => Navigator.of(context)
                              //   //     .push(CustomRightPageRoute(
                              //   //         page: const PersonalDataPage(
                              //   //           patientId: "",
                              //   //         ),
                              //   //         routeName: personaldatapage)),
                              //   onPressed: () {},
                              //   icon: const FaIcon(FontAwesomeIcons.edit,
                              //       color: kPrimaryColor, size: 18),
                              // ),
                            ],
                          ),
                          mediumCustomSizedBox(context),
                        ],
                      ),
                    ),
                    // kSmallDivider(context),
                    Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                kDefaultScreenPaddingHorizontal(context),
                            vertical: kDefaultScreenPaddingVertical(context)),
                        child: CustomPaint(
                          foregroundPainter: BorderPainter(),
                          child: Container(
                            width: 300, // size.width,
                            height: 260,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: kPrimaryColor.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                              // image:const DecorationImage(
                              //   image: NetworkImage("https://cdn.britannica.com/17/155017-050-9AC96FC8/Example-QR-code.jpg"),
                              //   fit: BoxFit.contain,
                              // ),
                            ),
                            child: Center(
                              child: QrImage(
                                data: snapshot.data["pid"],
                                version: QrVersions.auto,
                                // constrainErrorBounds: true,
                                // dataModuleStyle: QrDataModuleStyle(
                                //   dataModuleShape: QrDataModuleShape.square,
                                //   color: Colors.black,
                                // ),
                                padding: EdgeInsets.all(10.0),
                                // size: 200.0,
                              ),
                            ),
                            //  Image.network(
                            //   "https://cdn.britannica.com/17/155017-050-9AC96FC8/Example-QR-code.jpg",
                            //   fit: BoxFit.contain,
                            // ),
                          ),
                        ),
                      ),
                    ),
                    mediumCustomSizedBox(context),
                    kSmallDivider(context),
                    mediumCustomSizedBox(context),
                    profileTiles(
                      context: context,
                      title: "Setup Pin",
                      icon: Icons.lock,
                      onTap: () => Navigator.push(
                          context,
                          CustomRightPageRoute(
                              page: SetupPinPage(
                                  isPinSetup: snapshot.data['pin_set']),
                              routeName: setuppin)),
                    ),
                    profileTiles(
                      context: context,
                      title: "Check Balance",
                      icon: Icons.lock,
                      onTap: () => Navigator.push(
                          context,
                          CustomRightPageRoute(
                              page : CheckBalancePage(),
                              routeName: checkbalance)),
                    ),
                    profileTiles(
                        context: context,
                        title: "Help & Support",
                        icon: Icons.help,
                        onTap: () {}),

                    profileTiles(
                        context: context,
                        title: "Terms & Conditions",
                        icon: Icons.rule_sharp,
                        onTap: () {}),

                    profileTiles(
                        context: context,
                        title: "Logout",
                        icon: Icons.logout,
                        onTap: () async {
                          AuthenticationAPI().performLogOut(context);
                        }),

                    ///Version

                    Container(
                      width: size.width,
                      padding: EdgeInsets.symmetric(
                          horizontal: kScreenMarginHorizontal(context)),
                      child: Column(
                        children: [
                          mediumCustomSizedBox(context),
                          mediumCustomSizedBox(context),
                          lineDivider(context,
                              thickness: 0.5, color: kBlackTextColor),
                          mediumCustomSizedBox(context),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "v1.1.0",
                              style: smallTextStyle(context),
                            ),
                          ),
                          mediumCustomSizedBox(context),
                        ],
                      ),
                    )
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return defaultErrordialog(
                  context: context,
                  errorCode: ES_0060,
                  message: "Something went wrong.Try again Later");
            }
            return SizedBox(
                width: size.width,
                height: size.height,
                child: Center(child: customCircularProgress()));
          },
        ),
      ),
    );
  }
}
