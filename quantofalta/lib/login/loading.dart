import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quantofalta/login/login_auth.dart';
//import 'login_auth.dart';
import '../models/Usuario.dart';
class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
    Usuario usuario = Usuario();
   LoginAuth loginAuth = LoginAuth();
  @override
   void initState()   {
      
      loginAuth.verificarLogin(usuario, context);
      super.initState();
      
    }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SpinKitThreeBounce(color: Colors.blue[800]),
            ],
          ) ,
    );
  }
}