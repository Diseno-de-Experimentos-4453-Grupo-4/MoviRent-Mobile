import 'package:flutter/material.dart';
import 'package:movirent/reviews/domain/dto/rate_response.dto.dart';
import 'package:movirent/ui/styles/ui_styles.dart';

class ReviewCard extends StatelessWidget {
  final RateResponseDTO review;
  const ReviewCard({super.key, required this.review});

  @override
  Widget build(BuildContext contex) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Usuario: ${review.profileId}",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(review.comment ?? ""),
            SizedBox(height: 8),
            Row(
              children: List.generate(5, (i) => Icon(i < (review.starNumb ?? 0) ? Icons.star : Icons.star_border,
              color: Colors.amber,)),
            )
          ],
        ),
      ),
    );
  }
}