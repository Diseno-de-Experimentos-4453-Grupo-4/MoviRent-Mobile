import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movirent/core/constants.dart';
import 'package:movirent/core/dio_helper.dart';
import 'package:movirent/reviews/domain/dto/rate_request.dto.dart';
import 'package:movirent/reviews/domain/dto/rate_response.dto.dart';

class RateService extends DioHelper<RateResponseDTO, RateRequestDTO> {
  RateService()
    :super(
      'reviews',
      (json) => RateResponseDTO.fromJson(json),
      (data) => (data as RateRequestDTO).toJson(),
    );

  Future<List<RateResponseDTO>> getReviewsByScooter(int scooterId) async {
    try {
      final response = await dio.get(
        '${Constant.dev.environment}$resourcePath/scooter/$scooterId'
      );

      if (response.statusCode == 200) {
        return (response.data as List)
          .map((json) => RateResponseDTO.fromJson(json))
          .toList();
      }
      return [];
    } catch (e) {
      debugPrint("Error fetching reviews: $e");
      return [];
    }
  }

  Future<RateResponseDTO?> submitReview(RateRequestDTO request) async {
    try {
      final response = await dio.post(
        '${Constant.dev.environment}$resourcePath',
        data: toJson(request),
      );
      return RateResponseDTO.fromJson(response.data);
    } catch (e) {
      debugPrint("Error submitting review: $e");
      return null;
    }
  }

}