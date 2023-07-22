import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/chat_provider.dart';
import '../widgets/message_item.dart';

class ChatRoomPage extends ConsumerStatefulWidget {
  const ChatRoomPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends ConsumerState<ChatRoomPage> {
  bool isFirst = true;
  final txtController = TextEditingController();
  final ScrollController _scrollController = ScrollController(); // Add a ScrollController

  @override
  void dispose() {
    txtController.dispose();
    _scrollController.dispose(); // Dispose of the ScrollController
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (isFirst) {
      ref.read(chatProvider).getChatRoomMessages(); // Use context.read instead of ref.read
      isFirst = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Chat Room'),
      ),
      body: Consumer(builder: (context, watch, _) {
        final provider = ref.read(chatProvider); // Use watch instead of ref.watch

        // Use a LayoutBuilder to get the available height for the ListView
        return LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    itemCount: provider.msgList.length,
                    controller: _scrollController, // Assign the ScrollController to the ListView
                    itemBuilder: (context, index) {
                      final messageModel = provider.msgList[index];
                      return MessageItem(messageModel: messageModel);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: txtController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            hintText: 'Type your message here',
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.send,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          if (txtController.text.isEmpty) return;
                          ref.read(chatProvider).addMessage(txtController.text); // Use context.read instead of ref.watch
                          txtController.clear();
                          // Scroll to the bottom when a new message is sent
                          _scrollController.animateTo(
                            0.0,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeOut,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      }),
    );
  }
}
