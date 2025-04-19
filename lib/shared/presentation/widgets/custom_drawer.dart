import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movirent/ui/styles/ui_styles.dart';

class CustomDrawer extends StatelessWidget {
  final String name;
  const CustomDrawer({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primary,
      height: double.infinity,
      width: 200,
      child: Column(

        children: [
          const SizedBox(height: 100),
          CircleAvatar(
            child: Icon(Icons.person),
          ),
          Text(name),
          const SizedBox(height: 20),
          IconButton(
              onPressed: (){

              },
              icon: Icon(Icons.bike_scooter)
          ),
          Text("Mis scooters"),
          const SizedBox(height: 20),
          IconButton(
              onPressed: (){

              },
              icon: Icon(Icons.calendar_month)
          ),
          Text("Mis reservas"),
          const SizedBox(height: 20),
          IconButton(
              onPressed: (){

              },
              icon: Icon(Icons.report)
          ),
          Text("Mis reportes"),
          const SizedBox(height: 20),
          IconButton(
              onPressed: (){

              },
              icon: Icon(Icons.report)
          ),
          Text("Mis reseñas")
        ],
      ),
    );
  }
}
