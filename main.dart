import 'package:card_payment/progressDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutterwave/core/flutterwave.dart';
import 'package:flutterwave/models/responses/charge_response.dart';
import 'package:flutterwave/utils/flutterwave_constants.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Payment',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo to Make Payment'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String currency ="ZAR";
  String amount ="2";
  String txref=DateTime.now().toString();
  String publicKey ="FLWPUBK_TEST-2f42e1112bd791596628d1a2c6e1db8d-X";
  String encryptionKey ="FLWSECK_TESTd90cbf982184";

  beginPayment() async {
    final Flutterwave flutterwave = Flutterwave.forUIPayment(
        context: this.context,
        encryptionKey: this.encryptionKey,
        publicKey: this.publicKey,
        currency: this.currency,
        amount: this.amount,
        email: "valid@email.com",
        fullName: "Valid Full Name",
        txRef: DateTime.now().toString(),
        isDebugMode: false,
        phoneNumber: "0123456789",
        acceptCardPayment: true,
        acceptUSSDPayment: false,
        acceptAccountPayment: false,
        acceptFrancophoneMobileMoney: false,
        acceptGhanaPayment: false,
        acceptMpesaPayment: false,
        acceptRwandaMoneyPayment: false,
        acceptUgandaPayment: false,
        acceptZambiaPayment: false);

    try {
      final ChargeResponse response = await flutterwave.initializeForUiPayments();
      print(response.message);
      if (response == null) {
        // user didn't complete the transaction.
      } else {
        final isSuccessful = checkPaymentIsSuccessful(response);
        if (isSuccessful) {
          // provide value to customer
        } else {
          // check message
          print(response.message);

          // check status
          print(response.status);

          // check processor error
          print(response.data.processorResponse);
        }
      }
    } catch (error, stacktrace) {
      // handleError(error);
    }
  }

  bool checkPaymentIsSuccessful(final ChargeResponse response) {
    return response.data.status == FlutterwaveConstants.SUCCESSFUL &&
        response.data.currency == this.currency &&
        response.data.amount == this.amount &&
        response.data.txRef == this.txref;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Press the button to pay:',
            ),
          //  Text('$_counter',style: Theme.of(context).textTheme.headline4,),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: beginPayment,
        tooltip: 'Pay',
        child: Icon(Icons.payment_sharp),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
