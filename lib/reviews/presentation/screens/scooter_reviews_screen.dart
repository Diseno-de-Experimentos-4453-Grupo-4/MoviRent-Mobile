import 'package:flutter/material.dart';
import 'package:movirent/reviews/domain/dto/rate_response.dto.dart';
import 'package:movirent/reviews/domain/service/rate.service.dart';
import 'package:movirent/reviews/presentation/screens/add_review_screen.dart';
import 'package:movirent/ui/styles/ui_styles.dart';

class ScooterReviewsScreen extends StatefulWidget {
  final String scooterId;
  const ScooterReviewsScreen({super.key, required this.scooterId});
  
  @override
  _ScooterReviewsScreenState createState() => _ScooterReviewsScreenState();
}

class _ScooterReviewsScreenState extends State<ScooterReviewsScreen> {
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
      final reviews = await _rateService.getReviewsByScooter(int.parse(widget.scooterId));
      setState(() => _reviews = reviews);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error al cargar las reseñas: $e")),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _navigateToAddReview(BuildContext context) async {
    final result = await Navigator.push(context, 
      MaterialPageRoute(
        builder: (_) => AddReviewScreen(scooterId: widget.scooterId),
      ),
    );

    if (result == true) {
      await _loadReviews();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Reseña agregada exitosamente")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: secondary,
        title: const Text("Reseñas del scooter"),
      ),
      body: _isLoading
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
                  itemBuilder: (ctx, index) => _ReviewCard(review: _reviews[index]),
                ),
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddReview(context),
        child: Icon(Icons.add, color: background),
        backgroundColor: primary
      ),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  final RateResponseDTO review;
  const _ReviewCard({required this.review});

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
              "Usuario: ${review.profileId}",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Row(
              children: List.generate(5, (i) => Icon(i < (review.starNumb ?? 0) ? Icons.star : Icons.star_border,
                color: Colors.amber,
              )),
            ),
          ],
        ),
      ),
    );
  }
}