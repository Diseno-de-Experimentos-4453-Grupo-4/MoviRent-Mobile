import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../ui/styles/ui_styles.dart';
import '../../domain/dto/rate_response.dto.dart';
import '../../domain/service/rate.service.dart';

class MyReviewsScreen extends StatefulWidget {
  final int userId;
  const MyReviewsScreen({super.key, required this.userId});

  @override
  State<MyReviewsScreen> createState() => _MyReviewsScreenState();
}

class _MyReviewsScreenState extends State<MyReviewsScreen> {

  final RateService _rateService = RateService();
  List<RateResponseDTO> _reviews = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadReviews();
  }

  Future<void> _loadReviews() async {
    setState(() => _isLoading = true);
    try {
      final reviews = await _rateService.getReviewsByProfile(widget.userId);
      setState(() => _reviews = reviews);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error al cargar las reseñas: $e")),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: secondary,
        title: const Text("Mis reseñas"),
      ),
      body:  _isLoading
          ? Center(child: CircularProgressIndicator(color: primary))
          : _reviews.isEmpty
          ? Center(
        child: Text(
          "No hay reseñas aún",
          style: TextStyle(color: secondary, fontSize: textMid),
        ),
      )
          : RefreshIndicator(
        onRefresh: _loadReviews,
        child: ListView.builder(
          itemCount: _reviews.length,
          itemBuilder:
              (ctx, index) =>
                  GestureDetector(
                    onTap: ()async {

                    },
                    child: _ReviewCard(review: _reviews[index]
                    ),
                  ),
        ),
      ),
    );
  }
}


class _ReviewCard extends StatefulWidget {
  final RateResponseDTO review;
  const _ReviewCard({required this.review});

  @override
  State<_ReviewCard> createState() => _ReviewCardState();
}

class _ReviewCardState extends State<_ReviewCard> {

  @override
  Widget build(BuildContext) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${widget.review.comment}",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Row(
              children: List.generate(5, (i) => Icon(i < (widget.review.starNumb ?? 0) ? Icons.star : Icons.star_border,
                color: Colors.amber,
              )),
            ),
          ],
        ),
      ),
    );
  }
}
