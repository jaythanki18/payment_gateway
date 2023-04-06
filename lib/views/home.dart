import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:toast/toast.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required String title}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Razorpay razorpay;
  TextEditingController textEditingController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    razorpay = new Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    razorpay.clear();
  }

  void openCheckOut() {
    var options = {
      "key": "rzp_test_QU32rWAuetiVD2",
      "amount":num.parse(textEditingController.text)*100,
      "name":"Sample app",
      "description":"Payment for product",
      "prefill":{
        "contact":"2323232323",
        "email":"abc@gmail.com",
      },
      "external":{
        "wallets":["paytm"]
      }
    };

    try{
      razorpay.open(options);
    }
    catch(e){
      print(e.toString());
    }
  }

  void handlerPaymentSuccess() {
    print("Payment success");
    Toast.show("Payment success");
  }

  void handlerErrorFailure() {
    print("Payment error");
    Toast.show("Payment error");
  }

  void handlerExternalWallet() {
    print("External wallet");
    Toast.show("External wallets");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Razorpay'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            TextField(
              controller: textEditingController,
              decoration: InputDecoration(
                  hintText: "Amount to pay"
              ),
            ),
            SizedBox(height: 12,),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                ),
                onPressed: () {
                  openCheckOut();
                },
                child: Text('Pay now',style: TextStyle(
                  color: Colors.white,
                ),),)
          ],
        ),
      ),
    );
  }
}