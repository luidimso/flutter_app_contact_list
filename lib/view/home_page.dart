import 'package:flutter/material.dart';
import 'package:flutter_app_contact_list/controllers/contact.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  ContactController contactController = ContactController();
  List<Contact> contacts = List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      contactController.getAll().then((value) => contacts = value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contacts"),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      floatingActionButton:  FloatingActionButton(
        onPressed: (){},
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: contacts.length,
        itemBuilder: (context, index) {

        },
      ),
    );
  }
}
