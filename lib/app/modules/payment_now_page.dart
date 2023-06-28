import 'package:bizmart/app/models/busines_details_save_api/plan_buy_api.dart';
import 'package:bizmart/app/models/business_details_get_api/all_plans_get_api.dart';
import 'package:bizmart/app/models/business_details_get_api/customer_get_api.dart';
import 'package:bizmart/app/models/business_details_get_api/payment_methods_get_api.dart';
import 'package:bizmart/app/models/business_details_get_api/promote_get.dart';
import 'package:bizmart/app/models/business_details_get_api/service_list_get_api.dart';
import 'package:bizmart/app/modules/root/controllers/root_controller.dart';
import 'package:bizmart/app/modules/root/views/root_view.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
class PaymentPage extends StatefulWidget {
final int selected;
final String mobileNumber;
final String sid;

const PaymentPage({Key key, this.selected, this.mobileNumber, this.sid,  }) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Razorpay _razorpay;
  String service_name;
  String brought_price;
  String total_price;
  String pay_id;

  String plan_id;
  String start_date;
  String end_date;
  String pay_type;
  String pay_status;
  var plan;
  var pay_plan;
  // String plan_name;
  // String plan_price;
  // String ;
  // String plan_name;
  //
String payment_key;
var plan_price;
  @override
  void initState() {
    super.initState();
    PaymentList().PaymentListData().then((val) {
      setState(() {
        print("++++++++++++++++++++++++++++++PROMOTE DATA++++++++++++++++++++++++++++++++++++++");
        //var pay = val['data'];
        payment_key = val['data'][0]['route'].toString();
        plan_price = val['data'][0]['route'].toString();
        print("+++++++++++++++++++++PAY MENT START+++++++++++++++++++++++++++");
        print(payment_key);
        print("+++++++++++++++++++++PAY MENT END+++++++++++++++++++++++++++");
        print(plan_price);
      });
    });
    CustomerPlan().CustomerPlanDetails().then((val)
    {
      setState(() {
         plan = val['plan_details'];
        brought_price = val['plan_details']['plan_brought_price'].toString();
        pay_id = val['plan_details']['payment_id'].toString();
        pay_status = val['plan_details']['payment_status'].toString();
        start_date = val['plan_details']['start_date'].toString();
        end_date = val['plan_details']['end_date'].toString();
        pay_type = val['plan_details']['payment_type'].toString();

      });

    });
    PromoteAndBenefits().PromoteAndBenefitsData(widget.sid).then((val)
    {
      setState(() {
         plan = val['plan'];
        brought_price = val['plan']['plan_brought_price'].toString();
        pay_id = val['plan']['payment_id'].toString();
        pay_status = val['plan']['payment_status'].toString();
        start_date = val['plan']['start_date'].toString();
        end_date = val['plan']['end_date'].toString();
        pay_type = val['plan']['payment_type'].toString();

      });

    });
    AllPlans().AllPlansData().then((val)
    {
      print(":________________SELECT PAGE___________________");
      setState(() {
        plan_id = val['data'][widget.selected]['id'].toString();
        total_price = val['data'][widget.selected]['plan_price'].toString();
      });
      print(plan_id);
      print(total_price);



      // if(widget.selected == null)
      // {
      //   total = brought_price;
      //   total = brought_price;
      //   print(total);
      //
      //
      // }
      // else
      // {
      //   print(widget.selected);
      //
      //
      // }

    }
    );
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

  }
  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    var total = double.parse(total_price)*100;
    print("+++++++++++++++++CHECKOUT++++++++++++++++++++++");

