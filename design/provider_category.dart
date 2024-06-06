import 'package:flutter/material.dart';

class HomeCleaningPage extends StatelessWidget {
  final List<Map<String, dynamic>> providers = [
    {
      'name': 'Smith Jones',
      'rate': '\$40',
      'rating': 4.5,
      'image': 'assets/provider.jpg',
      'status': 'Available'
    },
    {
      'name': 'Martin Jacob',
      'rate': '\$40',
      'rating': 4.0,
      'image': 'assets/provider.jpg',
      'status': 'Unavailable'
    },
    {
      'name': 'Zakir Vasim',
      'rate': '\$40',
      'rating': 4.8,
      'image': 'assets/provider.jpg',
      'status': 'Unavailable'
    },
    {
      'name': 'Johnson Smith',
      'rate': '\$40',
      'rating': 4.3,
      'image': 'assets/provider.jpg',
      'status': 'Unavailable'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 250,
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.arrow_back, color: Colors.black),
                        SizedBox(height: 16),
                        Text(
                          'Home Cleaning',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Proper Cleaning & Sanitization Services',
                          style:
                              TextStyle(fontSize: 16, color: Colors.grey[700]),
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            for (int i = 0; i < 5; i++)
                              Icon(Icons.star, color: Colors.amber, size: 20),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: 16,
                  top: 50,
                  child: Image.asset(
                    'assets/cleaning_supplies.jpg',
                    height: 100,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Available Providers',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: providers.length,
              itemBuilder: (context, index) {
                final provider = providers[index];
                return ProviderCard(
                  name: provider['name'],
                  rate: provider['rate'],
                  rating: provider['rating'],
                  image: provider['image'],
                  status: provider['status'],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ProviderCard extends StatelessWidget {
  final String name;
  final String rate;
  final double rating;
  final String image;
  final String status;

  ProviderCard({
    required this.name,
    required this.rate,
    required this.rating,
    required this.image,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(image),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    if (status == 'Available')
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          status,
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  'Rate: $rate',
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    for (int i = 0; i < rating.toInt(); i++)
                      Icon(Icons.star, color: Colors.amber, size: 20),
                    if (rating - rating.toInt() > 0)
                      Icon(Icons.star_half, color: Colors.amber, size: 20),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 16),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              shadowColor: Colors.orange,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text(
              'Book Now',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
