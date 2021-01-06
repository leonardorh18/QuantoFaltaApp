


import 'package:quantofalta/login/Login.dart';
import 'package:quantofalta/models/Usuario.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'telas/AddMateria.dart';
import 'telas/Materias.dart';
import 'telas/EditMateria.dart';

class Home extends StatefulWidget {
   Usuario usuario;
  int indexAtual = 0;
  Home({this.usuario, this.indexAtual});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
   
  


  @override
   void initState(){

     super.initState();
    //ads futuras
   }
   @override
    void dispose() {
    //ads futuras
    
    super.dispose();
  }
  Widget build(BuildContext context) {
  
  List<Widget> listaTelas = [
      Materias(widget.usuario),
      AddMateria(widget.usuario),
      EditMateria(widget.usuario),
  ];

    return Scaffold(
      resizeToAvoidBottomInset: false, 
      appBar: AppBar(title: Text('Bem vindo, '+widget.usuario.nome, 
            style: TextStyle(color: Colors.white),
            ),
       backgroundColor: Colors.blue[700], 
       automaticallyImplyLeading: false,
      iconTheme: IconThemeData(color: Colors.redAccent),
      actions: [
         Padding(
          padding: EdgeInsets.only(right: 20.0),
          child: GestureDetector(
            onTap: () {
                      FirebaseAuth auth = FirebaseAuth.instance;
                      auth.signOut();
                      Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeftWithFade, child: Login()));
            },
            child: Icon(
              Icons.exit_to_app,
              size: 26.0,
            ),
          )
    ),
      ],
      
      ),
      body: Column(children: [

          listaTelas[widget.indexAtual]
      ],),

          bottomNavigationBar: BottomNavigationBar(
          currentIndex: widget.indexAtual,
          onTap: (indice){

            setState(() {
              widget.indexAtual = indice;
            }
            );

          },
          type: BottomNavigationBarType.fixed,
          fixedColor: Colors.red,
          iconSize: 30,
          
          items: [
            BottomNavigationBarItem(
              title: Text("Materias"),
              icon: Icon(Icons.library_books),
            ),
            BottomNavigationBarItem(
              title: Text("Adicionar Materia"),
              icon: Icon(Icons.plus_one),
            ),

            BottomNavigationBarItem(
              title: Text("Editar"),
              icon: Icon(Icons.edit),
            ),
            
            

          ]

      ),
        
      
    );
    
  }
}