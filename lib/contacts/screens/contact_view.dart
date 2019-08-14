import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:responsive_container/responsive_container.dart';

enum OverflowMenu { test }

class ContactView extends StatelessWidget {
  final Contact contact;

  ContactView(this.contact);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.white,
        ),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              actions: <Widget>[
                IconButton(icon: Icon(Icons.star, color: Colors.grey,)),
                PopupMenuButton<OverflowMenu>(
                  onSelected: (OverflowMenu result) {},
                  itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<OverflowMenu>>[
                  ],
                )
              ],
              leading: IconButton(
                  alignment: Alignment.centerLeft,
                  icon: Icon(Icons.arrow_back, color: Colors.grey,),
                  onPressed: () => Navigator.of(context).pop()),
            ),
            body: Center(
              child: ResponsiveContainer(
                heightPercent: 90.0, //value percent of screen total height
                widthPercent: 90.0,  //value percent of screen total width
                child:Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 50.0),
                      child: CircleAvatar(
                        radius: 75,
                        child: ClipOval(
                          child: this.contact.avatar.isEmpty ? Image.asset(
                              'assets/ppic.png') : Image.memory(
                              this.contact.avatar),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 50.0),
                      child: Text(this.contact.displayName,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          radius: 20,
                          child: ClipOval(
                            child: Image.memory(this.contact.avatar),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(int.tryParse(
                            this.contact.phones.first.value.substring(
                                this.contact.phones.first.value.length -
                                    2)) % 2 == 0
                            ? 'Engagement out of date'
                            : 'Engagement not out of date',
                        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)
                        )),
                        Icon(Icons.warning,
                            color: int.tryParse(
                                this.contact.phones.first.value.substring(
                                    this.contact.phones.first.value.length -
                                        2)) % 2 == 0
                                ? Colors.red
                                : Colors.green)
                      ],
                    ),
                    BorderedButton('Template Subject', 'Is everything alright?'),
                    BorderedButton('How are you.....', 'Hi how are you?'),
                    BorderedButton('Long Time.....', 'Long time no see'),
                  ]
              ),
            )
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.edit),
            ),
            bottomNavigationBar: ButtonBar(
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Interests'),
                new IconButton(icon: new Icon(Icons.timer)),
                new IconButton(icon: new Icon(Icons.people)),
                new IconButton(icon: new Icon(Icons.map)),
              ],
            )
        )
    );
  }
}

class BorderedButton extends StatelessWidget {

  final String text;
  final String dialogText;
  TextEditingController textCtrl;

  BorderedButton(this.text, this.dialogText){
    this.textCtrl = TextEditingController(text:this.dialogText);
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: MediaQuery
          .of(context)
          .size
          .width,
      margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 6.0),
      padding: const EdgeInsets.all(3.0),
      decoration: new BoxDecoration(
          border: new Border.all(color: Colors.blueAccent)
      ),
      child: new FlatButton(
        child: Text(this.text),
        onPressed: ()=>_displayDialog(context),
      ),
    );
  }

  _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Popup'),
            content: TextField(
              controller: this.textCtrl,
              decoration: InputDecoration(hintText: this.dialogText),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('SEND'),
                onPressed: () {
                  Share.share(this.textCtrl.text);
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}