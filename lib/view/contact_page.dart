import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app_contact_list/controllers/contact.dart';

class ContactPage extends StatefulWidget {

  final Contact contact;

  ContactPage({this.contact});

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {

  Contact _contact;
  bool _wasEdited = false;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(widget.contact == null) {
      _contact = Contact();
    } else {
      _contact = Contact.fromMap(widget.contact.toMap());
      _nameController.text = _contact.name;
      _emailController.text = _contact.email;
      _phoneController.text = _contact.phone;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(_contact.name ?? "New contact"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(Icons.save),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            GestureDetector(
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: _contact.image != null ? FileImage(File(_contact.image)) : AssetImage("assets/luigi.jpg")
                    )
                ),
              ),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "Name:"
              ),
              onChanged: (text) {
                _wasEdited = true;
                setState(() {
                  _contact.name = text;
                });
              },
              controller: _nameController,
            ),
            TextField(
              decoration: InputDecoration(
                  labelText: "Email:"
              ),
              onChanged: (text) {
                _wasEdited = true;
                _contact.email = text;
              },
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
            ),
            TextField(
              decoration: InputDecoration(
                  labelText: "Phone:"
              ),
              onChanged: (text) {
                _wasEdited = true;
                _contact.phone = text;
              },
              keyboardType: TextInputType.phone,
              controller: _phoneController,
            )
          ],
        ),
      ),
    );
  }
}
