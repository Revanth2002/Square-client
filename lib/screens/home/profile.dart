import 'package:client/helpers/headers.dart';
import 'package:client/screens/home/setuppin.dart';

class MyProfilePage extends StatefulWidget {
  static const String routeName = profilepage;
  const MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: commonNavbar(context: context, isBack: true),
      body: SafeArea(
        child: SingleChildScrollView(
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Revanth ND",
                                  style: mediumLargeTextStyle(context),
                                ),
                                smallCustomSizedBox(context),
                                Text(
                                  "8072625127",
                                  style: mediumTextStyle(context)
                                      .copyWith(color: kDimGray),
                                ),
                                Text(
                                  "Email not yet updated",
                                  style: mediumTextStyle(context)
                                      .copyWith(color: kDimGray),
                                )
                              ]),
                        ),
                        IconButton(
                          // onPressed: () => Navigator.of(context)
                          //     .push(CustomRightPageRoute(
                          //         page: const PersonalDataPage(
                          //           patientId: "",
                          //         ),
                          //         routeName: personaldatapage)),
                          onPressed: () {},
                          icon: const FaIcon(FontAwesomeIcons.edit,
                              color: kPrimaryColor, size: 18),
                        ),
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
                      horizontal: kDefaultScreenPaddingHorizontal(context),
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
                      child: Image.network(
                        "https://cdn.britannica.com/17/155017-050-9AC96FC8/Example-QR-code.jpg",
                        fit: BoxFit.contain,
                      ),
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
                                                page: const SetupPinPage(),
                                                routeName:
                                                    setuppin)),
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
                    // AuthenticationAPI().performLogOut(
                    //     context: context, userLogout: true);
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
        ),
      ),
    );
  }
}
