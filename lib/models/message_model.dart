
import 'dart:convert';

class MessageModel {
    List<Detail> detail;

    MessageModel({
        required this.detail,
    });

    factory MessageModel.fromJson(String str) => MessageModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory MessageModel.fromMap(Map<String, dynamic> json) => MessageModel(
        detail: List<Detail>.from(json["detail"].map((x) => Detail.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "detail": List<dynamic>.from(detail.map((x) => x.toMap())),
    };
}

class Detail {
    List<dynamic> loc;
    String msg;
    String type;

    Detail({
        required this.loc,
        required this.msg,
        required this.type,
    });

    factory Detail.fromJson(String str) => Detail.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Detail.fromMap(Map<String, dynamic> json) => Detail(
        loc: List<dynamic>.from(json["loc"].map((x) => x)),
        msg: json["msg"],
        type: json["type"],
    );

    Map<String, dynamic> toMap() => {
        "loc": List<dynamic>.from(loc.map((x) => x)),
        "msg": msg,
        "type": type,
    };
}