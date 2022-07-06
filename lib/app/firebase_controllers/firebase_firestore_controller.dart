import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ussage_app/app/data/models/user.dart';

import '../data/models/chat.dart';
import '../data/models/message.dart';

class FireStoreController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // CRUD Chat
  Future<bool> createChat({required Chat chat}) async {
    return await _firestore
        .collection("Chats")
        .add(chat.toJSON())
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<bool> updateChat({required Chat chat}) async {
    return _firestore
        .collection("Chats")
        .doc(chat.id)
        .update(chat.toJSON())
        .then((value) => true)
        .catchError((error) => false);
  }

  Stream<QuerySnapshot> readChats() async* {
    yield* _firestore.collection("Chats").snapshots();
  }

  Future<bool> deleteChat({required String path}) async {
    return _firestore
        .collection("Chats")
        .doc(path)
        .delete()
        .then((value) => true)
        .catchError((error) => false);
  }

  // CRUD Messages
  Future<bool> createMessage({required Message message}) async {
    return await _firestore
        .collection("Messages")
        .doc(message.id)
        .set(message.toJSON())
        .then((value) => true)
        .catchError((error) {
      log(error.toString());
      return false;
    });
  }

  Future<bool> createUser({required User user}) async {
    return await _firestore
        .collection("Users")
        .doc(user.id.toString())
        .set(user.toJSON())
        .then((value) {
      log("Creation of User is completed");
      return true;
    }).catchError((error) => false);
  }

  Future<bool> deleteMessage() async {
    return _firestore
        .collection("Messages")
        .doc("dTqqJZKP7bXpU1gxerTd")
        .delete()
        .then((value) => true)
        .catchError((error) => false);
  }
}
