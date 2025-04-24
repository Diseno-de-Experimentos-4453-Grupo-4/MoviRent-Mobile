import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movirent/auth/presentation/providers/profile_provider.dart';
import 'package:movirent/scooters/presentation/screens/publish_scooter.dart';
import 'package:movirent/scooters/presentation/screens/search_scooter_screen.dart';
import 'package:movirent/shared/presentation/providers/ui_provider.dart';
import 'package:movirent/shared/presentation/screens/home_screen.dart';
import 'package:movirent/subscription/presentation/screens/my_subscription_screen.dart';
import 'package:movirent/ui/styles/ui_styles.dart';
import 'package:provider/provider.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final profileProvider = context.watch<ProfileProvider>();
    List<Widget> screens = [SearchScooterScreen(),PublishScooter(), MySubscriptionScreen(userId: profileProvider.profile.id!)];
    final uiProvider = context.watch<UiProvider>();
    return BottomNavigationBar(
      currentIndex: uiProvider.index,
      onTap: (int index){
        Navigator.push(context, MaterialPageRoute(builder: (_) => screens[index]));
        uiProvider.updateIndex(index);
      },
      backgroundColor: primary,
       selectedItemColor: secondary,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
            label: "Buscar"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.bike_scooter),
              label: "Publicar Scooter"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.subscriptions),
              label: "Mi Suscripción"
          )
        ]
    );
  }
}
