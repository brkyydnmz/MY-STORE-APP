
import 'package:etrade/db/dbHelper.dart';
import 'package:etrade/models/product.dart';
import 'package:etrade/screens/productList.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
 
    List<Product> products = new List<Product>();
    DbHelper dbHelper = new DbHelper();
    dbHelper.initializeDb().then((result)=>dbHelper.getProducts()
    .then((result)=>products = result));

    Product product = new Product("Mouse", "A4 wireless mouse available with 50% of discount", 20);
    dbHelper.insert(product);
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(
        //primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'New Dnmz Store'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       title: Text(widget.title),
      ),
      body: ProductList(),
    );
  }
}
