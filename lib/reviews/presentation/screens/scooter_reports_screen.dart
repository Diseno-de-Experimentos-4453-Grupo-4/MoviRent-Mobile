import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movirent/core/constants.dart';
import 'package:movirent/reviews/domain/service/report.service.dart';
import 'package:movirent/reviews/domain/dto/report_response.dto.dart';
import 'package:movirent/reviews/domain/dto/report_request.dto.dart';

class ScooterReportsScreen extends StatefulWidget {
  final String scooterId;
  const ScooterReportsScreen({super.key, required this.scooterId});

  @override
  _ScooterReportsScreenState createState() => _ScooterReportsScreenState();
}

class _ScooterReportsScreenState extends State<ScooterReportsScreen> {
  late final ReportService _reportService;
  List<ReportResponseDTO> _reports = [];
  bool _isLoading = false;

  @override
  void initState() {
    super .initState();
    _reportService = ReportService(
      'reports',
      (json) => ReportResponseDTO.fromJson(json),
      (data) => (data as ReportRequestDTO).toJson(),
    );
    _loadReports();
  }

  Future<void> _loadReports() async {
    setState(() => _isLoading = true);
    try {
      final response = await _reportService.dio.get(
        '${Constant.dev.environment}reports/scooter/${widget.scooterId}'
      );

      if (response.statusCode == 200) {
        setState((){
          _reports = (response.data as List)
            .map((json) => ReportResponseDTO.fromJson(json))
            .toList();
        });
      }
    } catch (e) {
      debugPrint("Error cargando reportes: $e");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Reportes del Scooter")),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _reports.isEmpty
              ? const Center(child: Text("No hay reportes aún"))
              : ListView.builder(
                  itemCount: _reports.length,
                  itemBuilder: (ctx, index) => _ReportCard(report: _reports[index]),

              ),
    );
  }
}

class _ReportCard extends StatelessWidget {
  final ReportResponseDTO report;
  const _ReportCard({required this.report});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text("Reporte #${report.id}"),
        subtitle: Text(report.content ?? ""),
      ),
    );
  }
}
