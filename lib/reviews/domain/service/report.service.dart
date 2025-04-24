import 'package:flutter/cupertino.dart';
import 'package:movirent/core/dio_helper.dart';
import 'package:movirent/reviews/domain/dto/report_response.dto.dart';

import '../../../core/constants.dart';
import '../dto/report_request.dto.dart';

class ReportService extends DioHelper<ReportResponseDTO,ReportRequestDTO>{
  ReportService(): super(
    'report',
      (json) => ReportResponseDTO.fromJson(json),
      (data) => (data).toJson()
  );

  Future<List<ReportResponseDTO>> getReportsByScooter(int scooterId) async {
    try {
      final response = await dio.get(
          '${Constant.dev.environment}$resourcePath/scooter?scooterId=$scooterId'
      );

      if (response.statusCode == 200) {
        return (response.data as List)
            .map((json) => ReportResponseDTO.fromJson(json))
            .toList();
      }
      return [];
    } catch (e) {
      debugPrint("Error fetching reviews: $e");
      return [];
    }
  }
}