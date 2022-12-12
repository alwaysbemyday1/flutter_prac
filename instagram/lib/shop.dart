import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final firestore = FirebaseFirestore.instance;

class Shop extends StatefulWidget {
  const Shop({super.key});

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
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
    await firestore
        .collection('product')
        .add({'category': 'shoes', 'brand': 'nike', 'price': 180000});
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Text('shopping tab');
  }
}
