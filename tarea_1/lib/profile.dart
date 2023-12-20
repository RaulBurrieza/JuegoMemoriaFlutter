import 'dart:js_interop_unsafe';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tarea_1/game.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController usernameController = TextEditingController();
  String username = "";
  

  void setUsername(String username)async{  
  SharedPreferences prefs = await SharedPreferences.getInstance() ;
  prefs.setString('username', username);
  print("Nombre gaurdado" + prefs.get("username").toString());
}
 @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.purple,
      title: const Text("Perfil"),
    ),
    body: Center(
      child: Padding(
        padding: EdgeInsets.all(70.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              "Introduce tu nombre de usuario",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.purple,
                fontSize: 20.0,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(onChanged:(String text){username = text; print(text);setUsername(this.username);}),
            ), 
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Game()),
                );
              },
              child: const Text(
                "Guardar nombre usuario",
                style: TextStyle(color: Colors.purple),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
}