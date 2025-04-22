import 'package:car_rental/data/models/car.dart';
import 'package:car_rental/presentation/pages/booking_receipt_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CarBookForm extends StatefulWidget {
  final Car car;
  const CarBookForm({super.key, required this.car});

  @override
  State<CarBookForm> createState() => _CarBookFormState();
}

class _CarBookFormState extends State<CarBookForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;

  Future<void> _selectDate(BuildContext context, bool isStart) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Book Car')),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${widget.car.model}',
                style: GoogleFonts.nunito(
                  textStyle: Theme.of(context).textTheme.titleLarge,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Your Name'),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Enter your name'
                            : null,
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Your Email'),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Enter your email'
                            : null,
              ),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Enter your phone number'
                            : null,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _startDate == null
                          ? 'Start Date'
                          : _startDate!.toLocal().toString().split(' ')[0],
                    ),
                  ),
                  TextButton(
                    onPressed: () => _selectDate(context, true),
                    child: const Text('Select'),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _endDate == null
                          ? 'End Date'
                          : _endDate!.toLocal().toString().split(' ')[0],
                    ),
                  ),
                  TextButton(
                    onPressed: () => _selectDate(context, false),
                    child: const Text('Select'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate() &&
                      _startDate != null &&
                      _endDate != null) {
                    // Handle booking logic here
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Booking submitted!')),
                    );
                    //navigate to booking receipt page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => BookingReceiptPage(
                              carModel: widget.car.model,

                              userName: _nameController.text,
                              phoneNumber: _phoneController.text,
                              email: _emailController.text,

                              startDate: _startDate!,
                              endDate: _endDate!,
                            ),
                      ),
                    );
                  }
                },
                child: const Text('Book Now'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
