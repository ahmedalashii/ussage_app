import '../../../constants/exports.dart';
import 'message.dart';
import 'user.dart';

class Chat {
  late String id;
  final List<Message> messages;
  final User user;
  int noOfUnreadMessages;
  bool isRead, isSaved;
  Size size;
  Chat({
    required this.user,
    required this.messages,
    required this.noOfUnreadMessages,
    this.isRead = true,
    required this.id,
    this.isSaved = false,
    required this.size,
  });

  Map<String, dynamic> toJSON() {
    Map<String, dynamic> map = <String, dynamic>{};
    map["messages"] = messages;
    map["user"] = user;
    map["noOfUnreadMessages"] = noOfUnreadMessages;
    map["isRead"] = isRead;
    map["isSaved"] = isSaved;
    return map;
  }
}
