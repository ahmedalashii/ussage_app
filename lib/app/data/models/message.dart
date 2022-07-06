import '../../../constants/exports.dart';
import 'user.dart';

class Message {
  late String id;
  final DateTime sendingTime;
  final String text;
  final User sender;
  Size size;
  Message({
    required this.sendingTime,
    required this.text,
    required this.sender,
    this.id = "0",
    this.size = const Size(0, 0),
  });

  Map<String, dynamic> toJSON() {
    Map<String, dynamic> map = <String, dynamic>{};
    map["sendingTime"] = sendingTime;
    map["text"] = text;
    map["sender"] = sender.toJSON();
    return map;
  }

  Message fromJSON(Map<String, dynamic> json) {
    return Message(
      id: json["id"],
      sendingTime: json["sendingTime"],
      text: json["text"],
      sender: json["sender"],
    );
  }
}
