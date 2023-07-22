import 'package:bloc/bloc.dart';
import 'package:chatapp/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../../../constants.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  List<Message> messagesList = [];
  CollectionReference messages =
      FirebaseFirestore.instance.collection(KMessagesCollection);
  void sendMessage({required String message, required String email}) {
    messages.add({
      KMessage: message,
      KCreatedAt: DateTime.now(),
      KId: email,
    });
  }

  void getMessages() {
    messages.orderBy(KCreatedAt, descending: true).snapshots().listen((event) {
      messagesList.clear();
      for (var doc in event.docs) {
        messagesList.add(Message.FromJson(doc));
      }
      emit(ChatSuccess(messages: messagesList));
    });
  }
}
