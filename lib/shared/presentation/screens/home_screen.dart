import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movirent/auth/presentation/providers/profile_provider.dart';
import 'package:movirent/scooters/domain/dto/scooter_response.dto.dart';
import 'package:movirent/scooters/presentation/screens/search_scooter_screen.dart';
import 'package:movirent/scooters/presentation/widgets/scooter_card.dart';
import 'package:movirent/shared/presentation/widgets/app_text_field.dart';
import 'package:movirent/shared/presentation/widgets/custom_drawer.dart';
import 'package:movirent/shared/presentation/widgets/custom_navigation_bar.dart';
import 'package:provider/provider.dart';

import '../../../auth/domain/service/profile.service.dart';
import '../../../core/shared_helper.dart';
import '../../../ui/styles/ui_styles.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final profileService = ProfileService();
  final scooter1 = ScooterResponseDTO(
      image: "https://i.ebayimg.com/images/g/z5UAAOSwCyFmJYMe/s-l1600.webp",
    brand: "USGOODEAL-COM",
    model: "Scooter eléctrico de alta resistencia 500 W 28 MPH E-Scooter sentado sistema NFC rango 28 m-",
    price: 500
  );

  final scooter2 = ScooterResponseDTO(
      image: "https://i.ibb.co/LnNVm5W/MTMad1600-Blue-3.jpg",
      brand: "Electric Scooter Motor On Bicycle",
      model: "Scooter eléctrico de alta resistencia 500 W 28 MPH E-Scooter sentado sistema NFC rango 28 m-",
      price: 200
  );
  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  void _loadProfile() async {
    try {
      final currentEmail = await SharedHelper().getEmail();
      final profile = await profileService.getProfileByEmail(currentEmail!);
      if (mounted) {
        context.read<ProfileProvider>().setProfile(profile);
      }
    } catch (e) {
      debugPrint("An error occurred loading profile: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = context.watch<ProfileProvider>();
    return Scaffold(
      bottomNavigationBar: CustomNavigationBar(),
      appBar: AppBar(
        foregroundColor: secondary,
        backgroundColor: primary,
        title: Text(
            "Bienvenido! ${profileProvider.profile.firstName}",
          style: TextStyle(
            fontSize: textMid,
            fontWeight: FontWeight.bold
          ),
        ) ,
      ),
      drawer: CustomDrawer(name: profileProvider.profile.firstName!),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (_) => SearchScooterScreen()));
              },
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                  child: AppTextField(
                    hintText: "Empieza a buscar tu scooter ideal",
                      labelColor: secondary
                  ),
              ),
            ),
            ScooterCard(scooter: scooter1),
            ScooterCard(scooter: scooter2)
          ],
        ),
      ),
    );
  }
}
