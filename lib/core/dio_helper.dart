import 'package:dio/dio.dart';
import 'package:movirent/core/shared_helper.dart';

import 'constants.dart';

abstract class DioHelper<TResponse,TRequest> {
   final Dio dio = Dio();
   final String resourcePath;
   final TResponse Function(Map<String, dynamic>) fromJson;
   final Map<String, dynamic> Function(TRequest data) toJson;

   DioHelper(this.resourcePath, this.fromJson, this.toJson){
     dio.interceptors.add(InterceptorsWrapper(
       onRequest: (options, handler) async{
         final token = await SharedHelper().getString("token");
         if (token != null) {
           options.headers['Authorization'] = 'Bearer $token';
         }
         return handler.next(options);
       }
     ));
   }
   Future<List<TResponse>> get() async{
     final response = await dio.get(
       Constant.dev.environment + resourcePath
     );
     if (response.statusCode == 200) {
       final List<dynamic> data = response.data;
       return data.map((json) => fromJson(json)).toList();
     }
     return [];
   }

   Future<TResponse> getById(int id) async{
     final response = await dio.get(
         "${Constant.dev.environment}$resourcePath/${id}"
     );
     return response.data;
   }

   Future<bool> post(TRequest data) async{
     await dio.post(
         Constant.dev.environment + resourcePath,
       data: toJson(data)
     );
     return true;
   }

   Future<bool> put(int id, TRequest data) async{
     await dio.put(
         "${Constant.dev.environment}$resourcePath/$id",
         data: toJson(data)
     );
     return true;
   }
}
