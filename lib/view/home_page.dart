import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app_contact_list/controllers/contact.dart';
import 'package:flutter_app_contact_list/view/contact_page.dart';
import 'package:url_launcher/url_launcher.dart';

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
    _getAllContacts();
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
        onPressed: (){
          _onContactPage();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          return _contactCardBuilder(context, index);
        },
      ),
    );
  }

  Widget _contactCardBuilder(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        _showOptions(context, index);
      },
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: <Widget>[
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: contacts[index].image != null ? FileImage(File(contacts[index].image)) : AssetImage("assets/luigi.jpg")
                  )
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(contacts[index].name ?? "",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(contacts[index].email ?? "",
                      style: TextStyle(
                          fontSize: 18
                      ),
                    ),
                    Text(contacts[index].phone ?? "",
                      style: TextStyle(
                          fontSize: 18
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showOptions(BuildContext context, int index) {
    showBottomSheet(
        context: context,
        builder: (context) {
          return BottomSheet(
              onClosing: (){},
              builder: (context) {
                return Container(
                  padding: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.all(10),
                          child: FlatButton(
                              onPressed: (){
                                launch("tel:${contacts[index].phone}");
                                Navigator.pop(context);
                              },
                              child: Text("Call",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 20
                                ),
                              )
                          ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: FlatButton(
                            onPressed: (){
                              Navigator.pop(context);
                              _onContactPage(contact: contacts[index]);
                            },
                            child: Text("Edit",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 20
                              ),
                            )
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: FlatButton(
                            onPressed: (){
                              contactController.deleteContact(contacts[index].id);
                              setState(() {
                                contacts.removeAt(index);
                                Navigator.pop(context);
                              });
                            },
                            child: Text("Delete",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 20
                              ),
                            )
                        ),
                      )
                    ],
                  ),
                );
              }
          );
        }
    );
  }

  void _getAllContacts() {
    setState(() {
      contactController.getAll().then((value) => contacts = value);
    });
  }

  void _onContactPage({Contact contact}) async {
    final editedContact = await Navigator.push(context, MaterialPageRoute(
        builder: (context) => ContactPage(contact: contact)
    ));

    if(editedContact != null) {
      if(contact != null) {
        await contactController.updateContact(editedContact);
      } else {
        await contactController.saveContact(editedContact);
      }
      _getAllContacts();
    }
  }
}
