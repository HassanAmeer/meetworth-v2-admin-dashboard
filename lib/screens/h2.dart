import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 300, child: DashboardHeader2()),
              SizedBox(height: 300, child: DashboardHeader()),
              // Top Bar
              TopBar(),

              SizedBox(height: 16),

              // Main Grid Content
              GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.5,
                children: [
                  StatsCard(
                    title: "Total Income",
                    value: "\$37.5K",
                    growth: "+2.45%",
                    child: LineChartWidget(),
                  ),
                  StatsCard(
                    title: "New Users",
                    value: "2,579",
                    growth: "+2.45%",
                    child: BarChartWidget(),
                  ),
                  StatsCard(
                    title: "Membership Chart",
                    value: "Gold: 25%",
                    growth: "+2.45%",
                    child: PieChartWidget(),
                  ),
                  StatsCard(
                    title: "World Map",
                    value: "Users by Region",
                    child: Placeholder(), // Replace with a map widget
                  ),
                  StatsCard(
                    title: "Messages",
                    value: "11,235",
                    growth: "+2.45%",
                    child: BarChartWidget(),
                  ),
                  StatsCard(
                    title: "Load Time",
                    value: "1.2 sec",
                    growth: "+2.45%",
                    child: CircularProgressIndicator(
                        value: 0.8, color: Colors.orange),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "This Month",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        IconButton(
          icon: Icon(Icons.refresh, color: Colors.white),
          onPressed: () {},
        ),
      ],
    );
  }
}

class StatsCard extends StatelessWidget {
  final String title;
  final String value;
  final String? growth;
  final Widget child;

  const StatsCard({
    required this.title,
    required this.value,
    this.growth,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: Colors.white)),
          SizedBox(height: 8),
          Text(value, style: TextStyle(color: Colors.orange, fontSize: 24)),
          if (growth != null)
            Text(growth!, style: TextStyle(color: Colors.green)),
          Expanded(child: child),
        ],
      ),
    );
  }
}

class LineChartWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: [
              FlSpot(0, 3),
              FlSpot(1, 1),
              FlSpot(2, 4),
              FlSpot(3, 3),
              FlSpot(4, 5),
            ],
            isCurved: true,
            color: Colors.orange,
          ),
        ],
      ),
    );
  }
}

class BarChartWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        barGroups: [
          BarChartGroupData(
              x: 0, barRods: [BarChartRodData(toY: 5, color: Colors.orange)]),
          BarChartGroupData(
              x: 1, barRods: [BarChartRodData(toY: 3, color: Colors.orange)]),
          BarChartGroupData(
              x: 2, barRods: [BarChartRodData(toY: 4, color: Colors.orange)]),
        ],
      ),
    );
  }
}

class PieChartWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        sections: [
          PieChartSectionData(value: 25, color: Colors.orange, title: '25%'),
          PieChartSectionData(value: 25, color: Colors.blue, title: '25%'),
          PieChartSectionData(value: 25, color: Colors.green, title: '25%'),
          PieChartSectionData(value: 25, color: Colors.red, title: '25%'),
        ],
      ),
    );
  }
}

///////////////////////////////////////// 1.

class DashboardHeader2 extends StatelessWidget {
  const DashboardHeader2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Breadcrumbs and Title
            const Text(
              'Pages / Dashboard',
              style: TextStyle(
                color: Colors.white54,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Dashboard',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            // Main Row
            Row(
              children: [
                // Left: Date Picker
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.calendar_today_outlined,
                          color: Colors.white, size: 16),
                      SizedBox(width: 8),
                      Text(
                        'This month',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                // Metrics
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MetricCard(
                        title: '2.579',
                        subtitle: 'Active Users',
                        percentage: '+2.45%',
                        percentageColor: Colors.green,
                      ),
                      MetricCard(
                        title: '2m46',
                        subtitle: 'Session Duration',
                        percentage: '+2.45%',
                        percentageColor: Colors.green,
                      ),
                      MetricCard(
                        title: '413',
                        subtitle: 'Frequency of use',
                        percentage: '+2.45%',
                        percentageColor: Colors.green,
                      ),
                      MetricCard(
                        title: '56%',
                        subtitle: 'Retention Rate',
                        percentage: '+2.45%',
                        percentageColor: Colors.green,
                      ),
                      MetricCard(
                        title: '10%',
                        subtitle: 'Churn Rate',
                        percentage: '+2.45%',
                        percentageColor: Colors.green,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                // Right: Search, Notifications, Profile, and Refresh
                Row(
                  children: [
                    Container(
                      width: 200,
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.search, color: Colors.white54, size: 20),
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
                    const Icon(Icons.notifications_none,
                        color: Colors.white, size: 24),
                    const SizedBox(width: 16),
                    ClipOval(
                      child: Image.network(
                        'https://i.pravatar.cc/300',
                        width: 32,
                        height: 32,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.refresh,
                          color: Colors.white, size: 20),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MetricCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String percentage;
  final Color percentageColor;

  const MetricCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.percentage,
    required this.percentageColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            percentage,
            style: TextStyle(
              color: percentageColor,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

///////////////////////////////////////// 1.2

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pages / Dashboard',
              style: TextStyle(
                color: Colors.white54,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Dashboard',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                // Left section
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.calendar_today_outlined,
                          color: Colors.white, size: 16),
                      SizedBox(width: 8),
                      Text(
                        'This month',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                // Metrics
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        6,
                        (index) => MetricCard(
                          title: index == 0
                              ? '2.579'
                              : index == 1
                                  ? '2m46'
                                  : index == 2
                                      ? '413'
                                      : index == 3
                                          ? '56%'
                                          : index == 4
                                              ? '10%'
                                              : 'Reload',
                          subtitle: index == 0
                              ? 'Active Users'
                              : index == 1
                                  ? 'Session Duration'
                                  : index == 2
                                      ? 'Frequency of use'
                                      : index == 3
                                          ? 'Retention Rate'
                                          : 'Churn Rate',
                          percentage: '+2.45%',
                          percentageColor: Colors.yellow,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Right section
                Row(
                  children: [
                    const Icon(Icons.search, color: Colors.white, size: 20),
                    const SizedBox(width: 16),
                    const Icon(Icons.notifications_outlined,
                        color: Colors.white, size: 20),
                    const SizedBox(width: 16),
                    ClipOval(
                      child: Image.network(
                        'https://i.pravatar.cc/300',
                        width: 32,
                        height: 32,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.refresh,
                          color: Colors.white, size: 20),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
