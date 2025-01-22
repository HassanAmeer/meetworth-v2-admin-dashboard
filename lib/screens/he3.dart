import 'package:flutter/material.dart';

class HomePage3 extends StatelessWidget {
  const HomePage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            SizedBox(child: DashboardHeader()),
            SizedBox(child: CardsWidget()),
          ],
        ));
  }
}

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          // Left: Title and Breadcrumb
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Pages / Dashboard',
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Dashboard',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          // Right: Search, Icons, and Profile
          Row(children: [
            // Search Bar
            Container(
              width: 200,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: const [
                  Icon(Icons.search, color: Colors.white54, size: 18),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Search',
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            // Notification Icon
            const Icon(Icons.notifications_outlined,
                color: Colors.white, size: 24),
            const SizedBox(width: 16),
            // Info Icon
            const Icon(Icons.info_outline, color: Colors.white, size: 24),
            const SizedBox(width: 16),
            // Profile Image
            ClipOval(
                child: Image.network('https://i.pravatar.cc/300',
                    width: 36, height: 36, fit: BoxFit.cover))
          ])
        ]));
  }
}

class CardsWidget extends StatelessWidget {
  const CardsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13.0, vertical: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildCard('This month', '', null),
              _buildCard('Active Users', '2,579', '+2.45%'),
              _buildCard('Session Duration', '2m46', '+2.45%'),
              _buildCard('Frequency of Use', '413', '+2.45%'),
              _buildCard('Retention Rate', '56%', '+2.45%'),
              _buildCard('Churn Rate', '10%', '+2.45%'),
              _buildIconCard(Icons.refresh),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(String title, String value, String? percentage) {
    return Container(
      padding: const EdgeInsets.all(13.0),
      decoration: BoxDecoration(
          color: const Color(0xFF1C1C1C),
          borderRadius: BorderRadius.circular(12)),
      width: 150,
      height: 85,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title,
                style: const TextStyle(color: Colors.white, fontSize: 12)),
            const SizedBox(height: 8),
            Row(children: [
              Text(value,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              const SizedBox(width: 4),
              if (percentage != null)
                Text(percentage,
                    style: const TextStyle(color: Colors.green, fontSize: 12))
            ])
          ]),
    );
  }

  Widget _buildIconCard(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1C),
        borderRadius: BorderRadius.circular(12),
      ),
      width: 80,
      height: 80,
      child: Center(
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }
}
