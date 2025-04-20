import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movirent/scooters/presentation/screens/my_scooters_screen.dart';
import 'package:movirent/shared/presentation/screens/profile_screen.dart';
import 'package:movirent/ui/styles/ui_styles.dart';

class CustomDrawer extends StatelessWidget {
  final String name;
  final dynamic profile;

  const CustomDrawer({super.key, required this.name, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primary,
      height: double.infinity,
      width: 200,
      child: Column(
        children: [
          SizedBox(height: 100),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProfileScreen(profile: profile),
                ),
              );
            },
            child: CircleAvatar(
              child: Icon(Icons.person),
            ),
          ),
          SizedBox(height: 10),
          Text(
            name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(height: 20),
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => MyScootersScreen()));
            },
            icon: Icon(Icons.bike_scooter),
          ),
         Text("Mis scooters"),
          SizedBox(height: 20),
          IconButton(
            onPressed: () {
            },
            icon: Icon(Icons.calendar_month),
          ),
          Text("Mis reservas"),
          SizedBox(height: 20),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.report),
          ),
          Text("Mis reportes"),
          SizedBox(height: 20),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.report),
          ),
          Text("Mis reseñas"),
        ],
      ),
    );
  }
}