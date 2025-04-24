import 'dart:convert';

import 'package:movirent/core/constants.dart';
import 'package:movirent/core/dio_helper.dart';
import 'package:movirent/subscription/domain/dto/subscription_request.dto.dart';
import 'package:movirent/subscription/domain/dto/subscription_response.dto.dart';

class SubscriptionService extends DioHelper<SubscriptionResponseDTO, SubscriptionRequestDTO>{
  SubscriptionService()
      :super(
      "subscription",
      (json) => SubscriptionResponseDTO.fromJson(json),
      (data) => data.toJson()
  );

  Future<bool> isUserSubscribed(int userId) async{
    final response = await dio.get("${Constant.dev.environment}$resourcePath/$userId");
    print(response.data);
    return response.data;
  }

}