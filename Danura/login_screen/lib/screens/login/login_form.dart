import 'package:flutter/material.dart';
import 'package:login_screen/screens/register/register_screen.dart';
//import 'package:login_screen/screens/register/register_screen.dart';
import 'package:login_screen/widgets/gradient_button.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();


  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        child: Column(
          children: <Widget>[
          TextFormField(
            autovalidateMode: AutovalidateMode.always, controller: _emailController,
            decoration: InputDecoration(
              icon: Icon(Icons.email),
              labelText: "Email",
            ),
            keyboardType: TextInputType.emailAddress,

          ),
            TextFormField(
              autovalidateMode: AutovalidateMode.always, controller: _passwordController,
              decoration: InputDecoration(
                icon: Icon(Icons.lock),
                labelText: "Password",
              ),
              obscureText: true,

            ),
            SizedBox(
              height: 10,
            ),
            GradientButton(
              width: 150,
              height: 45,
              onPressed: () {},
              text: Text('LogIn',style:TextStyle(
                color: Colors.white,
              ),
              ),
              icon: Icon(
                  Icons.arrow_forward,
                  color: Colors.white),
            ),
            SizedBox(
              height: 10,
            ),
            GradientButton(
              width: 150,
              height: 45,
              onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder:(_) {
                  return RegisterScreen();
                }));

                },



              text: Text('Register',
                style:TextStyle(
                color: Colors.white,
              ),
              ),
                icon: Icon(
                  Icons.arrow_forward,
                  color: Colors.white),

            ),
          ],
        ),
      ),
    );
  }
}
