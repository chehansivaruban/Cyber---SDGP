import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String _name, _email, _password;

  checkAuthentication() async {
    _auth.authStateChanges().listen((user) async {
      if (user != null) {
        Navigator.pushReplacementNamed(context, "/");
      }
    });
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentication();
  }

  signUp() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

// this one 
      try {
        UserCredential user = await _auth.createUserWithEmailAndPassword(
            email: _email, password: _password);
        if (user != null) {
          // UserUpdateInfo updateuser = UserUpdateInfo();
          // updateuser.displayName = _name;
          //  user.updateProfile(updateuser);
          await _auth.currentUser!.updateProfile(displayName: _name);
          // await Navigator.pushReplacementNamed(context,"/") ;

        }
      } catch (e) {

        showError(e.toString());
        print(e);
      }
    }
  }

  showError(String errormessage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('ERROR'),
            content: Text(errormessage),
            actions: <Widget>[
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // appBar: AppBar(),
      body: Material(
        type: MaterialType.transparency,
        child:
        Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors:  [Color.fromARGB(255, 0, 148, 255), Color.fromARGB(255, 0, 255, 163)] //top bottom color
          )
      ),
      child:Column(
        children: <Widget>[
          Flexible(
            child:FractionallySizedBox(
              heightFactor: 1.0,
              widthFactor: 1.0,
              child: Container(
                //color: Colors.amber,
                child: LayoutBuilder(
                  builder: (context, constraints){
                    //final height = constraints.maxHeight - kToolbarHeight;
                    bool resultbool = false;
                    final width = constraints.maxWidth;
                    return
                    SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            // Container(
            //   height: 400,
            //   child: Image(
            //     image: AssetImage("images/login.jpg"),
            //     fit: BoxFit.contain,
            //   ),
            // ),
            Container(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 100),
                    Container(
                      child: TextFormField(
                          validator: (input) {
                            if (input!.isEmpty) return 'Enter Name';
                          },
                          decoration: InputDecoration(
                            labelText: 'Name',
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white),
                                            borderRadius: BorderRadius.circular(50),
                            )
                          ),
                          onSaved: (input) => _name = input!),
                    ),
                    SizedBox(height: 20),
                    Container(
                      child: TextFormField(
                          validator: (input) {
                            if (input!.isEmpty) return 'Enter Email';
                          },
                          decoration: InputDecoration(
                              labelText: 'Email',
                              prefixIcon: Icon(Icons.email),
                              border: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white),
                                            borderRadius: BorderRadius.circular(50),
                            )),
                          onSaved: (input) => _email = input!),
                    ),
                    SizedBox(height: 20),
                    Container(
                      child: TextFormField(
                          validator: (input) {
                            if (input!.length < 6)
                              return 'Provide Minimum 6 Character';
                          },
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock),
                            border: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white),
                                            borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          obscureText: true,
                          onSaved: (input) => _password = input!),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      //padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
                      onPressed: signUp,
                      child: Text('SignUp',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold)),
                      //color: Colors.orange,
                     // shape: RoundedRectangleBorder(
                      //  borderRadius: BorderRadius.circular(20.0),
                      //,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
                    













                  }
                )
              )
            )
          )
        ]
      )
      )
      )
      );
  }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
    
    
    
    
//     Scaffold(
//         body: 
//     );
//   }
// }