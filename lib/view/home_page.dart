import 'package:flutter/material.dart';
import 'package:flutter_app_contact_list/controllers/contact.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  ContactController contactController = ContactController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Contact contact = Contact();

    contact.name = "Tiago Corrêa";
    contact.email = "tiago@teste.com";
    contact.phone = "999999999";
    contact.image = "";

    contactController.saveContact(contact);

    contactController.getAll().then((value) => print(value));
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
