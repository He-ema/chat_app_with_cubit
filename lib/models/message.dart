import 'package:chatapp/constants.dart';

class Message {
  final String message;
  String id;
  Message(this.message, this.id);

  factory Message.FromJson(JsonData) {
    return Message(JsonData[KMessage], JsonData[KId]);
  }
}
