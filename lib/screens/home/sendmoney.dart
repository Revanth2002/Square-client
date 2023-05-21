import 'package:client/apis/paymentapi.dart';
import 'package:client/helpers/headers.dart';
import 'package:client/screens/home/paypin.dart';

class SendMoneyPage extends StatefulWidget {
  static const String routeName = sendmoneypage;
  final String recName;
  final String recPhone;
  final String recImg;
  final String recPid;
  const SendMoneyPage({Key? key, required this.recName, required this.recPhone, required this.recImg, required this.recPid}) : super(key: key);

  @override
  _SendMoneyPageState createState() => _SendMoneyPageState();
}

class _SendMoneyPageState extends State<SendMoneyPage> {

  final TextEditingController _amountController = TextEditingController(text: "");

  @override
  void initState() {
    super.initState();
    // _amountController.text = null;
  }

  @override
  Widget build(BuildContext context) {
    var size = sizeMedia(context);
    return Scaffold(
      appBar: commonNavbar(context: context, isBack: true),
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //Paying to Text
                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Paying To",
                            style: largeTextStyle(context)
                          ),
                    defaultDivider(),

                        ],
                      ),
                    ),
                    smallCustomSizedBox(context),
                    //Recipient Image
                    Center(
                      child: Container(
                        height: 50,
                        // width: 150,
                        margin: EdgeInsets.symmetric(
                          horizontal: kDefaultScreenPaddingHorizontal(context),
                          vertical: kDefaultScreenPaddingVertical(context)
                        ),
                        decoration: BoxDecoration(
                          color: kLavenderGrayColor,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(widget.recImg),
                              fit: BoxFit.cover
                            )
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            widget.recName,
                            style: mediumTextStyle(context)
                          ),
                        )
                          ],
                        ),
                      ),
                    ),
                    smallCustomSizedBox(context),
                    //zeropay ID
                    Center(
                      child: Text(
                        "${widget.recPhone}@zeropay",
                        style: mediumTextStyle(context).copyWith(fontWeight:FontWeight.w500)
                      ),
                    ),
                    smallCustomSizedBox(context),
                    
                  ],
                ),
                mediumCustomSizedBox(context),
                mediumCustomSizedBox(context),
                mediumCustomSizedBox(context),
                mediumCustomSizedBox(context),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Enter Amount",
                        style: mediumLargeTextStyle(context).copyWith(color:kDimGray,fontWeight:FontWeight.w500)
                      ),
                      mediumCustomSizedBox(context),
                    ],
                  ),
                ),
                   //Add the Input Amount
                      Center(
                            
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: size.width * 0.25
                              ),
                              child: TextFormField(
                                controller: _amountController,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(4),
                                ],
                                keyboardType: TextInputType.number,
                                enableSuggestions: true,
                                enableInteractiveSelection: true,
                                
                                decoration: InputDecoration(
                                  enabled: true,
                                  hintText: '0',
                                  hintStyle: const TextStyle(
                                    color: kGraycolor,
                                    fontSize: 13.0,
                                  ),
                                  labelText: '',
                                  labelStyle: const TextStyle(
                                    color: kGraycolor,
                                    fontSize: 13.0,
                                  ),
                                  prefix: Text(
                                    "\u20B9 ",
                                    style: TextStyle(
                                        color: kGraycolor,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: kGraycolor),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: const BorderSide(color: kGraycolor),
                                  ),
                                ),
                              ),
                            ),
                          ),
                  
              ],
            ),
         
          Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: kDefaultScreenPaddingHorizontal(context),
                    vertical: kDefaultScreenPaddingVertical(context)
                  ),
                  child: primaryBtn(context: context, 
                   onTap: (){
                    if(_amountController.text.isEmpty){
                        ScaffoldMessenger.of(context).showSnackBar(customsnackErrorBar(context, "Please enter amount"));
                    }else{
                         Navigator.push(
                                              context,
                                              CustomRightPageRoute(
                                                  page:  PayPinPage(
                                                    recPid: widget.recPid,
                                                    recAmt: _amountController.text,
                                                  ),
                                                  routeName:
                                                      addcard));
                    }
                   }, 
                   btnText: "Pay", 
                    isOutline: false,
                    
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}