import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ussage_app/app/data/models/user.dart';

import '../data/models/message.dart';
import '../data/models/user.dart';

class FireStoreHelper {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // CRUD Users

  Future<bool> createUser({required User user}) async {
    return await _firestore
        .collection("Users")
        .doc(user.idUser)
        .set(user.toJSON())
        .then((value) {
      return true;
    }).catchError((error) => false);
  }

  Stream<QuerySnapshot> readAllUsers() async* {
    yield* _firestore.collection("Users").snapshots();
  }

  Future<User?> getUser(String userId) async {
    CollectionReference<Map<String, dynamic>> collection =
        _firestore.collection("Users");
    DocumentSnapshot<Map<String, dynamic>> userDocumentSnapshot =
        await collection.doc(userId).get();
    if (userDocumentSnapshot.exists) {
      Map<String, dynamic>? userData = userDocumentSnapshot.data();
      if (userData != null) {
        User user = User.fromJSON(userData);
        return user;
      }
    }
    return null;
  }

  Future<bool> updateUser({required User user}) {
    return _firestore
        .collection("Users")
        .doc(user.idUser)
        .update(user.toJSON())
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<bool> deleteUser({required User user}) {
    return _firestore
        .collection("Users")
        .doc(user.idUser)
        .delete()
        .then((value) => true)
        .catchError((error) => false);
  }

  // CRUD Messages
  Future<void> createMessage(
      {required String receiverIdUser, required Message message}) async {
    QuerySnapshot snapshot = await _firestore
        .collection("Chats/$receiverIdUser-${message.senderIdUser}/messages")
        .limit(1)
        .get();
    final CollectionReference<Map<String, dynamic>> refMessage;
    if (snapshot.size != 0) {
      refMessage = _firestore
          .collection("Chats/$receiverIdUser-${message.senderIdUser}/messages");
    } else {
      refMessage = _firestore
          .collection("Chats/${message.senderIdUser}-$receiverIdUser/messages");
    }
    await refMessage.add(message.toJSON());
    final refUsers = FirebaseFirestore.instance.collection('Users');
    User? senderUser = await getUser(message.senderIdUser);
    senderUser!.lastMessages[receiverIdUser] = message;
    User? receiverUser = await getUser(receiverIdUser);
    receiverUser!.lastMessages[message.senderIdUser] = message;
    await refUsers
        .doc(message.senderIdUser)
        .update({UserField.lastMessages: senderUser.lastMessagesToJSON()});
    await refUsers
        .doc(receiverIdUser)
        .update({UserField.lastMessages: receiverUser.lastMessagesToJSON()});
  }

  Stream<QuerySnapshot> readMessages(
      {required String receiverIdUser, required String senderIdUser}) async* {
    QuerySnapshot snapshot = await _firestore
        .collection("Chats/$receiverIdUser-$senderIdUser/messages")
        .limit(1)
        .get();
    if (snapshot.size != 0) {
      yield* _firestore
          .collection("Chats/$receiverIdUser-$senderIdUser/messages")
          .orderBy(MessageField.createdAt, descending: true)
          .snapshots();
    } else {
      // if it's equal to zero it means that the first collection is absent so it's another one ..
      yield* _firestore
          .collection("Chats/$senderIdUser-$receiverIdUser/messages")
          .orderBy(MessageField.createdAt, descending: true)
          .snapshots();
    }
  }

  // Future<bool> deleteMessage({required Message message}) async {
  //   return _firestore
  //       .collection("Messages")
  //       .doc("dTqqJZKP7bXpU1gxerTd")
  //       .delete()
  //       .then((value) => true)
  //       .catchError((error) => false);
  // }
}
