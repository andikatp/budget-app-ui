import 'package:budget_app_udemy/data/data.dart';
import 'package:budget_app_udemy/helpers/color_helper.dart';
import 'package:budget_app_udemy/screens/category_screen.dart';
import 'package:budget_app_udemy/widget/bar_chart_widget.dart';
import 'package:flutter/material.dart';
import 'package:budget_app_udemy/models/category_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  _buildCategory(Category category, double totalAmountSpent) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CategoryScreen(category: category),
          )),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        margin: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 10.0,
        ),
        height: 100.0,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: const [
            BoxShadow(
                color: Colors.black12, offset: Offset(0, 2), blurRadius: 6.0),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  category.name,
                  style: const TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.w600),
                ),
                Text(
                  '\$${(category.maxAmount - totalAmountSpent).toStringAsFixed(2)} / \$${category.maxAmount.toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontSize: 16.0, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final double maxBarWidth = constraints.maxWidth;
                final double percent = (category.maxAmount - totalAmountSpent) /
                    category.maxAmount;
                double barWidth = percent * maxBarWidth;

                if (barWidth <= 0) {
                  barWidth = 0;
                }
                return Stack(
                  children: [
                    Container(
                      height: 20.0,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    Container(
                      height: 20.0,
                      width: barWidth,
                      decoration: BoxDecoration(
                        color: getColor(context, percent),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    )
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            forceElevated: true,
            floating: true,
            expandedHeight: 100,
            flexibleSpace: const FlexibleSpaceBar(
              title: Text('Simple Budget'),
              centerTitle: true,
            ),
            leading: IconButton(
              iconSize: 30.0,
              onPressed: () {},
              icon: const Icon(Icons.settings),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                iconSize: 30,
                icon: const Icon(Icons.add),
              )
            ],
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index == 0) {
                  return Container(
                    margin: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0, 2),
                            blurRadius: 6.0),
                      ],
                    ),
                    child: BarChartWidget(expenses: weeklySpending),
                  );
                } else {
                  final Category category = categories[index - 1];
                  double totalAmountSpent = 0;
                  for (var expense in category.expenses) {
                    totalAmountSpent += expense.cost;
                  }
                  return _buildCategory(category, totalAmountSpent);
                }
              },
              childCount: 1 + categories.length,
            ),
          ),
        ],
      ),
    );
  }
}
