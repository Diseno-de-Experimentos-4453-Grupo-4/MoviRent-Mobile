import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movirent/scooters/presentation/screens/scooters_found_screen.dart';

import '../../../shared/presentation/widgets/app_text_field.dart';
import '../../../ui/styles/ui_styles.dart';

class SearchScooterAddressScreen extends StatefulWidget {
  const SearchScooterAddressScreen({super.key});

  @override
  State<SearchScooterAddressScreen> createState() => _SearchScooterAddressScreenState();
}

class _SearchScooterAddressScreenState extends State<SearchScooterAddressScreen> {
  final TextEditingController streetController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController zoneController = TextEditingController();
  final TextEditingController districtController = TextEditingController();

  @override
  void dispose() {
    streetController.dispose();
    numberController.dispose();
    zoneController.dispose();
    districtController.dispose();
    super.dispose();
  }

  void _searchScooters() {
    final address = "${streetController.text}, ${numberController.text}, ${zoneController.text}, ${districtController.text}";
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ScootersFoundScreen(address: address),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ingresa la dirección"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            AppTextField(
              labelColor: secondary,
              controller: streetController,
              hintText: "Calle",
            ),
            SizedBox(height: 10),
            AppTextField(
              labelColor: secondary,
              controller: numberController,
              hintText: "Número",
            ),
            SizedBox(height: 10),
            AppTextField(
              labelColor: secondary,
              controller: zoneController,
              hintText: "Zona / Edificio / Piso",
            ),
            SizedBox(height: 10),
            AppTextField(
              labelColor: secondary,
              controller: districtController,
              hintText: "Distrito",
              suffixIcon: Icons.search,
              onSuffixTap: _searchScooters,
            ),
          ],
        ),
      ),
    );
  }
}
