import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:service_pro_user/Models/category_model.dart';
import 'package:service_pro_user/Provider/chat_user_provider.dart';

class Service extends StatefulWidget {
  final CategoryModel category;
  const Service({super.key, required this.category});

  @override
  State<Service> createState() => _ServiceState();
}

class _ServiceState extends State<Service> {
  @override
  Widget build(BuildContext context) {
    List<dynamic>? services = widget.category.services;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          widget.category.name!,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).primaryColor,
              Colors.white,
            ],
          ),
        ),
        child: services == null
            ? const Center(
                child: Text(
                  'No services found',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            : ListView.separated(
                itemCount: services.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final serviceData = services[index];
                  String image = serviceData['Image'].toString();
                  image = image.replaceFirst('localhost', '20.52.185.247');
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ServiceProviders(category: widget.category),
                            ),
                          );
                        },
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: CachedNetworkImage(
                                  imageUrl: image,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Lottie.asset(
                                    'assets/lotties_animation/error.json',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                gradient: const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [Colors.transparent, Colors.black54],
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 16,
                              left: 16,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    serviceData['Name'],
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          serviceData['Description'],
                                          style: const TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 16,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}

class ServiceProviders extends StatefulWidget {
  final CategoryModel category;
  const ServiceProviders({Key? key, required this.category});

  @override
  _ServiceProvidersState createState() => _ServiceProvidersState();
}

class _ServiceProvidersState extends State<ServiceProviders> {
  List<dynamic> filteredServiceProviders = [];

  @override
  void initState() {
    super.initState();
    filterServiceProviders();
  }

  // Method to filter service providers based on service IDs
  void filterServiceProviders() {
    // Get the list of service providers from the provider
    List<dynamic> allServiceProviders =
        Provider.of<ChatUserProvider>(context, listen: false).users;

    // Get the service IDs from the current category
    List<String> serviceIds = widget.category.services!
        .map((service) => service['serviceId'].toString())
        .toList();

    // Filter service providers based on service IDs
    filteredServiceProviders = allServiceProviders
        .where((provider) =>
    provider['Services'] != null &&
        provider['Services'].any((serviceId) => serviceIds.contains(serviceId)))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Service Providers'),
      ),
      body: ListView.builder(
        itemCount: filteredServiceProviders.length,
        itemBuilder: (context, index) {
          // Access the details of each filtered service provider
          var serviceProvider = filteredServiceProviders[index];
          String name = serviceProvider['Name'] ?? 'Name not available';
          String email = serviceProvider['Email'] ?? 'Email not available';
          String phoneNumber = serviceProvider['PhoneNo']?.toString() ?? 'Phone number not available';
          String address = serviceProvider['Address'] ?? 'Address not available';
          String imageUrl = serviceProvider['Image'] != null && serviceProvider['Image'].isNotEmpty
              ? serviceProvider['Image'][0]
              : 'https://via.placeholder.com/150'; // Placeholder image URL

          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(imageUrl),
            ),
            title: Text(name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(email),
                Text(phoneNumber),
                Text(address),
              ],
            ),
          );
        },
      ),
    );
  }
}



