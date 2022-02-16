import 'package:json_annotation/json_annotation.dart';

part 'base_response.g.dart';

@JsonSerializable(includeIfNull: false, genericArgumentFactories: true)
class BaseResponse<T> {
  @JsonKey(name: 'data')
  final T? data;

  BaseResponse({this.data});

  factory BaseResponse.fromJson(Map<String, dynamic> json, T Function(dynamic json) fromJsonT) =>
      _$BaseResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T value) toJsonT) =>
      _$BaseResponseToJson(this, toJsonT);
}