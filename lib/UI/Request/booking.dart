import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_pro_user/Provider/serviceRequest_provider/get_service_request_provider.dart';

class Booking extends StatefulWidget {
  const Booking({Key? key}) : super(key: key);

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: Provider.of<GetServiceRequest>(context, listen: false)
            .getServiceRequest(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                var serviceRequest = snapshot.data?[index];
                return ListTile(
                  title: Text(serviceRequest['Status'] ??
                      ''), // Replace 'title' with the actual key for the title in your service request data
                  // subtitle: Text(serviceRequest[
                  //     'description']??''), // Replace 'description' with the actual key for the description in your service request data
                );
              },
            );
          }
        },
      ),
    );
  }
}
