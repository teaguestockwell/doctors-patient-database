import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../constant.dart';
import '../widgets/but.dart';
import 'profile_search.dart';




class Auth extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  String email = '';
  String pass = '';
  Widget signInPage;
  Image img = Image.asset('assets/0.png');

  @override
  void initState(){
    super.initState();
    
    signInPage =  Scaffold(body:Padding(
      padding: const EdgeInsets.all(10.0),
      child: Center(child: ListView(children:[
        Center(
          child: Text(
            'LPG Patient Care',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
          )
        ),

        Container(
          width: 500,
          height: 500,
          child: img,
        ),

        TextField(
          decoration: InputDecoration(labelText: 'email'),
          onChanged: (x) => email = x,
        ),

        TextField(
          decoration: InputDecoration(labelText: 'password'),
          onChanged: (x) => pass = x
        ),
      
        But(text:'login',
        onpress: login,
        ),

      ])),
    ));
  }

  void login() async {
    try{
      if(email == ''){email = ' ';}
      if(pass == ''){pass = ' ';}
      await FirebaseAuth.instance
      .signInWithEmailAndPassword(email: email, password: pass).timeout(Duration(seconds: 10));
    // ignore: avoid_catches_without_on_clauses
    }catch(_){showSnack();}
  }

  void showSnack(){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Container(
      height: Snackz.y, 
      child: Center(
        child: Text('Login Error',style: Snackz.ts,
  )))));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User user = snapshot.data;
          if (user == null) {
            return signInPage;
          }
          return ProfileSearch();
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}