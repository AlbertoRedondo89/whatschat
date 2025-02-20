import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatschat/preferences/preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      _showConfirmationDialog(File(pickedFile.path));
    }
  }

  void _showConfirmationDialog(File image) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Confirmar imagen"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 120,
                backgroundImage: FileImage(image),
              ),
              SizedBox(height: 10),
              Text("¿Quieres usar esta foto como imagen de perfil?"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancelar"),
            ),
            TextButton(
              onPressed: () async {
                await Preferences.setImage(image);
                setState(() {
                  
                });
                Navigator.pop(context);
              },
              child: Text("Aceptar"),
            ),
          ],
        );
      },
    );
  }

  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text("Tomar foto"),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text("Elegir de la galería"),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Perfil')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: _showImagePickerOptions, // Muestra opciones
            child: CircleAvatar(
              radius: 120,
              backgroundImage: Preferences.image != null
                  ? FileImage(Preferences.image!)
                  : AssetImage('assets/images/user_avatar.png') as ImageProvider,
            ),
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
                  decoration: InputDecoration(
                      labelText: "Nombre", border: OutlineInputBorder()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
