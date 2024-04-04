import 'package:equatable/equatable.dart';
import 'package:start_date/models/message_model.dart';

class Chat extends Equatable {
  final int id;
  final List<String> userIds;
  final List<Message> messages;

  const Chat({
    required this.id,
    required this.userIds,
    required this.messages,
  });

  @override
  List<Object?> get props => [
        id,
        userIds,
        messages,
      ];

  factory Chat.fromJson(
    Map<String, dynamic> json, {
    String? id,
  }) {
    List<String> userIds =
        (json["userIds"] as List).map((userId) => userId as String).toList();
    List<Message> messages = (json["messages"] as List)
        .map((message) => Message.fromJson(message))
        .toList();

    messages.sort((a, b) {
      return b.dateTime.compareTo(a.dateTime);
    });

    return Chat(
      id: id ?? json["id"],
      userIds: userIds,
      messages: messages,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "userIds": userIds,
      "messages": messages,
    };
  }
}
