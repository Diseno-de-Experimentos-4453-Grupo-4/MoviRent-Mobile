import 'package:dio/dio.dart';
abstract class JsonSerializable<T> {
  T fromJson(Map<String, dynamic> json);
  Map<String,dynamic> toJson(T data);
}
