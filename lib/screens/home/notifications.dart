

import 'package:client/helpers/headers.dart';

class NotificationPage extends StatefulWidget {
  static const routeName = notificationpage;
  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  Future? _notificationFuture;

  @override
  void initState() {
    super.initState();
  }

  // _receiveNotification() async {
  //   return await _notificationAPI.getNotifications(context: context);
  // }

  // _putMessageSeenZone({required String messageId})async{
  //   return await _notificationAPI.putSeenMessage(context: context, messageId: messageId);
  // }

  @override
  Widget build(BuildContext context) {
    var size = sizeMedia(context);
    return SafeArea(
      child: Scaffold(
        appBar: commonNavbar(context: context, isBack: true),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
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
                                text: "Notifications",
                                isViewAll: false),
                            defaultDivider(),
                            mediumCustomSizedBox(context)
                          ],
                        ),
                 ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            addAutomaticKeepAlives: true,
                            itemCount: 5,
                            itemBuilder: (BuildContext context, int i) {
                              return Column(
                                children: [
                                  Theme(
                                    data: ThemeData(
                    dividerColor: Colors.transparent,
                    unselectedWidgetColor: kPrimaryColor,
                    dialogBackgroundColor: Colors.white
              ),
                                    child: ExpansionTile(
                                      initiallyExpanded: false,
                                      onExpansionChanged: (isExpanded){
                                        // if(messages[i]['seen'] == false){
                                        //   _putMessageSeenZone(messageId: messages[i]['id'].toString(),);
                                        //   setState(() {
                                        //   messages[i]['seen'] = isExpanded;
                                        // });
                                        // }
                                      },
                                      title: Container(
                                      margin:
                                          EdgeInsets.only(top: i == 0 ? 0 : 15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Container(
                                          //   height: 30,
                                          //   width: 30,
                                          //   child: Icon(
                                          //       messages[i]['seen'] == true
                                          //           ? Icons.visibility_outlined
                                          //           : Icons
                                          //               .notifications_active_outlined,
                                          //       color: messages[i]['seen'] == true
                                          //           ? kSteelBlue
                                          //           : kPinkRedishColor,
                                          //       size: 20.0),
                                          // ),
                                          RotatedBox(
                                            quarterTurns: 1,
                                            child: smallCustomSizedBox(context),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "200Rs. added to your wallet",
                                                  softWrap: true,
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: mediumTextStyle(context)
                                                  //     .copyWith(
                                                  //       fontWeight : messages[i]['seen'] == true ? FontWeight.w300 : FontWeight.w700,
                                                  //   color: Colors.black
                                                  //       .withOpacity(0.8),
                                                  // ),
                                                ),
                                                smallCustomSizedBox(context),
                                                Text(
                                                  "10-12-2023 04:30pm",
                                                  style: smallTextStyle(context),
                                                  // .copyWith(fontWeight : messages[i]['seen'] == true ? FontWeight.w300 : FontWeight.w700, ),
                                                  softWrap: true,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                      children: <Widget>[
                                        ListTile(
                                          title:  Text(
                                                  "200Rs added to your wallet",
                                                  softWrap: true,
                                                  style: mediumTextStyle(context)
                                                      .copyWith(
                                                    color: Colors.black
                                                        .withOpacity(0.8),
                                                  ),
                                                ),
                                        )
                                      ],
                                    ),
                                  ),
                                  mediumCustomSizedBox(context),
                                  lineDivider(context,
                                      color: kSlateGray, thickness: 1),
                                ],
                              );
                            },
                          ),
                       
            ],
          ),
          )
        ),
      ),
    );
  }

}
