import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatschat/preferences/preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  // Método para seleccionar una imagen desde la cámara o la galería
  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      _showConfirmationDialog(File(pickedFile.path));
    }
  }

  // Muestra un diálogo de confirmación para la imagen seleccionada
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
              onPressed: () => Navigator.pop(context), // Cierra el diálogo
              child: Text("Cancelar"),
            ),
            TextButton(
              onPressed: () async {
                await Preferences.setImage(image); // Guarda la imagen en las preferencias
                setState(() {
                  // Actualiza el estado para reflejar la nueva imagen
                });
                Navigator.pop(context); // Cierra el diálogo
              },
              child: Text("Aceptar"),
            ),
          ],
        );
      },
    );
  }

  // Muestra opciones para seleccionar una imagen desde la cámara o la galería
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
                  Navigator.pop(context); // Cierra el modal
                  _pickImage(ImageSource.camera); // Selecciona una imagen desde la cámara
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text("Elegir de la galería"),
                onTap: () {
                  Navigator.pop(context); // Cierra el modal
                  _pickImage(ImageSource.gallery); // Selecciona una imagen desde la galería
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
            onTap: _showImagePickerOptions, // Muestra opciones para seleccionar una imagen
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
                    Preferences.nombre = value; // Actualiza el nombre en las preferencias
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