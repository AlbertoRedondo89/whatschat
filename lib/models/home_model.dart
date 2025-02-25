import 'dart:convert';

class HomeModel {
    List<Contact> contacts;

    HomeModel({
        required this.contacts,
    });

    factory HomeModel.fromJson(String str) => HomeModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory HomeModel.fromMap(Map<String, dynamic> json) => HomeModel(
        contacts: List<Contact>.from(json["contacts"].map((x) => Contact.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "contacts": List<dynamic>.from(contacts.map((x) => x.toMap())),
    };
}

class Contact {
    String username;
    String imageUrl;
    String message;
    String time;

    Contact({
        required this.username,
        required this.imageUrl,
        required this.message,
        required this.time,
    });

    factory Contact.fromJson(String str) => Contact.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Contact.fromMap(Map<String, dynamic> json) => Contact(
        username: json["username"],
        imageUrl: json["imageUrl"],
        message: json["message"],
        time: json["time"],
    );

    Map<String, dynamic> toMap() => {
        "username": username,
        "imageUrl": imageUrl,
        "message": message,
        "time": time,
    };
}
