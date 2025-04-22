import 'package:flutter/material.dart';

class BookingReceiptPage extends StatelessWidget {
  final String carModel;
  final String userName;
  final String phoneNumber;
  final String email;
  final DateTime startDate;
  final DateTime endDate;

  const BookingReceiptPage({
    super.key,
    required this.carModel,
    required this.userName,
    required this.phoneNumber,
    required this.email,
    required this.startDate,
    required this.endDate,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Booking Receipt')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 64,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Text(
                      'Booking Confirmed!',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Car Model:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(carModel),
                  const SizedBox(height: 12),
                  Text('Name:', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(userName),
                  const SizedBox(height: 12),
                  Text(
                    'Phone Number:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(phoneNumber),
                  const SizedBox(height: 12),
                  Text(
                    'Start Date:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('${startDate.toLocal()}'.split(' ')[0]),
                  const SizedBox(height: 12),
                  Text(
                    'End Date:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('${endDate.toLocal()}'.split(' ')[0]),
                  const SizedBox(height: 24),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();

                        Navigator.of(context).pop();

                        Navigator.of(context).pop();

                        Navigator.of(context).pop();
                      },
                      child: const Text('Done'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
