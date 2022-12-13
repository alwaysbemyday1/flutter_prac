import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final firestore = FirebaseFirestore.instance;

class ShoppingPage extends StatefulWidget {
  const ShoppingPage({super.key});

  @override
  State<ShoppingPage> createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> {
  getData() async {
    var result = await firestore
        .collection('product')
        .where('price', isGreaterThan: 90000)
        .get();
    for (var doc in result.docs) {
      print(doc['brand']);
    }
  }

  addData() async {
    firestore
        .collection('product')
        .add({'category': 'underwear', 'brand': 'calvin klein', 'price': 30000})
        .then((value) => print('succed'))
        .catchError((var error) {
          print(error);
        });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Text('Shopping tab');
  }
}
