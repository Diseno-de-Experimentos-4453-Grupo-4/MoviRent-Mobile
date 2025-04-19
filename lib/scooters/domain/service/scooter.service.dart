
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

  Future<ScooterResponseDTO> getScooterByAddress(String address) async{
    final response = await dio.get("${Constant.dev.environment}$resourcePath/address/$address");
    final scooterJson = response.data;
    return ScooterResponseDTO.fromJson(scooterJson);
  }

  Future<List<ScooterResponseDTO>> getScootersDistrict(String district) async{
    final response = await dio.get("${Constant.dev.environment}$resourcePath/district?district=$district");
    if (response.statusCode == HttpStatus.ok){
      final result = response.data;
      return result.map((scooter) => ScooterResponseDTO.fromJson(scooter)) as List<ScooterResponseDTO>;
    }
    return [];
  }



}