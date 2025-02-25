import 'dart:convert';

class FriendsModel {
    List<Friend> friends;

    FriendsModel({
        required this.friends,
    });

    factory FriendsModel.fromJson(String str) => FriendsModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory FriendsModel.fromMap(Map<String, dynamic> json) => FriendsModel(
        friends: List<Friend>.from(json["friends"].map((x) => Friend.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "friends": List<dynamic>.from(friends.map((x) => x.toMap())),
    };
}

class Friend {
    String username;
    String image;
    String bio;

    Friend({
        required this.username,
        required this.image,
        required this.bio,
    });

    factory Friend.fromJson(String str) => Friend.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Friend.fromMap(Map<String, dynamic> json) => Friend(
        username: json["username"],
        image: json["image"],
        bio: json["bio"],
    );

    Map<String, dynamic> toMap() => {
        "username": username,
        "image": image,
        "bio": bio,
    };
}
