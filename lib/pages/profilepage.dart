import 'package:flutter/material.dart';
import 'package:whatschat/preferences/preferences.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Perfil')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 120,
            backgroundImage: AssetImage('assets/user_avatar.png'),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextFormField(
                  initialValue: Preferences.nombre,
                  onChanged: (value) {
                    Preferences.nombre = value;
                  },
                  decoration: InputDecoration(labelText: "Nombre", border: OutlineInputBorder()),
                ),
                SizedBox(height: 10),
                ElevatedButton(onPressed: () {}, child: Text('Guardar cambios')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}