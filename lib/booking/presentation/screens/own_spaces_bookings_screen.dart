import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movirent/booking/domain/dto/booking_response.dto.dart';
import 'package:movirent/booking/domain/service/booking.service.dart';
import 'package:movirent/booking/presentation/widgets/booking_prototype.dart';
import 'package:tab_container/tab_container.dart';

import '../../../ui/styles/ui_styles.dart';

class OwnSpacesBookingsScreen extends StatefulWidget {
  final int userId;
  const OwnSpacesBookingsScreen({super.key, required this.userId});

  @override
  State<OwnSpacesBookingsScreen> createState() => _OwnSpacesBookingsScreenState();
}

class _OwnSpacesBookingsScreenState extends State<OwnSpacesBookingsScreen> with SingleTickerProviderStateMixin {
  late TabController _controller;
  final bookingService = BookingService();
  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: secondary,
        title: const Text("Reservas a mis spacios"),
      ),
      body:  SizedBox(
        width: double.infinity,
        child: TabContainer(
              controller: _controller,
              tabEdge: TabEdge.top,
              tabsStart: 0.0,
              tabsEnd: 0.8,
              tabMaxLength: 150,
              borderRadius: BorderRadius.circular(10),
              tabBorderRadius: BorderRadius.circular(10),
              childPadding: const EdgeInsets.all(20.0),
              selectedTextStyle: const TextStyle(
                color: Colors.white,
                fontSize: 15.0,
              ),
              unselectedTextStyle: const TextStyle(
                color: Colors.black,
                fontSize: 13.0,
              ),
              colors: [
                Colors.red,
                Colors.green
              ],
              tabs: [
                Text('En curso'),
                Text('En proceso de aprobación')
              ],
              children: [
                _BookingsList(
                   userId: widget.userId,
                  statusId: 1,
                  emptyMessage: "No hay reservas en curso en este momento"
                ),
                _BookingsList(
                    userId: widget.userId,
                    statusId: 2,
                    emptyMessage: "No hay reservas en curso en proceso de aprobación en este momento"
                ),

              ],
            ),
      )
    );
  }
}

class _BookingsList extends StatelessWidget {
  final int userId;
  final int statusId;
  final String emptyMessage;

  const _BookingsList({
    super.key,
    required this.userId,
    required this.statusId,
    required this.emptyMessage,
  });

  @override
  Widget build(BuildContext context) {
    final bookingService = BookingService();

    return FutureBuilder<List<BookingResponseDTO>>(
      future: bookingService.getOwnSpacesBookings(userId, statusId),
      builder: (BuildContext context, AsyncSnapshot<List<BookingResponseDTO>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Ocurrió un error al cargar las reservas.'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text(emptyMessage, style: TextStyle(color: background, fontWeight: FontWeight.bold)));
        }
        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (BuildContext context, int index) {
            return BookingPrototype(
              scooterId: snapshot.data![index].scooterId!,
              booking: snapshot.data![index],
            );
          },
        );
      },
    );
  }
}

