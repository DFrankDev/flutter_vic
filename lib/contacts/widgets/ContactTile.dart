import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_vic/contacts/screens/contact_view.dart';

class ContactTile extends StatelessWidget {
  final Contact contact;
  ContactTile(this.contact);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: <Widget>[
            Expanded(child: Text(this.contact.displayName,
              style: TextStyle(fontSize: 20),),),
            Icon(Icons.warning,
                color: int.tryParse(
                    this.contact.phones.first.value.substring(
                        this.contact.phones.first.value.length - 2)) %
                    2 == 0
                    ? Colors.red
                    : Colors.yellow)
          ],
        ),
      ),
      leading: CircleAvatar(
        child: ClipOval(
          child: this.contact.avatar.isEmpty ? Image.asset(
              'assets/ppic.png') : Image.memory(this.contact.avatar),
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ContactView(this.contact)),
        );
      },
    );
  }
}
