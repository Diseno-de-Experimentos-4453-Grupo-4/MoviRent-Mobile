import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:movirent/booking/domain/dto/booking_request.dto.dart';
import 'package:movirent/booking/domain/service/booking.service.dart';
import 'package:movirent/checkout/domain/dto/invoice_request.dto.dart';
import 'package:movirent/checkout/domain/services/invoice.service.dart';
import 'package:movirent/shared/presentation/screens/home_screen.dart';
import 'package:movirent/subscription/domain/dto/subscription_request.dto.dart';
import 'package:movirent/subscription/domain/service/subscription.service.dart';

import '../../../ui/styles/ui_styles.dart';

class CheckoutPaymentScreen extends StatelessWidget {
  final String title;
  final String description;
  final int userId;
  final int? scooterId;
  final bool isSubscription;
  final double? price;
  const CheckoutPaymentScreen({super.key, required this.title, required this.userId, required this.description, required this.isSubscription, this.price, this.scooterId});

  @override
  Widget build(BuildContext context) {
    final invoiceService = InvoiceService();
    return Scaffold(
      appBar: AppBar(
        foregroundColor: secondary,
        title: Text(title),
      ),
      body: PaypalCheckoutView(
          sandboxMode: true,
          onSuccess: (params) async {
            if (isSubscription) {
              final subscriptionService = SubscriptionService();
              final request = SubscriptionRequestDTO(profileId: userId);
              await subscriptionService.post(request);
            } else{
              final bookingService = BookingService();
              final request = BookingRequestDTO(profileId: userId,scooterId: scooterId);
              await bookingService.post(request);
            }
            final request = InvoiceRequestDTO(profileId: userId, amount: 60);
            await invoiceService.post(request);
            Navigator.push(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Pago procesado exitosamente")),
            );
          },
          onError: (error) {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Se produjo un error al procesar su pago: $error")),
            );
          },
          onCancel: (params) {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Pago cancelado")),
            );
          },
          transactions:   [
            {
              "amount":{
                "total": price != null ? price.toString() : "20.5",
                'currency': 'USD'
              },
              "description": description
            }
          ],
          note: "Contact us for any questions on your order.",
          clientId: "AU2X2fLGSBM1u0ktLx5wfRYGmVUTK7z5xdjTfgcu4kswBLjBbB0cojV2qbo957DyAF_gDuhuXask6scA",
          secretKey: "EAh5tGgHIQ126Fz-L0Er1OsISm06kxYAmXrpM1sLObREVS65SYGllFCz-OW58nxh30gVdL5iYr4FlApW"
      ),
    );
  }
}
