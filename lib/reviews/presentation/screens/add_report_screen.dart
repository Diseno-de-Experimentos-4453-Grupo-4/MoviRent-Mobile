import 'package:flutter/material.dart';
import 'package:movirent/auth/presentation/providers/profile_provider.dart';
import 'package:movirent/reviews/domain/dto/rate_request.dto.dart';
import 'package:movirent/reviews/domain/service/rate.service.dart';
import 'package:movirent/reviews/domain/service/report.service.dart';
import 'package:movirent/shared/presentation/widgets/app_button.dart';
import 'package:movirent/shared/presentation/widgets/app_text_field.dart';
import 'package:movirent/ui/styles/ui_styles.dart';
import 'package:provider/provider.dart';

import '../../domain/dto/report_request.dto.dart';

class AddReportScreen extends StatefulWidget {
  final int scooterId;
  const AddReportScreen({super.key, required this.scooterId});

  @override
  _AddReportScreenState createState() => _AddReportScreenState();
}

class _AddReportScreenState extends State<AddReportScreen> {
  final _formKey = GlobalKey<FormState>();
  final _commentController = TextEditingController();
  final ReportService _reportService = ReportService();

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<ProfileProvider>(context).profile;
    final profileId = profile.id;

    return Scaffold(
      appBar: AppBar(
        foregroundColor: secondary,
        title: const Text("Añadir Reporte"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 20),
              TextFormField(
                controller: _commentController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: "Reporte",
                  labelStyle: TextStyle(color: secondary),
                  border: const OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? "Campo requerido" : null,
              ),
              const SizedBox(height: 20),
              AppButton(
                backgroundButton: primary,
                onPressed: () => _submitReport(profileId),
                label: "Enviar",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submitReport(int? profileId) async {
      final request = ReportRequestDTO(
        content: _commentController.text,
        profileId: profileId,
        scooterId: widget.scooterId,
      );
      try {
        await _reportService.post(request);
        Navigator.pop(context, true);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error al enviar la reseña: $e"),)
        );
      }
    }
  }