import 'package:audioplayers/audioplayers.dart';
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
  final AudioPlayer _audioPlayer = AudioPlayer();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
  }

  Future<void> _playCarSound() async {
    await _audioPlayer.play(AssetSource('audio/car_trim.mp3'));
  }

  Future<void> _stopCarSound() async {
    await _audioPlayer.stop();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

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
          padding: EdgeInsets.all(
            MediaQuery.of(context).size.width < 400 ? 8.0 : 16.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Car Model Name
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width < 400 ? 8 : 12,
                  vertical: MediaQuery.of(context).size.width < 400 ? 4 : 6,
                ),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(
                    255,
                    248,
                    223,
                    2,
                  ).withOpacity(0.3), // Highlight color
                  borderRadius: BorderRadius.circular(
                    MediaQuery.of(context).size.width < 400 ? 8 : 12,
                  ),
                ),
                child: Text(
                  widget.car.model,
                  style: GoogleFonts.exo2(
                    textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize:
                          MediaQuery.of(context).size.width < 400
                              ? 18
                              : Theme.of(
                                context,
                              ).textTheme.titleLarge?.fontSize,
                    ),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              // Name
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Your Name',
                  labelStyle: TextStyle(
                    color: Colors.grey[800],
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                  filled: true,
                  fillColor: Colors.yellow.withOpacity(0.08),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.amber.shade200,
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.amber.shade700,
                      width: 2,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.red.shade300,
                      width: 1.5,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.red.shade700,
                      width: 2,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Enter your name'
                            : null,
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.015),
              //EMAIL
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Your Email',
                  labelStyle: TextStyle(
                    color: Colors.grey[800],
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                  filled: true,
                  fillColor: Colors.yellow.withOpacity(0.08),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.amber.shade200,
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.amber.shade700,
                      width: 2,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.red.shade300,
                      width: 1.5,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.red.shade700,
                      width: 2,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Enter your name'
                            : null,
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.015),
              //PHONE NUMBER
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Your Phone Number',
                  labelStyle: TextStyle(
                    color: Colors.grey[800],
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                  filled: true,
                  fillColor: Colors.yellow.withOpacity(0.08),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.amber.shade200,
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.amber.shade700,
                      width: 2,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.red.shade300,
                      width: 1.5,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.red.shade700,
                      width: 2,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Enter your name'
                            : null,
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.015),
              // Start Date
              InkWell(
                onTap: () => _selectDate(context, true),
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Start Date',
                    labelStyle: TextStyle(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                    filled: true,
                    fillColor: Colors.yellow.withOpacity(0.08),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Colors.amber.shade200,
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Colors.amber.shade700,
                        width: 2,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                  child: Text(
                    _startDate == null
                        ? 'Select start date'
                        : _startDate!.toLocal().toString().split(' ')[0],
                    style: TextStyle(
                      color:
                          _startDate == null ? Colors.grey[600] : Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              // End Date
              InkWell(
                onTap: () => _selectDate(context, false),
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'End Date',
                    labelStyle: TextStyle(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                    filled: true,
                    fillColor: Colors.yellow.withOpacity(0.08),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Colors.amber.shade200,
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Colors.amber.shade700,
                        width: 2,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                  child: Text(
                    _endDate == null
                        ? 'Select end date'
                        : _endDate!.toLocal().toString().split(' ')[0],
                    style: TextStyle(
                      color: _endDate == null ? Colors.grey[600] : Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.02),

              // Book Now Button
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber.shade700,
                    foregroundColor: Colors.white,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate() &&
                        _startDate != null &&
                        _endDate != null) {
                      // Show loading dialog
                      _showLoadingDialog(context);

                      await _playCarSound();

                      // Wait for 3 seconds
                      await Future.delayed(const Duration(seconds: 3));

                      // Stop car sound
                      await _stopCarSound();

                      // Dismiss loading dialog
                      Navigator.of(context).pop();

                      // Handle booking logic here
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Booking submitted!'),
                          backgroundColor:
                              Colors.amber.shade700, // Changed background color
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                      //
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
