import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doczone/dbHelper/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../auth/auth_service.dart';
import '../models/message_model.dart';

final chatProvider = ChangeNotifierProvider((ref) => ChatProvider());

class ChatProvider extends ChangeNotifier {
  List<MessageModel> msgList = [];

  Future<void> addMessage(String msg) async {
    final messageModel = MessageModel(
      msgId: DateTime.now().millisecondsSinceEpoch,
      userUid: AuthService.user!.uid,
      userImage: AuthService.user!.photoURL,
      userName: AuthService.user!.displayName,
      email: AuthService.user!.email!,
      msg: msg,
      timestamp: Timestamp.now(),
    );

    await DbHelper.addMsg(messageModel);
    msgList.insert(0, messageModel); // Insert the sent message at the beginning of the list
    notifyListeners();
  }

  void getChatRoomMessages() {
    DbHelper.getAllChatRoomMessages().listen((snapshot) {
      msgList = List.generate(
          snapshot.docs.length,
              (index) => MessageModel.fromMap(snapshot.docs[index].data()));
      notifyListeners();
    });
  }
}
