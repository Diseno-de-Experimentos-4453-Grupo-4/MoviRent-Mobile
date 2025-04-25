import 'package:flutter/material.dart';
import 'package:movirent/booking/domain/dto/booking_response.dto.dart';
import 'package:movirent/scooters/domain/dto/scooter_response.dto.dart';
import 'package:movirent/reviews/presentation/screens/add_review_screen.dart';
import 'package:movirent/reviews/presentation/screens/scooter_reports_screen.dart';
import 'package:movirent/ui/styles/ui_styles.dart';

import '../../../auth/domain/service/profile.service.dart';

class BookingDetailsScreen extends StatefulWidget {
  final ScooterResponseDTO scooterResponseDTO;
  final BookingResponseDTO bookingResponseDTO;

  const BookingDetailsScreen({
    super.key,
    required this.scooterResponseDTO,
    required this.bookingResponseDTO,
  });

  @override
  State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
  String ownerName = "";

  @override
  void initState() {
    super.initState();
    _loadOwnerInfo();
  }

  Future<void> _loadOwnerInfo() async {
    final profileService = ProfileService();
    final profile = await profileService.getById(widget.scooterResponseDTO.profileId!);
    setState(() {
      ownerName = "${profile.firstName} ${profile.lastName}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalle de la Reserva"),
        foregroundColor: secondary,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              widget.scooterResponseDTO.image ?? '',
              width: double.infinity,
              height: 220,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Scooter: ${widget.scooterResponseDTO.brand} - ${widget.scooterResponseDTO.model}",
                style: TextStyle(fontSize: textMid, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Dirección: ${widget.scooterResponseDTO.address}",
                style: TextStyle(fontSize: textMid),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Dueño del scooter: $ownerName",
                style: TextStyle(fontSize: textMid),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Dirección: ${widget.scooterResponseDTO.address}",
                style: TextStyle(fontSize: textMid),
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Fecha de inicio: ${widget.bookingResponseDTO.startDate.toString().split("T")[0]}",
                style: TextStyle(fontSize: textMid),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Fecha de fin: ${widget.bookingResponseDTO.endDate.toString().split("T")[0]}",
                style: TextStyle(fontSize: textMid),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Precio total: S/. ${widget.scooterResponseDTO.price.toString()}",
                style: TextStyle(fontSize: textMid),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
