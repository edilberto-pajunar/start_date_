import 'package:equatable/equatable.dart';

class Partner extends Equatable {
  final String userId;
  final String partnerId;
  final String generatedCode;
  final bool isTaken;

  const Partner({
    required this.userId,
    required this.partnerId,
    required this.generatedCode,
    this.isTaken = false,
  });

  @override
  List<Object> get props => [
        userId,
        partnerId,
        generatedCode,
        isTaken,
      ];

  static Partner fromJson(Map json) {
    return Partner(
      userId: json["userId"],
      partnerId: json["partnerId"],
      generatedCode: json["generatedCode"],
      isTaken: json["isTaken"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "userId": userId,
      "partnerId": partnerId,
      "generatedCode": generatedCode,
      "isTaken": isTaken,
    };
  }

  static const Partner empty = Partner(
    userId: "",
    partnerId: "",
    generatedCode: "",
    isTaken: false,
  );

  Partner copyWith({
    String? userId,
    String? partnerId,
    String? generatedCode,
    bool? isTaken,
  }) {
    return Partner(
      userId: userId ?? this.userId,
      partnerId: partnerId ?? this.partnerId,
      generatedCode: generatedCode ?? this.generatedCode,
      isTaken: isTaken ?? this.isTaken,
    );
  }
}
