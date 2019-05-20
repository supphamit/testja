import 'package:flutter/material.dart';
import 'register.dart';
import 'home.dart';
import './model/friendjson.dart';
import 'model/user.dart';
import 'friendinfopage.dart';
class Friendpage extends StatefulWidget {
  final User user;
  Friendpage({Key key, this.user}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return FriendpageState();
  }
}

class FriendpageState extends State<Friendpage> {
  FriendProvider friendProvider = FriendProvider();
  @override
Widget listFriends(BuildContext context, AsyncSnapshot snapshot) {
    User myself = widget.user;
    List<Friend> friends = snapshot.data;
    return Expanded(
      child: ListView.builder(
        itemCount: friends.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: InkWell(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "${friends[index].id} : ${friends[index].name}",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                    SizedBox(height: 20),
                    Text(
                      friends[index].email,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 20),
                    Text(
                      friends[index].phone,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 20),
                    Text(
                      friends[index].website,
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FriendInfopage(
                            id: friends[index].id,
                            name: friends[index].name,
                            user: myself,
                          ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    User myself = widget.user;
    return Scaffold(
      appBar: AppBar(
        title: Text("Friend"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
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
                          builder: (context) => Homepage(user: myself),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            FutureBuilder(
              future: friendProvider
                  .loadDatas("https://jsonplaceholder.typicode.com/users"),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return listFriends(context, snapshot);
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            )
          ],
        ),
      ),
    );
  }

 
}