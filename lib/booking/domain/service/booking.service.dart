import 'package:flutter/cupertino.dart';
import 'package:movirent/booking/domain/dto/booking_request.dto.dart';
import 'package:movirent/booking/domain/dto/booking_response.dto.dart';
import 'package:movirent/core/dio_helper.dart';

import '../../../core/constants.dart';

class BookingService extends DioHelper<BookingResponseDTO, BookingRequestDTO>{
  BookingService(): super(
    "booking",
      (json) => BookingResponseDTO.fromJson(json),
      (data) => data.toJson()
  );

  Future<List<BookingResponseDTO>> getBookingsByProfile(int profileId) async {
    try {
      final response = await dio.get(
          '${Constant.dev.environment}$resourcePath?profileId=$profileId'
      );
      print(response.data);

      if (response.statusCode == 200) {
        return (response.data as List)
            .map((json) => BookingResponseDTO.fromJson(json))
            .toList();
      }
      return [];
    } catch (e) {
      debugPrint("Error fetching reviews: $e");
      return [];
    }
  }

}