import 'dart:ui';

import 'message.dart';

class UserField {
  static const String lastMessages = 'lastMessages';
}

class User {
  final String idUser;
  final String name, imageUrl, email;
  Map<String, Message> lastMessages = <String, Message>{};
  final bool connectionStatus;
  late bool isSaved;
  int noOfUnreadMessages;
  Size size;
  User({
    required this.idUser,
    required this.name,
    required this.email,
    required this.imageUrl,
    this.isSaved = false,
    this.size = const Size(0, 0),
    this.noOfUnreadMessages = 0,
    required this.lastMessages,
    this.connectionStatus = false,
  });

  Map<String, dynamic> lastMessagesToJSON() {
    Map<String, Map<String, dynamic>> tempLastMessages =
        <String, Map<String, dynamic>>{};
    lastMessages.forEach((String string, Message message) {
      tempLastMessages[string] = message.toJSON();
    });
    return tempLastMessages;
  }

  Map<String, dynamic> toJSON() {
    Map<String, dynamic> map = <String, dynamic>{};
    map["idUser"] = idUser;
    map["name"] = name;
    map["email"] = email;
    map["lastMessages"] = lastMessagesToJSON();
    map["imageUrl"] = imageUrl;
    map["isSaved"] = isSaved;
    map["noOfUnreadMessages"] = noOfUnreadMessages;
    map["connectionStatus"] = connectionStatus;
    return map;
  }

  static Map<String, Message> lastMessagesfromJSON(
      Map<String, dynamic> lastMessagesJSON) {
    Map<String, Message> lastMessages = <String, Message>{};
    (Map<String, Map<String, dynamic>>.from(lastMessagesJSON))
        .forEach((String string, Map<String, dynamic> message) {
      lastMessages[string] = Message.fromJSON(message);
    });

    return lastMessages;
  }

  static User fromJSON(Map<String, dynamic> json) {
    return User(
      idUser: json["idUser"],
      name: json["name"],
      email: json["email"],
      isSaved: json["isSaved"],
      noOfUnreadMessages: json["noOfUnreadMessages"],
      lastMessages: lastMessagesfromJSON(json["lastMessages"]),
      imageUrl: json["imageUrl"],
      connectionStatus: json["connectionStatus"],
    );
  }
}
