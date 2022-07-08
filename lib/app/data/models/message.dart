import 'package:ussage_app/app/core/helper_functions.dart';

import '../../../constants/exports.dart';

class MessageField {
  static const String createdAt = 'createdAt';
}

class Message {
  late String senderIdUser;
  late String receiverIdUser;
  final DateTime createdAt;
  final String text;
  bool isRead;
  Size size;
  Message({
    required this.senderIdUser,
    required this.receiverIdUser,
    required this.createdAt,
    required this.text,
    this.isRead = false,
    this.size = const Size(0, 0),
  });

  Map<String, dynamic> toJSON() {
    Map<String, dynamic> map = <String, dynamic>{};
    map["senderIdUser"] = senderIdUser;
    map["receiverIdUser"] = receiverIdUser;
    map["createdAt"] = createdAt.toIso8601String();
    map["text"] = text;
    map["isRead"] = isRead;
    return map;
  }

  static Message fromJSON(Map<String, dynamic> json) {
    return Message(
      isRead: json["isRead"],
      senderIdUser: json["senderIdUser"],
      receiverIdUser: json["receiverIdUser"],
      createdAt: (json["createdAt"].runtimeType == String)
          ? DateTime.parse(json['createdAt'] as String)
          : toDateTime(json["createdAt"])!,
      text: json["text"],
    );
  }
}
