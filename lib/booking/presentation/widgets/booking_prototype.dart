import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movirent/auth/domain/service/profile.service.dart';
import 'package:movirent/booking/domain/dto/booking_response.dto.dart';
import 'package:movirent/booking/presentation/screens/booking_details_screen.dart';
import 'package:movirent/scooters/domain/dto/scooter_response.dto.dart';
import 'package:movirent/scooters/domain/service/scooter.service.dart';

class BookingPrototype extends StatefulWidget {
  final int scooterId;
  final BookingResponseDTO booking;
  const BookingPrototype({super.key, required this.scooterId, required this.booking});

  @override
  State<BookingPrototype> createState() => _BookingPrototypeState();
}

class _BookingPrototypeState extends State<BookingPrototype> {
  final ScooterService _scooterService = ScooterService();
  ScooterResponseDTO? scooter;

  Future<void> _loadScooterInformation()async{
    final response = await _scooterService.getById(widget.scooterId);
    setState(() {
      scooter = response;
    });
  }

  @override
  void initState(){
    super.initState();
    _loadScooterInformation();
  }
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (_) =>
            BookingDetailsScreen(
                scooterResponseDTO: scooter!,
            bookingResponseDTO: widget.booking)
        )
        );
      },
      title: Text(scooter!.model!),
      subtitle: Text(scooter!.brand! ),
      trailing: Image.network(
          scooter!.image!,
      ),
    );
  }
}
