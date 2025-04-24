import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movirent/reviews/domain/service/report.service.dart';

import '../../../ui/styles/ui_styles.dart';
import '../../domain/dto/report_response.dto.dart';
import '../../domain/service/rate.service.dart';

class MyReportsScreen extends StatefulWidget {
  final int userId;
  const MyReportsScreen({super.key, required this.userId});

  @override
  State<MyReportsScreen> createState() => _MyReportsScreenState();
}

class _MyReportsScreenState extends State<MyReportsScreen> {
  final ReportService _reportService = ReportService();
  List<ReportResponseDTO> _reports = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadReports();
  }

  Future<void> _loadReports() async {
    setState(() => _isLoading = true);
    try {
      final reports = await  _reportService.getReportsByProfile(widget.userId);
      setState(() => _reports = reports);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error al cargar los reportes: $e")),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: secondary,
        title: const Text("Mis reportes"),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator(color: primary))
          : _reports.isEmpty
          ? Center(
        child: Text(
          "No hay reportes aún",
          style: TextStyle(color: secondary, fontSize: textMid),
        ),
      )
          : RefreshIndicator(
        onRefresh: _loadReports,
        child: ListView.builder(
          itemCount: _reports.length,
          itemBuilder: (ctx, index) => Dismissible(
            key: Key(_reports[index].id.toString()),
            background: Container(
              color: danger,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 20),
              child: Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (_) async {
              await _reportService.delete(_reports[index].id!);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Reporte eliminado')),
              );
            },
            child: _ReportCard(report: _reports[index]),
          ),
        ),
      ),
    );
  }
}

class _ReportCard extends StatefulWidget {
  final ReportResponseDTO report;
  const _ReportCard({required this.report});

  @override
  State<_ReportCard> createState() => _ReportCardState();
}

class _ReportCardState extends State<_ReportCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${widget.report.content}",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
