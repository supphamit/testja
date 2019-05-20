import 'package:flutter/material.dart';
// import './todo.dart';
import './model/user.dart';
import './friend.dart';

class FriendInfopage extends StatefulWidget {
  int id;
  String name;
  final User user;
  FriendInfopage({Key key, this.id, this.name, this.user}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return FriendInfopageState();
  }
}

class FriendInfopageState extends State<FriendInfopage> {
  @override
  Widget build(BuildContext context) {
    int id = widget.id;
    String name = widget.name;
    User myself = widget.user;
    return Scaffold(
      appBar: AppBar(
        title: Text("Info"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Text(
              "${id} : ${name}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: RaisedButton(
                    child: Text("TODOS"),
                    // onPressed: () {
                    //   Navigator.pushReplacement(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) =>
                    //           TodoScreen(id: id, name: name, user: myself),
                    //     ),
                    //   );
                    // },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: RaisedButton(
                    child: Text("POST"),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: RaisedButton(
                    child: Text("ALBUMS"),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: RaisedButton(
                    child: Text("Back"),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Friendpage(user: myself),
                        ),
                      );
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}