import 'package:flutter/material.dart';

class Booking extends StatefulWidget {
  const Booking({Key? key}) : super(key: key);

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  final List<Map<String, dynamic>> pendingServices = [
    {'category': 'Cleaning', 'service': 'Home Cleaning', 'price': '50'},
    {'category': 'Repair', 'service': 'AC Repair', 'price': '30'},
    // Add more services as needed
  ];

  final List<Map<String, dynamic>> completedServices = [
    {'category': 'Delivery', 'service': 'Parcel Delivery', 'price': '20'},
    {'category': 'Repair', 'service': 'Car Repair', 'price': '100'},
    // Add more services as needed
  ];

  @override
  Widget build(BuildContext context) {
    return  Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            serviceSection('Pending Services', pendingServices),
            serviceSection('Completed Services', completedServices),
          ],
        ),

    );
  }

  Widget serviceSection(String title, List<Map<String, dynamic>> services) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Column(
          children: services.map((service) => serviceTile(service)).toList(),
        ),
      ],
    );
  }

  Widget serviceTile(Map<String, dynamic> service) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(service['service'], style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('Category: ${service['category']}'),
        trailing: Text('\$${service['price']}', style: TextStyle(color: Colors.green)),
      ),
    );
  }
}