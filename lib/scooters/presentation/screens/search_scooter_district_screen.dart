import 'package:flutter/material.dart';
import 'package:movirent/scooters/presentation/screens/scooters_found_screen.dart';
import 'package:movirent/ui/styles/ui_styles.dart';

import '../../../core/districtis.dart';

class SearchScooterDistrictScreen extends StatelessWidget {
  const SearchScooterDistrictScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: Text('Selecciona tu distrito'),
      ),
      body: ListView.builder(
        itemCount: districts.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (_) => ScootersFoundScreen(district: districts[index])));
            },
            leading: Icon(Icons.location_city),
            title: Text(districts[index]),
          );
        },
      ),
    );
  }
}
