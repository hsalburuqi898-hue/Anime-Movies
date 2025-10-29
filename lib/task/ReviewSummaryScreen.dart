import 'package:flutter/material.dart';
import 'package:project/task/paymentScreen.dart';
import 'PaymentSuccessScreen.dart';

class ReviewSummaryScreen extends StatelessWidget {
  final Map<String, dynamic> movie;
  final List<String> selectedSeats;
  final double totalPrice;

  const ReviewSummaryScreen({
    Key? key,
    required this.movie,
    required this.selectedSeats,
    required this.totalPrice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final duration = movie['duration'] ?? 'N/A';
    final title = movie['title'] ?? 'Unknown Title';
    final imageUrl = movie['images']?['jpg']?['large_image_url'];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Review Summary',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '05:56',
              style: TextStyle(
                color: const Color(0xFF6B5B95),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Movie Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Movie Poster
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: imageUrl != null
                          ? Image.network(
                              imageUrl,
                              width: 100,
                              height: 140,
                              fit: BoxFit.cover,
                            )
                          : Container(
                              width: 100,
                              height: 140,
                              color: Colors.grey[300],
                              child: const Icon(Icons.movie),
                            ),
                    ),
                    const SizedBox(width: 16),
                    // Movie Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          _buildDetailRow('Duration', duration),
                          _buildDetailRow(
                            'Director',
                            movie['studios']?.isNotEmpty == true
                                ? movie['studios'][0]['name']
                                : 'N/A',
                          ),
                          if (movie['rating'] != null)
                            Container(
                              margin: const EdgeInsets.only(top: 8),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF6B5B95).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                movie['rating'],
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF6B5B95),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          const SizedBox(height: 8),
                          _buildGenres(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Booking Details Section
              const Text(
                'Booking Details',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              _buildInfoRow('Cinema', 'AMC Empire 25'),
              _buildInfoRow('Package', 'Standard'),
              _buildInfoRow('Auditorium', 'Auditorium 3'),
              _buildInfoRow('Seat(s)', selectedSeats.join(', ')),
              _buildInfoRow('Date', 'Dec 22, 2023'),
              _buildInfoRow('Hours', '17:30 - 20:38'),

              const SizedBox(height: 24),

              // Price Details Section
              const Text(
                'Price Details',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF6B5B95).withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    _buildPriceRow(
                      'Seats (${selectedSeats.length}x)',
                      '\$${totalPrice.toStringAsFixed(2)}',
                    ),
                    const Divider(height: 24),
                    _buildPriceRow('Service Fee', '\$2.00'),
                    _buildPriceRow('Tax', '\$1.50'),
                    const Divider(height: 24),
                    _buildPriceRow(
                      'Total',
                      '\$${(totalPrice + 3.50).toStringAsFixed(2)}',
                      isTotal: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Continue to Payment Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to payment screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PaymentScreen(totalAmount: totalPrice + 3.50),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6B5B95),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Continue to Payment',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGenres() {
    final genres = movie['genres'] as List<dynamic>?;
    if (genres == null || genres.isEmpty) return const SizedBox();

    return Wrap(
      spacing: 4,
      runSpacing: 4,
      children: genres.take(3).map((genre) {
        return Text(
          '${genre['name']}, ',
          style: TextStyle(fontSize: 11, color: Colors.grey[600]),
        );
      }).toList(),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
          Text(
            value,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 18 : 14,
              fontWeight: FontWeight.bold,
              color: isTotal ? const Color(0xFF6B5B95) : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