    print(total);
    print("+++++++++++++++++CHECKOUT END++++++++++++++++++++++");
    var options = {
      'key': payment_key.toString(),
      'amount': total,
      'name': 'Bizmart',
      'description': '',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact':widget.mobileNumber, 'email': ''},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    var paymet_id;
    print('Success Response: $response');
    print("++++++++++++++++++++PAYMENT SUCESS MSG+++++++++++++++++++++++++");
    print('Success Response: $response');
    print('Success Response: $response');
    paymet_id = response.paymentId.toString();
     pay_status = "PaymentSuccessResponse";
    print(paymet_id);
    String pay_method = "online";

    PlanBuy().PlanBuyData(plan_id,pay_method,total_price,paymet_id,pay_status).then((val) async{
      setState(() {

      });
         // Get.back();
          await Get.find<RootController>().changePage(0);

        }

    );
    /*Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId!,
        toastLength: Toast.LENGTH_SHORT); */
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print('Error Response: $response');
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message,
        toastLength: Toast.LENGTH_SHORT);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print('External SDK Response: $response');
    /* Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName!,
        toastLength: Toast.LENGTH_SHORT); */
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor:  Get.theme.colorScheme.secondary,
        title: Text(  plan == null ?"Pay now": "Plan brought details",style: TextStyle(color: Colors.white,fontSize: 18),),
        centerTitle: true,

      ),
      bottomNavigationBar: plan != null  ?
      Container(
        height: 20,
      ):
      Container(
        height: 120,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              height: 60,
              width: 400,
              color:Colors.white,
              child:
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total"),
                 total_price == null ?
                     Container():
                 Text("₹ "+total_price.toString())

                ],
              ),

            ),
            InkWell(
              onTap: ()
              {
                openCheckout();
              },
              child: Container(
                height: 50,
                color:Get.theme.colorScheme.secondary,
                child: Center(child: Text("Pay Now",style: TextStyle(color: Colors.white,fontSize: 18),)),

              ),
            ),
          ],
        ),
      ),
      body:SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.all(20.0),
          child:
          Column(
            children: [
              FutureBuilder(
                  future: AllPlans().AllPlansData(),
                  builder: (context,snapshot) {
                    if(snapshot.hasData)
                    {
                      return
                        Column(
                          children: [
                            Container(
                            width:double.infinity ,
                            padding:  EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.grey.shade300
                                ),
                                borderRadius: BorderRadius.circular(5)
                            ),
                            child: Column(
                              //  crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Plan type:",style: TextStyle(color:Colors.black,fontSize: 14),),
                                    Text(snapshot.data['data'][widget.selected]['plan_name'].toString(),style:TextStyle(color: Get.theme.colorScheme.secondary,fontSize: 14)),
                                  ],
                                ),
                                SizedBox(height: 15,),


                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Plan price:",style: TextStyle(color:Colors.black,fontSize: 14),),
                                    Text("₹ "+snapshot.data['data'][widget.selected]['plan_price'].toString(),style:TextStyle(color: Get.theme.colorScheme.secondary,fontSize: 14)),
                                  ],
                                ),

                                SizedBox(height: 15,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Plan duration:",style: TextStyle(color:Colors.black,fontSize: 14)),
                                    Text(snapshot.data['data'][widget.selected]['plan_duration'].toString(),style:TextStyle(color: Get.theme.colorScheme.secondary,fontSize: 14)),
                                  ],
                                ),


                              ],
                            ),
                      ),
                            SizedBox(height: 25),
                            Container(
                              width:double.infinity ,
                              padding:  EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey.shade300
                                  ),
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Plan description:",style: TextStyle(color:Colors.black,fontSize: 14),),
                                      SizedBox(height: 10,),

                                      Text(snapshot.data['data'][widget.selected]['description'].toString(),style:TextStyle(color: Get.theme.colorScheme.secondary,fontSize: 14)),
                                    ],
                                  ),



                                ],
                              ),
                            ),
                          ],
                        );
                    }
                    else
                    {
                      return Container();
                    }

                  }
              ),
              SizedBox(height: 25),
              plan == null  ? Container():
              Container(
                width:double.infinity ,
                padding:  EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.grey.shade300
                    ),
                    borderRadius: BorderRadius.circular(5)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("plan_brought_price:",style: TextStyle(color:Colors.black,fontSize: 14),),
                            Text("₹ "+brought_price.toString(),style:TextStyle(color: Get.theme.colorScheme.secondary,fontSize: 14)),
                          ],
                        ),
                        SizedBox(height: 15,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Payment method:",style: TextStyle(color:Colors.black,fontSize: 14),),
                            Text(pay_type.toString(),style:TextStyle(color: Get.theme.colorScheme.secondary,fontSize: 14)),
                          ],
                        ),
                        SizedBox(height: 15,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Payment Status:",style: TextStyle(color:Colors.black,fontSize: 14),),
                            Text("Paid",style:TextStyle(color: Get.theme.colorScheme.secondary,fontSize: 14)),
                          ],
                        ),
                        SizedBox(height: 15,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Start date:",style: TextStyle(color:Colors.black,fontSize: 14),),
                            Text(start_date.toString(),style:TextStyle(color: Get.theme.colorScheme.secondary,fontSize: 14)),
                          ],
                        ),
                        SizedBox(height: 15,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("End date:",style: TextStyle(color:Colors.black,fontSize: 14),),
                            Text(end_date.toString(),style:TextStyle(color: Get.theme.colorScheme.secondary,fontSize: 14)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )

    );
  }
}
