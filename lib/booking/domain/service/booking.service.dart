import 'package:flutter/cupertino.dart';
import 'package:movirent/booking/domain/dto/booking_request.dto.dart';
import 'package:movirent/booking/domain/dto/booking_response.dto.dart';
import 'package:movirent/booking/domain/dto/update_booking_filter.dto.dart';
import 'package:movirent/core/dio_helper.dart';

import '../../../core/constants.dart';

class BookingService extends DioHelper<BookingResponseDTO, BookingRequestDTO> {
  BookingService() : super(
      "booking",
          (json) => BookingResponseDTO.fromJson(json),
          (data) => data.toJson()
  );

  Future<List<BookingResponseDTO>> getBookingsByProfile(int profileId) async {
    try {
      final response = await dio.get(
          '${Constant.dev.environment}$resourcePath?profileId=$profileId'
      );
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

  Future<List<BookingResponseDTO>> getOwnSpacesBookings(int profileId,
      int statusId) async {
    try {
      final response = await dio.get(
          '${Constant.dev
              .environment}$resourcePath/own/state?profileId=$profileId&statusId=$statusId'
      );
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((json) => BookingResponseDTO.fromJson(json))
            .toList();
      }
      return [];
    } catch (e) {
      debugPrint("Error fetching own spaces booking: $e");
      return [];
    }
  }

  Future<void> updateBookingStatus(UpdateBookingFilterDto filter) async {
    try {
      await dio.patch(
          '${Constant.dev.environment}$resourcePath',
        data: filter.toJson()
      );
    } catch (e) {
      debugPrint("Error updating booking status: $e");
    }
  }
}