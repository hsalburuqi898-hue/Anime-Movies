import 'package:flutter/material.dart';
import 'package:project/task/ReviewSummaryScreen.dart';
import 'ReviewSummaryScreen.dart';

class SeatBookingScreen extends StatefulWidget {
  final Map<String, dynamic> movie;

  const SeatBookingScreen({Key? key, required this.movie}) : super(key: key);

  @override
  State<SeatBookingScreen> createState() => _SeatBookingScreenState();
}

class _SeatBookingScreenState extends State<SeatBookingScreen> {
  final Set<String> selectedSeats = {};
  final double seatPrice = 12.0;

  // Seat layout configuration
  final List<String> rows = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
  ];
  final int seatsPerRow = 10;
  final Set<String> takenSeats = {
    'F6',
    'F7',
    'F8',
    'F9',
    'G1',
    'G2',
    'H8',
    'I5',
  };

  @override
  Widget build(BuildContext context) {
    final totalPrice = selectedSeats.length * seatPrice;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Choose Seat(s)',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Cinema Screen
          Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: const Color(0xFF6B5B95), width: 3),
              ),
            ),
            child: Center(
              child: Text(
                'Cinema Screen Here',
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
            ),
          ),

          // Seat Grid
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: rows.map((row) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Row label
                          SizedBox(
                            width: 30,
                            child: Text(
                              row,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          // Seats
                          ...List.generate(seatsPerRow, (index) {
                            final seatNumber = index + 1;
                            final seatId = '$row$seatNumber';
                            final isTaken = takenSeats.contains(seatId);
                            final isSelected = selectedSeats.contains(seatId);

                            return GestureDetector(
                              onTap: isTaken
                                  ? null
                                  : () {
                                      setState(() {
                                        if (isSelected) {
                                          selectedSeats.remove(seatId);
                                        } else {
                                          selectedSeats.add(seatId);
                                        }
                                      });
                                    },
                              child: Container(
                                width: 28,
                                height: 28,
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 3,
                                ),
                                decoration: BoxDecoration(
                                  color: isTaken
                                      ? Colors.grey[400]
                                      : isSelected
                                      ? const Color(0xFF6B5B95)
                                      : Colors.grey[200],
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Center(
                                  child: Text(
                                    '$seatNumber',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: isSelected
                                          ? Colors.white
                                          : isTaken
                                          ? Colors.white
                                          : Colors.black54,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                          // Row label (right side)
                          SizedBox(
                            width: 30,
                            child: Text(
                              row,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          // Legend
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildLegendItem('Available', Colors.grey[200]!),
                _buildLegendItem('Taken', Colors.grey[400]!),
                _buildLegendItem('Selected', const Color(0xFF6B5B95)),
              ],
            ),
          ),

          // Bottom section with price and continue button
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Column(
              children: [
                // Selected seats display
                if (selectedSeats.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6B5B95).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: selectedSeats.map((seat) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF6B5B95),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            seat,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Total price',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '\$${totalPrice.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        if (selectedSeats.isNotEmpty)
                          Text(
                            'Seat(s): ${selectedSeats.join(', ')}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: selectedSeats.isEmpty
                          ? null
                          : () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ReviewSummaryScreen(
                                    movie: widget.movie,
                                    selectedSeats: selectedSeats.toList(),
                                    totalPrice: totalPrice,
                                  ),
                                ),
                              );
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6B5B95),
                        disabledBackgroundColor: Colors.grey[300],
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Continue',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
