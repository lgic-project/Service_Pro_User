import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:service_pro_user/Models/category_model.dart';

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
          title: Text(widget.category.name!),
        ),
        body: Container(
          padding: const EdgeInsets.only(top: 10),
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
              ? const Center(child: Text('No services found'))
              : ListView.builder(
                  itemCount: services.length,
                  itemBuilder: (context, index) {
                    final serviceData = services[index];
                    String image = serviceData['Image'].toString();
                    image = image.replaceFirst('localhost', '10.0.2.2');
                    return Container(
                      height: 200,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: CachedNetworkImage(
                                imageUrl: image,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Lottie.asset(
                                      'assets/lotties_animation/loading.json',
                                    ),
                                errorWidget: (context, url, error) =>
                                    Lottie.asset(
                                        'assets/lotties_animation/error.json')),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Colors.transparent, Colors.black54],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            left: 10,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  serviceData['Name'],
                                  style: const TextStyle(
                                      fontSize: 24, color: Colors.white),
                                ),
                                Text(
                                  serviceData['Description'],
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ));
  }
}
