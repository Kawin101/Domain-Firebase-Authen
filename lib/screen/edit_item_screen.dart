import 'dart:html';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:domain_firebase/services/item_service.dart';

class EditItemScreen extends StatefulWidget {
  // Definde Object to get data
  EditItemScreen(this.documentid, this.itemName, this.itemDesc);
  String documentid;
  String itemName;
  String itemDesc;

  @override
  State<EditItemScreen> createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
  // Define Controllet to set data
  TextEditingController itemName = TextEditingController();
  TextEditingController itemDesc = TextEditingController();
  // Define Object Service Data
  ItemService itemService = ItemService();

  @override
  Widget build(BuildContext context) {
    // Create Object Widget to get data
    itemName.text = widget.itemName;
    itemDesc.text = widget.itemDesc;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Item"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: itemName,
              decoration: const InputDecoration(label: Text("Item name")),
            ),
            TextField(
              controller: itemDesc,
              decoration:
                  const InputDecoration(label: Text("Item Description")),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  _deleteItem(context);
                },
                // Define Button Colors!
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text("Delete")),
            ElevatedButton(
                onPressed: () {
                  _editItem(context);
                },
                child: const Text("Edit"))
          ],
        ),
      ),
    );
  }

  // Make a function edit & delete data on firebase
  // Kawinphop Chomnikorn 633410142-5
  // 26-2-2023, 3:12 AM.
  void _editItem(BuildContext context) {
    if (itemName.text == "" || itemDesc.text == "") {
    } else {
      itemService
          .editItem(context, {"name": itemName.text, "desc": itemDesc.text},
              widget.documentid)
          .then((value) => Navigator.pop(context));
      itemName.text = "";
      itemDesc.text = "";
    }
  }

  void _deleteItem(BuildContext context) {
    if (itemName.text == "" || itemDesc.text == "") {
    } else {
      itemService
          .deleteItem(context, widget.documentid)
          .then((value) => Navigator.pop(context));
      itemName.text = "";
      itemDesc.text = "";
    }
  }
}
