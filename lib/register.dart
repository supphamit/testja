import 'package:flutter/material.dart';
import 'register.dart';
import 'home.dart';
import 'model/user.dart';
class Register extends StatefulWidget {
  @override
  LoginpageState createState() {
    return LoginpageState();
  }
}


class LoginpageState extends State<Register> {
   final _formkey = GlobalKey<FormState>();
  TextEditingController userid = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController password = TextEditingController();

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.parse(s, (e) => null) != null;
  }

  //new instance
  UserProvider userProvider = UserProvider();
  List<User> currentUsers = List();
   @override
   void initState() {
    super.initState();
    userProvider.open('member.db').then((r) {
      getUsers();
    });
  }

  void getUsers() {
    userProvider.getUsers().then((r) {
      setState(() {
        currentUsers = r;
      });
    });
  }

  void deleteUsers() {
    userProvider.deleteUsers().then((r) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text("Register"),
        centerTitle:true,
        actions: <Widget>[
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
            key: _formkey,
            child: ListView(
              children: <Widget>[
              Container(
              padding: EdgeInsets.fromLTRB(65.0, 20.0, 60.0, 0.0),
            ),
              Container(
                margin: const EdgeInsets.only(top: 70),
                  child: TextFormField(
                controller: userid,
                decoration: InputDecoration(
                  labelText: "Userid",
                ),
                validator: (value) {
                  if (value.isEmpty) return "Userid is required";
                  if (value.length < 6 || value.length > 12)
                    return "Userid ไม่ถูกต้อง";
                },
              )
              ),
              Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: TextFormField(
                controller: name,
                decoration: InputDecoration(
                  labelText: "Name",
                  hintText: "Name",
                ),
                validator: (value) {
                  int count = 0;
                  if (value.isEmpty) return "Name ไม่ถูกต้อง";
                  for (int i = 0; i < value.length; i++) {
                    if (value[i] == " ") {
                      count = 1;
                    }
                  }
                  if (count == 0) {
                    return "Please fill name correctly";
                  }
                },
              )
              ),
              
              Container(
                  margin: const EdgeInsets.only(top: 20),
                  child:  TextFormField(
                controller: age,
                decoration: InputDecoration(
                  labelText: "Age",
                ),
                validator: (value) {
                  if (value.isEmpty) return "Age is required";
                  if (!isNumeric(value)) return "Age incorrect";
                  if (int.parse(value) < 10 || int.parse(value) > 80)
                    return "Age ไม่ถูกต้อง";
                },
              )
              ),

                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: TextFormField(
                controller: password,
                decoration: InputDecoration(
                  labelText: "Password",
                ),
                obscureText: true,
                validator: (value) {
                  if (value.isEmpty && value.length < 6)
                    return "Password ไม่ถูกต้อง";
                },
              )
              ),
              Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: RaisedButton(
                    child: Text('REGISTER NEW ACCOUNT'),
                    color: Theme.of(context).accentColor,
                    splashColor: Colors.blue,
                    onPressed: () {
                        bool check = true;
                        if (_formkey.currentState.validate()) {
                          if (currentUsers.length == 0) {
                            User user = User(
                                userid: userid.text,
                                name: name.text,
                                age: age.text,
                                password: password.text);
                            userProvider.insert(user).then((r) {
                              Navigator.pushReplacementNamed(context, '/');
                            });
                          } else {
                            for (int i = 0; i < currentUsers.length; i++) {
                              if (userid.text == currentUsers[i].userid) {
                                check = false;
                                break;
                              }
                            }
                            if (check) {
                              User user = User(
                                  userid: userid.text,
                                  name: name.text,
                                  age: age.text,
                                  password: password.text);
                              userProvider.insert(user).then((r) {
                              });
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: Text(
                                          'userid duplicate, please fill new userid'),
                                    );
                                  });
                            }
                          }
                        }
                      },
                  )),
            ])),
      ),
    );
  }

 
}