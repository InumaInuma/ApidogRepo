// To parse this JSON data, do
//
//     final ModelResponse = ModelResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ModelResponse ModelResponseFromJson(String str) =>
    ModelResponse.fromJson(json.decode(str));

String ModelResponseToJson(ModelResponse data) => json.encode(data.toJson());

class ModelResponse {
  ModelResponse({
    required this.message,
    required this.status,
  });

  Map<String, List<String>> message;
  String status;

  factory ModelResponse.fromJson(Map<String, dynamic> json) {
    return ModelResponse(
      message: Map.from(json["message"]).map((k, v) =>
          MapEntry<String, List<String>>(
              k, List<String>.from(v.map((x) => x)))),
      status: json["status"],
    );
  }

  Map<String, dynamic> toJson() => {
        "message": Map.from(message).map((k, v) =>
            MapEntry<String, dynamic>(k, List<dynamic>.from(v.map((x) => x)))),
        "status": status,
      };
}
