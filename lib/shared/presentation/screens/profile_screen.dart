import 'package:flutter/material.dart';
import 'package:movirent/auth/presentation/providers/profile_provider.dart';
import 'package:movirent/core/shared_helper.dart';
import 'package:movirent/shared/presentation/screens/edit_profile_screen.dart';
import 'package:movirent/ui/styles/ui_styles.dart';
import 'package:provider/provider.dart';

import '../../../auth/presentation/screens/auth_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final profile = context.watch<ProfileProvider>().profile;

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
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const EditProfileScreen(),
                  ),
                );

                if (result == true) {
                  setState(() {});
                }
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
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async{
                final SharedHelper helper = SharedHelper();
                helper.removeEmail();
                helper.removeToken();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AuthScreen(),
                  )
                );

              },
              style: ElevatedButton.styleFrom(
                backgroundColor: danger,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                "Cerrar sesión",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}