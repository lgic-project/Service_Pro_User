import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import 'package:service_pro_user/Provider/category_and_service_provider/service_provider.dart';
import 'package:service_pro_user/Provider/chat_user_provider.dart';
import 'package:service_pro_user/Provider/login_signup_provider/login_logout_provider.dart';
import 'package:service_pro_user/Provider/serviceRequest_provider/get_service_request_provider.dart';

class Booking extends StatefulWidget {
  const Booking({Key? key}) : super(key: key);

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  late Future<Map<String, dynamic>> _dataFuture;

  @override
  void initState() {
    super.initState();
    _dataFuture = getBothData();
  }

  Future<Map<String, dynamic>> getBothData() async {
    final requestData =
        await Provider.of<GetServiceRequest>(context, listen: false)
            .getServiceRequest(context);
    final token =
        Provider.of<LoginLogoutProvider>(context, listen: false).token;
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    final userId = decodedToken['id'];
    final allData = await Provider.of<ServiceProvider>(context, listen: false)
        .getService(context);
    final providerData =
        await Provider.of<ChatUserProvider>(context, listen: false)
            .getChatUser(context);

    return {
      'requestData': requestData,
      'allData': allData,
      'userId': userId,
      'providerData': providerData,
    };
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _dataFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final requestData =
              snapshot.data?['requestData'] as List<dynamic>? ?? [];
          final allData = snapshot.data?['allData'] as List<dynamic>? ?? [];
          final providerData =
              snapshot.data?['providerData'] as List<dynamic>? ?? [];
          final userId = snapshot.data?['userId'] as String? ?? '';

          // Categorize requests
          final pendingRequests = [],
              rejectedRequests = [],
              completedRequests = [];
          for (var request in requestData) {
            if (request['UserId'] == userId) {
              switch (request['Status']) {
                case 'pending':
                  pendingRequests.add(request);
                  break;
                case 'rejected':
                  rejectedRequests.add(request);
                  break;
                case 'completed':
                  completedRequests.add(request);
                  break;
              }
            }
          }

          // Build UI for each category
          return SingleChildScrollView(
            child: Column(
              children: [
                _buildSection('Pending', pendingRequests, Colors.orange,
                    allData, providerData),
                _buildSection('Rejected', rejectedRequests, Colors.red, allData,
                    providerData),
                _buildSection('Completed', completedRequests, Colors.green,
                    allData, providerData),
              ],
            ),
          );
        }
      },
    );
  }

  Widget _buildSection(String title, List<dynamic> requests, Color color,
      List<dynamic> allData, List<dynamic> providerData) {
    if (requests.isEmpty) return SizedBox.shrink(); // Or show a message

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          color: color,
          child: Row(
            children: [
              Icon(
                _getIconForCategory(title),
                color: Colors.white,
              ),
              SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        ...requests
            .map((request) => _buildRequestItem(request, allData, providerData))
            .toList(),
      ],
    );
  }

  IconData _getIconForCategory(String category) {
    switch (category.toLowerCase()) {
      case 'pending':
        return Icons.access_time;
      case 'rejected':
        return Icons.close;
      case 'completed':
        return Icons.check;
      default:
        return Icons.error_outline;
    }
  }

  Widget _buildRequestItem(
      dynamic request, List<dynamic> allData, List<dynamic> providerData) {
    var service = allData.firstWhere((s) => s['_id'] == request['ServiceId'],
        orElse: () => null);
    var provider = providerData.firstWhere(
        (p) => p['_id'] == request['ProviderId'],
        orElse: () => null);

    if (service == null || provider == null) return SizedBox.shrink();

    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  service['Name'] ?? '',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  Icons.person,
                  color: Colors.grey,
                ),
                SizedBox(width: 8),
                Text(
                  'Provider: ${provider['Name'] ?? ''}',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Status: ${request['Status']}',
                  style: TextStyle(
                    fontSize: 14,
                    color: _getStatusColor(request['Status']),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'rejected':
        return Colors.red;
      case 'completed':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
