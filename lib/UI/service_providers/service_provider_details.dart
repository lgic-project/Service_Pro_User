import 'package:flutter/material.dart';
import 'package:service_pro_user/UI/chat/chat_screen.dart';

class ServiceProviderDetails extends StatefulWidget {
  final providerId;
  final providerName;
  final providerProfile;
  final providerAddress;
  final providerPhone;
  final providerEmail;
  final providerServiceTotal;
  final providerServiceCompleted;

  const ServiceProviderDetails({
    super.key,
    this.providerId,
    required this.providerName,
    this.providerProfile,
    required this.providerAddress,
    this.providerPhone,
    this.providerEmail,
    this.providerServiceTotal,
    this.providerServiceCompleted,
  });

  @override
  State<ServiceProviderDetails> createState() => _ServiceProviderDetailsState();
}

class _ServiceProviderDetailsState extends State<ServiceProviderDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(widget.providerName),
        ),
        backgroundColor: const Color(0xFF43cbac),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  height: 200.0,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue, Colors.purple],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: ListView.builder(
                    itemCount: widget.providerProfile?.length ?? 0,
                    itemBuilder: (context, index) {
                      return Image.network(widget.providerProfile);
                    },
                    scrollDirection: Axis.horizontal,
                  ),
                ),
                Positioned(
                  bottom: -50.0,
                  child: CircleAvatar(
                    radius: 50.0,
                    backgroundImage: widget.providerProfile != null
                        ? NetworkImage(widget.providerProfile)
                        : null, // or some default image
                  ),
                ),
              ],
            ),
            const SizedBox(height: 60.0),
            Container(
              child: Text(
                widget.providerName,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            Card(
              color: const Color(0xFF43cbac),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              margin: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Text(
                    //   widget.providerName,
                    //   style: const TextStyle(
                    //       fontSize: 24.0,
                    //       fontWeight: FontWeight.bold,
                    //       color: Colors.white),
                    // ),
                    Text(
                      'Address: ${widget.providerAddress}',
                      style: TextStyle(fontSize: 17.0, color: Colors.white),
                    ),
                    Text(
                      'Total Services: ${widget.providerServiceTotal}',
                      style: TextStyle(fontSize: 17.0, color: Colors.white),
                    ),
                    Text(
                      'Completed Services: ${widget.providerServiceCompleted}',
                      style: TextStyle(fontSize: 17.0, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(
                          providerId: widget.providerId ?? '',
                          providerName: widget.providerName ?? '',
                          providerImage: widget.providerProfile ?? '',
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.chat),
                  label: const Text('Chat'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xFF43cbac),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.book),
                  label: const Text('Book'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xFF43cbac),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
              ],
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'About',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                'Vestibulum vehicula ex eu gravida luctus. Donec vitae arcu '
                'sed tortor facilisis consectetur.',
                textAlign: TextAlign.center,
              ),
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Ratings',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return const Icon(Icons.star, color: Colors.amber);
                }),
              ),
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Reviews',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
            Column(
              children: [
                Card(
                  color: const Color(0xFF43cbac),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 3.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: const ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          AssetImage('assets/profile/default_profile.jpg'),
                    ),
                    title: Text('Reviewer 1',
                        style: TextStyle(color: Colors.white)),
                    subtitle: Text('Great service!',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
                Card(
                  color: const Color(0xFF43cbac),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 3.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: const ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          AssetImage('assets/profile/default_profile.jpg'),
                    ),
                    title: Text('Reviewer 2',
                        style: TextStyle(color: Colors.white)),
                    subtitle: Text('Very satisfied with the work.',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.report),
        backgroundColor: const Color(0xFF43cbac),
      ),
    );
  }
}
