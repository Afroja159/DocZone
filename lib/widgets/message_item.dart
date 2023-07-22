import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../auth/auth_service.dart';
import '../models/message_model.dart';

class MessageItem extends StatelessWidget {
  final MessageModel messageModel;
  const MessageItem({Key? key, required this.messageModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd-MM-yyyy - HH:mm'); // Define the date format

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: messageModel.userUid ==
                AuthService.user!.uid ? CrossAxisAlignment.end :
            CrossAxisAlignment.start,
            children: [
              Text("Send By ${messageModel.userName}", style: TextStyle(color: Colors.blue, fontSize: 12),),
              Text( dateFormat.format(messageModel.timestamp.toDate()),
                style: TextStyle(color: Colors.grey, fontSize: 12),),
              Text(messageModel.msg, style: TextStyle(color: Colors.black, fontSize: 14), textAlign: TextAlign.justify,),

            ],
          ),
        ),
      ),
    );
  }
}
