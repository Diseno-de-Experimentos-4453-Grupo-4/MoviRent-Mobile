import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movirent/auth/presentation/providers/profile_provider.dart';
import 'package:movirent/booking/presentation/screens/own_spaces_bookings_screen.dart';
import 'package:movirent/reviews/presentation/screens/my_reviews_screen.dart';
import 'package:movirent/scooters/presentation/screens/my_scooters_screen.dart';
import 'package:movirent/shared/presentation/screens/profile_screen.dart';
import 'package:movirent/ui/styles/ui_styles.dart';
import 'package:provider/provider.dart';

import '../../../booking/presentation/screens/my_bookings_screen.dart';
import '../../../reviews/presentation/screens/my_reports_screen.dart';

class CustomDrawer extends StatelessWidget {
  final String name;
  final dynamic profile;

  const CustomDrawer({super.key, required this.name, required this.profile});

  @override
  Widget build(BuildContext context) {
    final profileProvider = context.watch<ProfileProvider>();
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
                  builder: (_) => ProfileScreen(),
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
              Navigator.push(context, MaterialPageRoute(builder: (_) => MyBookingsScreen(userId: profileProvider.profile.id!)));
            },
            icon: Icon(Icons.calendar_month),
          ),
          Text("Mis reservas"),
          SizedBox(height: 20),
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => OwnSpacesBookingsScreen(userId: profileProvider.profile.id!)));
            },
            icon: Icon(Icons.calendar_today_rounded),
          ),
          Text("Reservas a mis espacios"),
          SizedBox(height: 20),
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => MyReportsScreen(userId: profileProvider.profile.id!)));
            },
            icon: Icon(Icons.report),
          ),
          Text("Mis reportes"),
          SizedBox(height: 20),
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => MyReviewsScreen(userId: profileProvider.profile.id!)));
            },
            icon: const Icon(Icons.report),
          ),
          Text("Mis reseñas"),
        ],
      ),
    );
  }
}