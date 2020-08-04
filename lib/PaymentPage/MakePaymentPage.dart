
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:bd_class/models/payment.models.dart';
import 'package:bd_class/repository/payment.repository.dart';
import 'package:bd_class/services/authentication/login.service.dart';
import 'package:bd_class/theme/appBar.dart';
import 'package:bd_class/theme/colors.dart';
import 'package:intl/intl.dart';
import 'package:smart_select/smart_select.dart';


class MakePayment extends StatefulWidget {
  @override
  _MakePaymentState createState() => _MakePaymentState();
}

class _MakePaymentState extends State<MakePayment> {
  final _formKey = GlobalKey<FormState>();

  PaymentCreateModel _paymentCreateModel;

  PaymentModel _paymentModel;

  PaymentRepository _paymentRepository;

  LoginService _loginService;

  String paymentPurpose = 'EXAM FEE';
  List<SmartSelectOption<String>> options = [
    SmartSelectOption<String>(value: 'EXAM FEE', title: 'EXAM FEE'),
    SmartSelectOption<String>(value: 'SPECIAL FEE', title: 'SPECIAL FEE'),
    SmartSelectOption<String>(value: 'INSTITUTE FEE', title: 'INSTITUTE FEE'),
    SmartSelectOption<String>(value: 'CLASS FEE', title: 'CLASS FEE'),
    SmartSelectOption<String>(value: 'FINE', title: 'FINE'),
  ];

  final TextEditingController trxID = TextEditingController();
  final TextEditingController amount = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    this.trxID.dispose();
    this.amount.dispose();
    super.dispose();
  }

  @override
  void initState() {
    this._loginService = LoginService();
    this._paymentRepository = PaymentRepository();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarThemed("Make payment"),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    validator: (value) {
                      if (value.length == 0) return "Please add an amount";
                      double val = double.parse(value);
                      if (val < 10) {
                        return "Can't add this amount";
                      }
                      return null;
                    },
                    controller: this.amount,
                    style: TextStyle(
                      letterSpacing: 3,
                      fontSize: 40,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Amount",
                      labelStyle: TextStyle(
                        fontSize: 25
                      ),
                      hintText: "Enter amount",
                      helperText: "Please make sure before you make the payment"
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    validator: (value) {
                      if (value.length < 4) {
                        return "Can't add this trxID";
                      }
                      return null;
                    },
                    controller: this.trxID,
                    style: TextStyle(
                      fontSize: 24,
                      letterSpacing: 2,
                      color: Colors.amberAccent,
                      fontWeight: FontWeight.bold
                    ),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Transaction ID",
                        hintText: "Enter trxID",
                        helperText: "Please make sure before you make the payment"
                    ),
                  ),
                  SizedBox(height: 20,),
                  SmartSelect<String>.single(
                    modalType: SmartSelectModalType.bottomSheet,
                    title: 'Payment purpose',
                    value: this.paymentPurpose,
                    options: this.options,
                    onChange: (val) => setState(() => this.paymentPurpose = val)
                  ),
                  SizedBox(height: 20,),
                  RaisedButton(
                    onPressed: () { onMakePayment(context); },
                    onLongPress: () => Navigator.pop(context),
                    elevation: 8.0,
                    color: Colors.amberAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text(
                        "Make payment",
                        style: TextStyle(
                          color: foreground,
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                        ),
                      ),
                    ),
                  ),
                ]
              )
            ),
          ),
        ),
      ),
    );
  }

  void onMakePayment(BuildContext context) async {
    FocusScope.of(context).unfocus();
    if (this._formKey.currentState.validate()) {
      setState(() {
        this._paymentCreateModel = PaymentCreateModel(
            paymentAmount: double.parse(this.amount.text),
            paymentTransactionId: this.trxID.text,
            paymentOn: this.paymentPurpose
        );
      });

      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))
            ),
            child: Container(
              height: 250,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "${_paymentCreateModel.paymentOn.toUpperCase()}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        DateFormat.yMMMEd().add_jm().format(DateTime.now()),
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
                        "BDT ${_paymentCreateModel.paymentAmount.toString()}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30
                        ),
                      ),
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
                      child: Text(
                        "trxID ${_paymentCreateModel.paymentTransactionId}",
                        style: TextStyle(
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  Center(
                    child: Text("To make the payment hold confirmation button",
                      style: TextStyle(
                        fontSize: 12
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  RaisedButton(
                    onPressed: () {Navigator.pop(context);},
                    onLongPress: () {this.onMakePaymentConfirm(context);},
                    elevation: 8.0,
                    color: Colors.amberAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text(
                        "Confirm payment",
                        style: TextStyle(
                            color: foreground,
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          );
        }
      );
      if (this._paymentModel != null)
        Navigator.pop(context, this._paymentModel);
    }
  }

  onMakePaymentConfirm(BuildContext context) async {
    await this._paymentRepository.addPayment(this._paymentCreateModel)
    .then((value) {
      setState(() {
        this._paymentModel = PaymentModel.fromJson(jsonDecode(value.body));
      });
      Navigator.pop(context);
    })
    .catchError((onError) {
      this.logout(context);
    });
  }
  void logout(context) async {
    await this._loginService.logout().then((value) {
      Navigator.pushNamedAndRemoveUntil(
          context, "/login", (Route<dynamic> route) => false);
    });
  }
}

