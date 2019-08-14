import 'package:flutter/widgets.dart';

class EmptyContacts extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 40),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Welcome to VIC \n', textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 35,
                        height: .5,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'IndieFlower')),
                Text(
                    'Now you need to make \njust one \nmore good choice :)\n\nand select your \nimportant contacts',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30,
                        height: .75,
                        fontStyle: FontStyle.italic,
                        fontFamily: 'IndieFlower')),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Text('Add your contact here ->', textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    height: .2,
                    fontFamily: 'IndieFlower')),
          )
        ],
      ),
    );
  }
}