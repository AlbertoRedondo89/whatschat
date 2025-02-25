# whatschat

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

### IMPORTANTE
Para subir la api hemos usado render, como despues de un tiempo de inactividad el servidor se apaga automaticamente
te voy a explicar como puedes subir tu la api. una vez registrado en render, vas ha crear un proyecto y cuando te pida 
elegir de donde sacar la api pulsa github, este es el enlace del github de la api https://github.com/Felip-Torres/apiFac/tree/main,
creo que tendras que copiarlo ha tu github.
En los ajustes solo tienes que cambiar dos cosas, el build command por esta linea: pip install -r requirements.txt
y el start command por esta: uvicorn app:app --host 0.0.0.0 --port 10000
con esto simplemente seria darle a deploy y esperar ha que te diga que esta listo en la consola de comandos.
Acuerdate de cambiar la direccion de la api por la tuya, en el main.
Para la base de datos usamos railway, pero ese nunca se desconecta.
