import 'package:etrade/db/dbHelper.dart';
import 'package:etrade/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProductAdd extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ProductAddState();
}

class ProductAddState extends State {
  DbHelper dbHelper = new DbHelper();
  TextEditingController textName = new TextEditingController();
  TextEditingController textDescription = new TextEditingController();
  TextEditingController textPrice = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add a new Product"),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 30.0, left: 10, right: 10),
        child: Column(
        children: <Widget>[
          TextField(
            controller: textName,
            decoration: InputDecoration(labelText: "Name"),
          ),
          TextField(
            controller: textDescription,
            decoration: InputDecoration(labelText: "Description"),
          ),
          TextField(
            controller: textPrice,
            decoration: InputDecoration(labelText: "Price"),
          ),
          /*FlatButton(
            child: Text("Save"),
            onPressed: (){
              save();
              },
              padding: EdgeInsets.all(20),
              textColor: Colors.orange,
          )*/
          RaisedButton(
            color: Colors.red,
            elevation: 10,
            child: Text(
              "Save",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              save();
            },
            padding: EdgeInsets.all(10),
            textColor: Colors.orange,
          )
        ],
      ) ,
      ) 
    );
  }

  void save() async{
    int result = await dbHelper.insert(
      Product(textName.text,  textDescription.text, double.tryParse(textPrice.text)));
    if (result != 0) {
      Navigator.pop(context, true);
    } 
  }
  
}