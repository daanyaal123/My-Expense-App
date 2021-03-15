import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;
  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titlecontroller = TextEditingController();

  final amountcontroller = TextEditingController();

  DateTime selecteddate;

  void submitdata() {
    final entererdtitle = titlecontroller.text;
    final enteredamount = double.parse(amountcontroller.text);
    if (entererdtitle.isEmpty ||
        enteredamount <= 0 ||
        enteredamount == null ||
        selecteddate == null) {
      return;
    }
    widget.addTx(
      entererdtitle,
      enteredamount,
      selecteddate,
    );
    Navigator.of(context).pop();
  }

  void presentdatepicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        selecteddate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(
                    hintText: "Title",
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)))),
                controller: titlecontroller,
                onSubmitted: (_) => submitdata(),
              ),
              Padding(padding: EdgeInsets.all(8.0)),
              TextField(
                decoration: InputDecoration(
                    hintText: "Amount",
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)))),
                controller: amountcontroller,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => submitdata(),
              ),
              Expanded(
                child: Row(
                  children: [
                    Text(selecteddate == null
                        ? "No date choosen!!"
                        : DateFormat().add_yMd().format(selecteddate)),
                    Platform.isIOS
                        ? CupertinoButton(
                            color: Colors.blue,
                            child: Text(
                              "Choose Date",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: presentdatepicker,
                          )
                        : FlatButton(
                            color: Theme.of(context).primaryColor,
                            onPressed: presentdatepicker,
                            child: Text(
                              "Choose Date",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                  ],
                ),
              ),
              RaisedButton(
                color: Colors.purple,
                onPressed: submitdata,
                child: Text(
                  "Add",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
