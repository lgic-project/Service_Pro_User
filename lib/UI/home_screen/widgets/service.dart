import 'package:flutter/material.dart';
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
              ? Center(child: Text('No services found'))
              : ListView.builder(
                  itemCount: services.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(services[index]['Name']),
                      subtitle: Text(services[index]['Description']),
                      trailing: Text('Price: ${services[index]['Price']}'),
                    );
                  },
                ),
        ));
  }
}
