import 'package:flutter/material.dart';
import 'package:movirent/auth/domain/dto/profile.dto.dart';
import 'package:movirent/ui/styles/ui_styles.dart';

class ProfileScreen extends StatelessWidget {
  final ProfileDTO profile;

  const ProfileScreen({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text("Mi Perfil"),
        backgroundColor: primary,
        foregroundColor: secondary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey[300],
                child: const Icon(Icons.person, size: 60, color: Colors.black54),
              ),
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Nombre: ${profile.firstName} ${profile.lastName}", style: textStyleBold),
                  const SizedBox(height: 10),
                  Text("Email: ${profile.email}", style: textStyleNormal),
                  const SizedBox(height: 10),
                  Text("DNI: ${profile.dni}", style: textStyleNormal),
                  const SizedBox(height: 10),
                  Text("Edad: ${profile.age}", style: textStyleNormal),
                  const SizedBox(height: 10),
                  Text("Teléfono: ${profile.phone}", style: textStyleNormal),
                  const SizedBox(height: 10),
                  Text("Calle: ${profile.street}", style: textStyleNormal),
                  const SizedBox(height: 10),
                  Text("Barrio: ${profile.neighborhood}", style: textStyleNormal),
                  const SizedBox(height: 10),
                  Text("Ciudad: ${profile.city}", style: textStyleNormal),
                  const SizedBox(height: 10),
                  Text("Distrito: ${profile.district}", style: textStyleNormal),
                ],
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Acción para editar el perfil
                debugPrint("Editar perfil presionado");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                "Editar Perfil",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}