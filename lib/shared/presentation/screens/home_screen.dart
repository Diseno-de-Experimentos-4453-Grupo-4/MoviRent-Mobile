import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movirent/auth/presentation/providers/profile_provider.dart';
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: AppTextField(
              hintText: "Ingrese dirección",
                labelColor: secondary
            ),
          )
        ],
      ),
    );
  }
}
