import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movirent/auth/domain/service/profile.service.dart';
import 'package:movirent/auth/presentation/providers/profile_provider.dart';
import 'package:movirent/scooters/domain/dto/scooter_response.dto.dart';
import 'package:movirent/scooters/domain/service/scooter.service.dart';
import 'package:movirent/scooters/presentation/widgets/scooter_details.dart';
import 'package:provider/provider.dart';

import '../../../ui/styles/ui_styles.dart';

class MyScootersScreen extends StatefulWidget {
  const MyScootersScreen({super.key});

  @override
  State<MyScootersScreen> createState() => _MyScootersScreenState();
}

class _MyScootersScreenState extends State<MyScootersScreen> {
  @override
  Widget build(BuildContext context) {
    final scooterService = ScooterService();
    final profileProvider = context.watch<ProfileProvider>();
    return Scaffold(
      appBar: AppBar(
        foregroundColor: secondary,
        title: Text("Mis scooters"),
      ),
      body: FutureBuilder<List<ScooterResponseDTO>>(
          future: scooterService.getScootersByProfileId(profileProvider.profile.id!),
          builder: (context, snapshot){
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(color: primary);
            }
            if (!snapshot.hasData) {
              return Center(
                child: Text(
                  "No tienes ningún scooter",
                  style: TextStyle(
                      color: secondary,
                      fontSize: textMid
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  "Ocurrió un error al cargar los scooters  ",
                  style: TextStyle(
                      color: danger,
                      fontSize: textMid
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.length,
              shrinkWrap: true,
                itemBuilder: (context, index){
                return Dismissible(
                  onDismissed: (_) async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('¿Estás seguro?'),
                        content: Text('¿Deseas eliminar este scooter?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: Text('Cancelar'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: Text('Eliminar', style: TextStyle(color: Colors.red)),
                          ),
                        ],
                      ),
                    );

                    if (confirm == true) {
                      await scooterService.delete(snapshot.data![index].id!);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Scooter eliminado')),
                      );
                    } else {
                      setState(() {});
                    }
                  },


                  key: Key(snapshot.data![index].id.toString()),
                  background: Container(
                    color:danger,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 20),
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                  child: ListTile(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_) => ScooterDetails(scooterResponseDTO:snapshot.data![index])));
                    },
                    leading: Image.network(
                      fit: BoxFit.cover,
                        snapshot.data![index].image!,
                      width: 120,
                    ),
                    title:Text(snapshot.data![index].model!),
                    subtitle: Text("S/. ${snapshot.data![index].price!}"),
                  ),
                );
                }
            );
          }
      ),
    );
  }
}
