import 'package:flutter/material.dart';
import 'package:login_screen/widgets/curved_widget.dart';



class RegisterForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xfff2cbd0), Color(0xfff4ced9)] //add two colors
            )


        ),
        child: SingleChildScrollView(
          child: Stack (
            children: <Widget>[
              CurvedWidget(
                child: Container(
                  padding: const EdgeInsets.only(top:100,left:50),
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.white ,Colors.white.withOpacity(0.4)] //add two colors
                    ),
                  ),
                  child: Text('Login', style: TextStyle(
                    fontSize: 40,
                    color: Color(0xff6a515e),
                  ),
                  ),
                ),

              ),
              Container(
                margin: const EdgeInsets.only(top: 230),
                child:RegisterForm(),
              )

            ],
          ),
        ),
      ),
    );

  }
}
