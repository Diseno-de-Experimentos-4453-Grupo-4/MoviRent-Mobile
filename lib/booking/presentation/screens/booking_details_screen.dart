import 'package:flutter/material.dart';
import 'package:movirent/auth/presentation/providers/profile_provider.dart';
import 'package:movirent/booking/domain/dto/booking_response.dto.dart';
import 'package:movirent/booking/domain/dto/update_booking_filter.dto.dart';
import 'package:movirent/booking/domain/service/booking.service.dart';
import 'package:movirent/scooters/domain/dto/scooter_response.dto.dart';
import 'package:movirent/shared/presentation/screens/home_screen.dart';
import 'package:movirent/shared/presentation/widgets/app_button.dart';
import 'package:movirent/shared/presentation/widgets/custom_alert.dart';
import 'package:movirent/ui/styles/ui_styles.dart';
import 'package:provider/provider.dart';

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

  final bookingService = BookingService();

  Future<void> _loadOwnerInfo() async {
    final profileService = ProfileService();
    final profile = await profileService.getById(widget.scooterResponseDTO.profileId!);
    setState(() {
      ownerName = "${profile.firstName} ${profile.lastName}";
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = context.read<ProfileProvider>();
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
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                      widget.bookingResponseDTO.statusId == 1 ? "En curso" : "En proceso de aprobación",
                style: TextStyle(
                    fontSize: textMid,
                  color: widget.bookingResponseDTO.statusId == 1 ? primary : danger
                )
              ),
            ),
            if (widget.scooterResponseDTO.profileId ==
                profileProvider.profile.id && widget.bookingResponseDTO.statusId == 2)
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: AppButton(
                  onPressed: () async{
                    await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: primary,
                          title: const Text("Aprobar baucher"),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "¿Desea aprobar este baucher de compra?",
                                style: TextStyle(
                                  color: background,
                                  fontSize: textMid,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              const SizedBox(height: 16),
                              Image.network(
                                  widget.bookingResponseDTO.baucher!,
                                width: 100,
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                "La empresa no se hace responsable de las transacciones realizadas entre los usuarios.",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: secondary,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  AppButton(
                                    onPressed: () => Navigator.of(context).pop(true),
                                    backgroundButton: danger,
                                    label: 'Cancelar',
                                  ),
                                  const SizedBox(width: 8),
                                  AppButton(
                                    onPressed: ()async{
                                      UpdateBookingFilterDto filter = UpdateBookingFilterDto(id:widget.bookingResponseDTO.id,statusId: 1);
                                      try{
                                        await bookingService.updateBookingStatus(filter);
                                        await showDialog(
                                            context: context,
                                            builder: (context){
                                              return CustomAlert(
                                                title: 'Reserva aprobada',
                                                content: 'La reserva fue aprobada por usted, recuerde que esta tendra una duración de 1 dia para el usuario',
                                                isSuccess: true,
                                                onPressed: () {
                                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
                                                },
                                              );
                                            }
                                        );
                                      } catch (e) {
                                        await showDialog(
                                            context: context,
                                            builder: (context){
                                              return  CustomAlert(
                                                title: 'Ocurrio un error al aprobar la reserva',
                                                content: 'Ocurrio un error al aprobar la reserva, por favor intentelo mas tarde.',
                                                isSuccess: false,
                                                onPressed: () {
                                                  Navigator.of(context).pop(true);
                                                },
                                              );
                                            }
                                        );
                                      }
                                    },
                                    backgroundButton: warn,
                                    label: 'Aprobar',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );

                  },
                  backgroundButton: primary,
                  label: 'Aprobar baucher de compra',),
                ) else Container()
          ],
        ),
      ),
    );
  }
}
