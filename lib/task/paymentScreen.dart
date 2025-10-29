import 'package:flutter/material.dart';
import 'package:project/task/PaymentSuccessScreen.dart';
import 'PaymentSuccessScreen.dart';

class PaymentScreen extends StatefulWidget {
  final double totalAmount;

  const PaymentScreen({Key? key, required this.totalAmount}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String selectedPayment = 'visa';

  final List<Map<String, dynamic>> paymentMethods = [
    {
      'id': 'paypal',
      'name': 'PayPal',
      'icon': Icons.paypal,
      'color': const Color(0xFF0070BA),
    },
    {
      'id': 'google',
      'name': 'Google Pay',
      'icon': Icons.g_mobiledata,
      'color': const Color(0xFF4285F4),
    },
    {
      'id': 'apple',
      'name': 'Apple Pay',
      'icon': Icons.apple,
      'color': Colors.black,
    },
    {
      'id': 'mastercard',
      'name': '**** **** **** 4679',
      'icon': Icons.credit_card,
      'color': const Color(0xFFEB001B),
    },
    {
      'id': 'visa',
      'name': '**** **** **** 5567',
      'icon': Icons.credit_card,
      'color': const Color(0xFF1A1F71),
    },
  ];

  @override
  Widget build(BuildContext context) {
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
              'Choose Payment Method',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(
              '05:54',
              style: TextStyle(
                color: const Color(0xFF6B5B95),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: paymentMethods.length,
              itemBuilder: (context, index) {
                final method = paymentMethods[index];
                final isSelected = selectedPayment == method['id'];

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedPayment = method['id'];
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFF6B5B95)
                            : Colors.grey[300]!,
                        width: isSelected ? 2 : 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: method['color'].withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            method['icon'],
                            color: method['color'],
                            size: 30,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            method['name'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        if (isSelected)
                          const Icon(
                            Icons.check_circle,
                            color: Color(0xFF6B5B95),
                            size: 24,
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Add New Payment Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: OutlinedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Add payment method coming soon!'),
                  ),
                );
              },
              icon: const Icon(Icons.add, color: Color(0xFF6B5B95)),
              label: const Text(
                'Add New Payment',
                style: TextStyle(
                  color: Color(0xFF6B5B95),
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                side: const BorderSide(color: Color(0xFF6B5B95)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Confirm Payment Button
          Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: () {
                // Navigate to success screen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PaymentSuccessScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6B5B95),
                minimumSize: const Size.fromHeight(56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
              ),
              child: Text(
                'Confirm Payment - \$${widget.totalAmount.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
