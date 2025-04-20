import 'dart:io';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class ImgUrService{
  Future<String> uploadStaticImageToImgUr(XFile  file) async{
    final dio = Dio();
    dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options,handler){
            options.headers["Authorization"] = "Client-ID 811b17f523a787b";
            return handler.next(options);
          }
        )
    );
    final formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(file.path, filename: file.path.split("/").last),
    });

    final response = await dio.post(
        "https://api.imgur.com/3/image",
      data: formData
    );
    if (response.statusCode == 200 && response.data["success"] == true) {
      final url = response.data["data"]["link"];
      return url;
    } else {
      throw Exception("Error al subir la imagen: ${response.statusMessage}");
    }
  }
}