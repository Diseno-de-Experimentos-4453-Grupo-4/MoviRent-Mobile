import 'package:flutter/material.dart';
import 'package:movirent/auth/domain/dto/profile.dto.dart';
import 'package:movirent/auth/domain/service/profile.service.dart';
import 'package:movirent/reviews/domain/dto/rate_response.dto.dart';
import 'package:movirent/reviews/domain/dto/report_response.dto.dart';
import 'package:movirent/reviews/domain/service/rate.service.dart';
import 'package:movirent/reviews/domain/service/report.service.dart';
import 'package:movirent/reviews/presentation/screens/add_review_screen.dart';
import 'package:movirent/ui/styles/ui_styles.dart';

import 'add_report_screen.dart';

class ScooterReportsScreen extends StatefulWidget {
  final int scooterId;
  const ScooterReportsScreen({super.key, required this.scooterId});

  @override
  _ScooterReportsScreenState createState() => _ScooterReportsScreenState();
}

class _ScooterReportsScreenState extends State<ScooterReportsScreen> {
  final ReportService reportService = ReportService();
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
      final reports = await reportService.getReportsByScooter(widget.scooterId);
      setState(() => _reports = reports);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error al cargar los reportes")),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }



  Future<void> _navigateToAddReview(BuildContext context) async {
    final result = await Navigator.push(context,
      MaterialPageRoute(
        builder: (_) => AddReportScreen(scooterId: widget.scooterId),
      ),
    );

    if (result == true) {
      await _loadReports();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Reporte agregada exitosamente")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: secondary,
        title: const Text("Reportes del scooter"),
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
          itemBuilder: (ctx, index) => ReportCard(report: _reports[index]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => _navigateToAddReview(context),
          backgroundColor: primary,
          child: Icon(Icons.add, color: background)
      ),
    );
  }
}

class ReportCard extends StatefulWidget {
  final ReportResponseDTO report;
  const ReportCard({required this.report});

  @override
  State<ReportCard> createState() => _ReportCardState();
}

class _ReportCardState extends State<ReportCard> {


  ProfileDTO? profile;
  final ProfileService profileService = ProfileService();

  Future<void> _loadProfile(int id) async{
    try{
      final profileFound = await profileService.getById(id);
      setState(() {
        profile = profileFound;
      });
    } catch (e){
      throw Exception("An error has ocurred while trying to found current profile $e");
    }
  }

  @override
  void initState(){
    super.initState();
    () async {
      _loadProfile(widget.report.profileId!);
    }();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            profile == null
                ? CircularProgressIndicator()
                : Text(
              "${profile!.firstName} ${profile!.lastName}",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
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