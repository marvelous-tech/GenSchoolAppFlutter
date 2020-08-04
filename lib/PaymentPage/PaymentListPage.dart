import 'package:flutter/material.dart';
import 'package:bd_class/PaymentPage/MakePaymentPage.dart';
import 'package:bd_class/messages/messages.dart';
import 'package:bd_class/models/payment.models.dart';
import 'package:bd_class/repository/payment.repository.dart';
import 'package:bd_class/theme/appBar.dart';
import 'package:intl/intl.dart';


class PaymentListPage extends StatefulWidget {
  @override
  _PaymentListPageState createState() => _PaymentListPageState();
}

class _PaymentListPageState extends State<PaymentListPage> {
  List<PaymentModel> _payments;
  PaymentRepository _paymentRepository;
  bool isLoading = false;
  GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  void initState() {
    this._paymentRepository = PaymentRepository();
    this.getPaymentList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          onNavigateToMakePayment(context);
        },
      ),
      appBar: appBarThemed("Payment Activity"),
      body: SafeArea(
        child: Container(
          child: Center(
            child: this.isLoading == true ? CircularProgressIndicator()
            : this.getList(),
          )
        ),
      ),
    );
  }

  void getPaymentList() async {
    this.isLoading = true;
    await this._paymentRepository.fetchAllPayments()
    .then((value) => this.setState(() {
      this._payments = value;
      this.isLoading = false;
    }));
  }

  Widget getList() {
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
            child: ListView.builder(
              itemCount: this._payments.length,
              itemBuilder: (BuildContext context, int n) {
                PaymentModel paymentModel = this._payments[n];
                return Card(
                  elevation: 0.0,
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "${paymentModel.paymentOn.toUpperCase()}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            Text(
                              DateFormat.yMMMEd().add_jm().format(DateTime.parse(paymentModel.paymentMadeDateTime).toUtc()),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "BDT ${paymentModel.paymentAmount.toString()}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30
                              ),
                            ),
                            paymentModel.paymentIsVerified == true ?
                            Icon(Icons.check_circle, size: 45, color: Colors.lightGreen,) :
                            Icon(Icons.cancel, size: 45, color: Colors.redAccent,),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[300]),
                              borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Text(
                                  "Key ${paymentModel.paymentKey}",
                                  style: TextStyle(
                                  ),
                                ),
                                SizedBox(height: 5,),
                                Text(
                                  "trxID ${paymentModel.paymentTransactionId}",
                                  style: TextStyle(
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }
            ),
          ),
        ),
      ],
    );
  }

  void onNavigateToMakePayment(BuildContext context) async {
    PaymentModel result = await Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return MakePayment();
      }
    ));
    if (result != null) {
      setState(() {
        this._payments.insert(0, result);
      });
      this._key.currentState.showSnackBar(
          SnackBar(
            content: SuccessMsgText(msg: "Your payment was successful",),
          )
      );
    }
  }
}

