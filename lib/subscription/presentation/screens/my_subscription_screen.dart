import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movirent/auth/presentation/providers/profile_provider.dart';
import 'package:movirent/checkout/presentation/screens/checkout_payment_screen.dart';
import 'package:movirent/shared/presentation/widgets/app_button.dart';
import 'package:movirent/subscription/domain/service/subscription.service.dart';
import 'package:provider/provider.dart';

import '../../../ui/styles/ui_styles.dart';

class MySubscriptionScreen extends StatefulWidget {
  final int userId;
  const MySubscriptionScreen({super.key, required this.userId});

  @override
  State<MySubscriptionScreen> createState() => _MySubscriptionScreenState();
}

class _MySubscriptionScreenState extends State<MySubscriptionScreen> {
  final subscriptionService = SubscriptionService();
  bool isSubscribed = false;
  bool isLoading = true;
  Future<void> _loadSubscriptionStatus() async{
    final response = await subscriptionService.isUserSubscribed(widget.userId);
    setState(() {
      isSubscribed = response;
      isLoading = false;
    });
  }
  @override
  void initState(){
    super.initState();
    _loadSubscriptionStatus();
  }
  @override
  Widget build(BuildContext context) {
    final profileProvider = context.watch<ProfileProvider>();
    return Scaffold(
      appBar: AppBar(
        foregroundColor: secondary,
        title: Text("Mi plan de suscripción"),
      ),
      body: Center(
        child: isLoading ? CircularProgressIndicator(
          color: primary,
        ) :
        isSubscribed
            ? Center(
          child: Text(
            "Ya tienes una suscripción activa",
            style: TextStyle(
                fontSize: textMid,
                fontWeight: FontWeight.bold
            ),
          ),
        ) :
        Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 1.2,
            height: 250,
            child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "S/. 60",
                        style: TextStyle(
                            fontSize: textLarge,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      const SizedBox(height: 25),
                      Text(
                        "Accede a alquileres ilimitados por la adquisición de un plan premium",
                      ),
                      const SizedBox(height: 20),
                      AppButton(
                          backgroundButton: primary,
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (_) => CheckoutPaymentScreen(
                              title: "Finalizar el pago de suscripción",
                              userId: profileProvider.profile.id!,
                              description: "Suscripción a la plataforma Movirent",
                              isSubscription: true,
                            )
                            )
                            );
                          },
                          label: "Suscribirme"
                      )
                    ],
                  ),
                )
            ),
          ),
        ) ,
      ),
    );
  }
}
