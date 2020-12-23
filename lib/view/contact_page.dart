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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(widget.contact == null) {
      _contact = Contact();
    } else {
      _contact = Contact.fromMap(widget.contact.toMap());
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
    );
  }
}
