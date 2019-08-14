import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/widgets.dart';
import 'package:side_header_list_view/side_header_list_view.dart';

import 'ContactTile.dart';

class ContactList extends StatelessWidget{
  final List<Contact> contacts;
  ContactList(this.contacts);

  @override
  Widget build(BuildContext context) {
    return SideHeaderListView(
      itemCount: this.contacts.length,
      itemExtend: 66.0,
      headerBuilder: (BuildContext context, int index) {
        return Padding(
            padding: EdgeInsets.only(left: 30, top: 5),
            child: Text(this.contacts[index].displayName.substring(0, 1),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),));
      },
      itemBuilder: (BuildContext context, int index) {
        return ContactTile(this.contacts[index]);
      },
      hasSameHeader: (int a, int b) {
        return this.contacts[a].displayName.substring(0, 1) ==
            this.contacts[b].displayName.substring(0, 1);
      },
    );
  }
}