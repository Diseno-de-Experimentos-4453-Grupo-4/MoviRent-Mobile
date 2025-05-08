import 'package:flutter/material.dart';
import 'package:movirent/auth/presentation/providers/profile_provider.dart';
import 'package:movirent/reviews/domain/dto/rate_request.dto.dart';
import 'package:movirent/reviews/domain/service/rate.service.dart';
import 'package:movirent/shared/presentation/widgets/app_button.dart';
import 'package:movirent/shared/presentation/widgets/app_text_field.dart';
import 'package:movirent/ui/styles/ui_styles.dart';
import 'package:provider/provider.dart';

import '../../../shared/presentation/widgets/custom_alert.dart';

class AddReviewScreen extends StatefulWidget {
  final int scooterId;
  const AddReviewScreen({super.key, required this.scooterId});

  @override
  _AddReviewScreenState createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  final _formKey = GlobalKey<FormState>();
  int _rating = 0;
  final _commentController = TextEditingController();
  final RateService _rateService = RateService();

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<ProfileProvider>(context).profile;
    final profileId = profile?.id;

    return Scaffold(
      appBar: AppBar(
        foregroundColor: secondary,
        title: const Text("Añadir Reseña"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(  // Añadido el Form widget
          key: _formKey,
          child: Column(
            children: [
              Text("Puntuación", style: TextStyle(fontSize: textMid)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (i) => IconButton(
                  icon: Icon(
                    i < _rating ? Icons.star : Icons.star_border,
                    size: 30,
                    color: Colors.amber,
                  ),
                  onPressed: () => setState(() => _rating = i + 1),
                )),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _commentController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: "Comentario",
                  labelStyle: TextStyle(color: secondary),
                  border: const OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? "Campo requerido" : null,
              ),
              const SizedBox(height: 20),
              AppButton(
                backgroundButton: primary, 
                onPressed: () => _submitReview(profileId),
                label: "Enviar",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submitReview(int? profileId) async {
    if(_formKey.currentState!.validate() && profileId != null && _rating > 0) {
      final request = RateRequestDTO(
        comment: _commentController.text,
        starNumb: _rating,
        profileId: profileId,
        scooterId: widget.scooterId,
      );

      try {
        await _rateService.submitReview(request);
        await showDialog(
            context: context,
            builder: (context){
              return CustomAlert(
                  title: "Reseña creada con éxito",
                  content: "La reseña se creo exitosamente",
                  isSuccess: true,
                  onPressed: (){
                    Navigator.pop(context);
                  }
              );
            }
        );
      } catch (e) {
        await showDialog(
            context: context,
            builder: (context){
              return CustomAlert(
                  title: "Ocurrio un error al crear la reseña",
                  content: "Por favor, intentelo más tarde",
                  isSuccess: false,
                  onPressed: (){
                    Navigator.pop(context);
                  }
              );
            }
        );
      }
    }
  }
}