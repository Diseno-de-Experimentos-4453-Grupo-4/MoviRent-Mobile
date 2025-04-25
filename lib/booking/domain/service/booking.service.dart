import 'package:movirent/booking/domain/dto/booking_request.dto.dart';
import 'package:movirent/booking/domain/dto/booking_response.dto.dart';
import 'package:movirent/core/dio_helper.dart';

class BookingService extends DioHelper<BookingResponseDTO, BookingRequestDTO>{
  BookingService(): super(
    "booking",
      (json) => BookingResponseDTO.fromJson(json),
      (data) => data.toJson()
  );

}