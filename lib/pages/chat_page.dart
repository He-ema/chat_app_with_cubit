import 'package:chatapp/constants.dart';
import 'package:chatapp/models/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/chat_bubble.dart';
import 'cubits/chat_cubit/chat_cubit.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});
  static String id = 'ChatPage';
  String fieldData = '';
  final _controller = ScrollController();
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String email = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: KPrimaryColor,
        centerTitle: true,
        title: Row(mainAxisSize: MainAxisSize.min, children: [
          Image.asset(
            KLogo,
            width: 80,
            height: 80,
          ),
          Text('Chat'),
        ]),
      ),
      body: Column(children: [
        Expanded(
          child: BlocBuilder<ChatCubit, ChatState>(
            builder: (context, state) {
              var messagesList =
                  BlocProvider.of<ChatCubit>(context).messagesList;
              return ListView.builder(
                  reverse: true,
                  controller: _controller,
                  itemCount: messagesList.length,
                  itemBuilder: (context, index) =>
                      messagesList[index].id == email
                          ? ChatBubble(
                              message: messagesList[index],
                            )
                          : ChatBubbleForFriend(message: messagesList[index]));
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (data) {
              fieldData = data;
            },
            controller: controller,
            onSubmitted: (data) {
              if (!data.isEmpty) {
                BlocProvider.of<ChatCubit>(context)
                    .sendMessage(message: data, email: email);
                controller.clear();
                _controller.animateTo(0,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.fastOutSlowIn);
              } else {}
            },
            decoration: InputDecoration(
              hintText: 'Enter a message',
              suffixIcon: IconButton(
                  onPressed: () {
                    if (fieldData.isNotEmpty) {
                      BlocProvider.of<ChatCubit>(context)
                          .sendMessage(message: fieldData, email: email);
                      fieldData = '';
                      controller.clear();
                      _controller.animateTo(0,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.fastOutSlowIn);
                    } else {}
                  },
                  icon: Icon(Icons.send)),
              border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: KPrimaryColor),
                borderRadius: BorderRadius.circular(18),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.circular(18),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
