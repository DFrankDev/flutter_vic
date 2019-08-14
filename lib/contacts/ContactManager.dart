import 'package:contact_picker/contact_picker.dart' as ContactPicker;
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactManager {
  static void contactChooser(Function cb) async {
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.contacts);

    if (permission != PermissionStatus.granted) {
      Map<PermissionGroup,
          PermissionStatus> permissions = await PermissionHandler()
          .requestPermissions([PermissionGroup.contacts]);

      permission = await PermissionHandler().checkPermissionStatus(
          PermissionGroup.contacts);
    }

    if (permission == PermissionStatus.granted) {
      ContactPicker.Contact contact = await ContactPicker.ContactPicker()
          .selectContact();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(
          contact.fullName, contact.phoneNumber.number);
    }

    reloadContacts(cb);
  }

  static void reloadContacts(Function cb) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Contact> _contacts = new List();

    for (String key in prefs.getKeys()) {
      Iterable<Contact> contacts = await ContactsService.getContacts(
          query: key);
      for (Contact contact in contacts)
        if (contact.displayName == key) {
          _contacts.add(contact);
        }
    }

    _contacts.sort((a, b) {
      return a.displayName.toLowerCase().compareTo(b.displayName.toLowerCase());
    });

    cb(_contacts);
  }
}