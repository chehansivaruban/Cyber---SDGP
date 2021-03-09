import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:solarex/screens/Homepage.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {


  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  String _email = '';
  String _password = '';

  checkAuthentification() async{

    
    _auth.authStateChanges().listen((User user) {
      if(user != null){
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
      }
    });

    @override
    void initState(){
        super.initState();
        this.checkAuthentification();


    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Container(

        child: Column(
          children: <Widget>[
            SizedBox(height: 130.0),
            Container(
              child: Form(
                key: _formKey,
                child: Column(


                  children: <Widget>[

                    SizedBox(height: 30.0),

                    Container(
                      child: TextFormField(
                        validator: (input)
                        {
                          if(input!.isEmpty){
                            return 'Enter Email';
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email)
                        ),
                        onSaved: (input) => _email = input!,

                      ),
                    ),
                    SizedBox(height: 30.0),

                    Container(
                      child: TextFormField(
                        validator: (input)
                        {
                          if(input!.isEmpty){
                            return 'Enter Email';
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock)
                        ),
                        obscureText: true,
                        onSaved: (input) => _password = input!,

                      ),
                    ),
                    SizedBox(height: 30.0),

                    Container(
                        margin: const EdgeInsets.fromLTRB(40, 0, 10, 0),

                        child: ElevatedButton(


                          onPressed: () { initState();},
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                            child: Text('LOGIN', style:TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),

                          ),

                          style: ElevatedButton.styleFrom( shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          ),),


                        )
                    ),

                  ],
                ),
              ),
            )


          ],
        ),
      ),
    );
  }
}
