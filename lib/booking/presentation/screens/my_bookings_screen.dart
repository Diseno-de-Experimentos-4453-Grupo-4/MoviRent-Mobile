import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movirent/booking/domain/dto/booking_response.dto.dart';
import 'package:movirent/booking/domain/service/booking.service.dart';
import 'package:movirent/booking/presentation/widgets/booking_prototype.dart';

import '../../../ui/styles/ui_styles.dart';

class MyBookingsScreen extends StatefulWidget {
  final int userId;
  const MyBookingsScreen({super.key, required this.userId});

  @override
  State<MyBookingsScreen> createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends State<MyBookingsScreen> {
  final _bookingService = BookingService();
  List<BookingResponseDTO> bookings = [];
  bool _isLoading = true;
  Future<void> _loadBookings() async{
    final response = await _bookingService.getBookingsByProfile(widget.userId);
    setState(() {
      bookings = response;
      _isLoading = false;
    });
  }

  @override
  void initState(){
    super.initState();
    _loadBookings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: secondary,
        title: const Text("Mis reservas disponibles"),
      ),
      body: _isLoading ? Center(
        child: CircularProgressIndicator(
          color: primary,
        ),
      ) : ListView.builder(
          itemCount: bookings.length,
          shrinkWrap: true,
          itemBuilder: (context,index){
             return BookingPrototype(
               scooterId: bookings[index].scooterId!,
               booking: bookings[index],
             );
          }
      ),

    );
  }
}
