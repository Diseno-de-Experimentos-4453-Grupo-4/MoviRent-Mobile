
import 'dart:io';

import 'package:movirent/core/dio_helper.dart';
import 'package:movirent/scooters/domain/dto/scooter_request.dto.dart';
import 'package:movirent/scooters/domain/dto/scooter_response.dto.dart';

import '../../../core/constants.dart';

class ScooterService extends DioHelper<ScooterResponseDTO, ScooterRequestDTO>{
  ScooterService(): super(
      "scooter",
          (json) => ScooterResponseDTO.fromJson(json),
          (data) => data.toJson()
  );

  Future<List<ScooterResponseDTO>> getScooterByAddress(String address) async {
    final response = await dio.get("${Constant.dev.environment}$resourcePath/address/$address");

    if (response.statusCode == HttpStatus.ok) {
      final result = response.data;
      print(result);
      return [ScooterResponseDTO.fromJson(result)];
    }

    return [];
  }


  Future<List<ScooterResponseDTO>> getScootersDistrict(String district) async{
    final response = await dio.get("${Constant.dev.environment}$resourcePath/district?district=$district");
    if (response.statusCode == HttpStatus.ok){
      return (response.data as List).map((scooter) => ScooterResponseDTO.fromJson(scooter)).toList();
    }
    return [];
  }

  Future<List<ScooterResponseDTO>> getScootersByProfileId(int profileId) async{
    final response = await dio.get("${Constant.dev.environment}$resourcePath/profile?profileId=$profileId");
    if (response.statusCode == HttpStatus.ok){
      return (response.data as List).map((scooter) => ScooterResponseDTO.fromJson(scooter)).toList();
    }
    return [];
  }



}