import 'dart:convert';

NotFoundModel notFoundModelFromJson(String str) => NotFoundModel.fromJson(json.decode(str));

String notFoundModelToJson(NotFoundModel data) => json.encode(data.toJson());

class NotFoundModel {
  NotFoundModel({
    required this.title,
    required this.message,
    required this.resolution,
  });

  final String title;
  final String message;
  final String resolution;

  factory NotFoundModel.fromJson(Map<String, dynamic> json) => NotFoundModel(
    title: json["title"],
    message: json["message"],
    resolution: json["resolution"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "message": message,
    "resolution": resolution,
  };
}
