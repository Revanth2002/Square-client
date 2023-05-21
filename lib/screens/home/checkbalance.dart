import 'package:client/apis/paymentapi.dart';
import 'package:client/helpers/headers.dart';

class CheckBalancePage extends StatefulWidget {
  static const String routeName = checkbalance;
  const CheckBalancePage({Key? key}) : super(key: key);

  @override
  _CheckBalancePageState createState() => _CheckBalancePageState();
}

class _CheckBalancePageState extends State<CheckBalancePage> {

  Future? _balanceFutures;

  final PaymentAPI _paymentAPI = PaymentAPI();

  performCheckBalance()async {
    return _paymentAPI.checkCardBalance(context: context);
  }

  @override
  void initState() {
    super.initState();
    _balanceFutures = performCheckBalance();
  }

  @override
  Widget build(BuildContext context) {
    var size = sizeMedia(context);
    return Scaffold(
      appBar: commonNavbar(context: context, isBack: true),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: FutureBuilder(
          future: _balanceFutures,
          builder: (context, snapshot) {
            if(snapshot.hasData){
              return Container(
          margin: EdgeInsets.symmetric(
              horizontal: kDefaultScreenPaddingHorizontal(context),
              vertical: kDefaultScreenPaddingVertical(context)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Check Balance",
                style: largeTextStyle(context),
              ),
              mediumCustomSizedBox(context),

              Text(
                "Savings Account",
                style: mediumLargeTextStyle(context).copyWith(fontWeight : FontWeight.w500,color:kDimGray),
              ),
              smallCustomSizedBox(context),
              Text(
                snapshot.data["bank"].toString(),
                style: mediumTextStyle(context),
              ),

              mediumCustomSizedBox(context),
              Text(
                "Card Number",
                style: mediumLargeTextStyle(context).copyWith(fontWeight : FontWeight.w500,color:kDimGray),
              ),
              smallCustomSizedBox(context),
              Text(
                snapshot.data["card_number"].toString(),
                style: mediumTextStyle(context),
              ),


              mediumCustomSizedBox(context),
              Text(
                "Savings Account",
                style: mediumLargeTextStyle(context).copyWith(fontWeight : FontWeight.w500,color:kDimGray),
              ),
              smallCustomSizedBox(context),
              Text(
                "₹ ${snapshot.data["balance"]}",
                style: mediumTextStyle(context),
              ),
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
        )
      ),
    );
  }
}
