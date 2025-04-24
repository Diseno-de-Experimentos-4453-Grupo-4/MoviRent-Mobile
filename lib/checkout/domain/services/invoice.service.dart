import 'package:movirent/checkout/domain/dto/invoice_request.dto.dart';
import 'package:movirent/checkout/domain/dto/invoice_response.dto.dart';
import 'package:movirent/core/dio_helper.dart';

class InvoiceService extends DioHelper<InvoiceResponseDTO, InvoiceRequestDTO>{
  InvoiceService(): super(
    "invoice",
      (json) => InvoiceResponseDTO.fromJson(json),
      (data) => data.toJson()
  );

}