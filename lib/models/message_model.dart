import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class Message extends Equatable {
  final String senderId;
  final String receiverId;
  final String message;
  final DateTime dateTime;
  final String timeString;

  const Message({
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.dateTime,
    required this.timeString,
  });

  factory Message.fromJson(
    Map<String, dynamic> json, {
    String? id,
  }) {
    return Message(
      senderId: json["senderId"],
      receiverId: json["receiverId"],
      message: json["message"],
      dateTime: json["dateTime"],
      timeString: DateFormat("HH:mm")
          .format((json["timeString"] as Timestamp).toDate()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "senderId": senderId,
      "receiverId": receiverId,
      "message": message,
      "dateTime": dateTime,
    };
  }

  @override
  List<Object?> get props => [
        senderId,
        receiverId,
        message,
        dateTime,
        timeString,
      ];

  static List<Message> messages = [
    Message(
      senderId: "1",
      receiverId: "2",
      message: "Hey, how are you?",
      dateTime: DateTime.now(),
      timeString: DateFormat("jm").format(DateTime.now()),
    ),
    // Message(
    //   senderId: 2,
    //   receiverId: 1,
    //   message: "I'm good, thank you.",
    //   dateTime: DateTime.now(),
    //   timeString: DateFormat("jm").format(DateTime.now()),
    // ),
    // Message(
    //   senderId: 1,
    //   receiverId: 2,
    //   message: "I'm good, as well. Thank you.",
    //   dateTime: DateTime.now(),
    //   timeString: DateFormat("jm").format(DateTime.now()),
    // ),
  ];
}
