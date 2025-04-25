import 'package:http/http.dart' as http;
import 'dart:convert';

class EmailService {
  static const String _serviceId = 'service_x5d16tk';
  static const String _templateId = 'template_4nb05m6';
  static const String _userId = 'qHzuDrsMbfzwoLz7X';

  static Future<void> sendBookingEmail({
    required String name,
    required String email,
    required String carModel,
    required String phone,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'service_id': _serviceId,
        'template_id': _templateId,
        'user_id': _userId,
        'template_params': {
          'to_email': email,
          'user_name': name,
          'car_model': carModel,
          'phone': phone,
          'start_date': startDate.toLocal().toString().split(' ')[0],
          'end_date': endDate.toLocal().toString().split(' ')[0],
        },
      }),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to send email: \\${response.body}');
    }
  }
}
