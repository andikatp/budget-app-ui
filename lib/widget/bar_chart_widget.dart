import 'package:flutter/material.dart';

class BarChartWidget extends StatelessWidget {
  const BarChartWidget({super.key, required this.expenses});

  final List<double> expenses;
  @override
  Widget build(BuildContext context) {
    double mostExpensive = 0;
    for (var price in expenses) {
      if (price > mostExpensive) {
        mostExpensive = price;
      }
    }

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          const Center(
            child: Text(
              'Weekly Spending',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {},
                iconSize: 30.0,
                icon: const Icon(Icons.arrow_back),
              ),
              const Text(
                'Nov 10, 2019 - Nov 16, 2019',
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2),
              ),
              IconButton(
                onPressed: () {},
                iconSize: 30.0,
                icon: const Icon(Icons.arrow_forward),
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Bar(
                label: 'Su',
                amountSpend: expenses[0],
                mostExpensive: mostExpensive,
              ),
              Bar(
                label: 'Mo',
                amountSpend: expenses[1],
                mostExpensive: mostExpensive,
              ),
              Bar(
                label: 'Tu',
                amountSpend: expenses[2],
                mostExpensive: mostExpensive,
              ),
              Bar(
                label: 'We',
                amountSpend: expenses[3],
                mostExpensive: mostExpensive,
              ),
              Bar(
                label: 'Th',
                amountSpend: expenses[4],
                mostExpensive: mostExpensive,
              ),
              Bar(
                label: 'Fr',
                amountSpend: expenses[5],
                mostExpensive: mostExpensive,
              ),
              Bar(
                label: 'Sta',
                amountSpend: expenses[6],
                mostExpensive: mostExpensive,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class Bar extends StatelessWidget {
  const Bar({
    super.key,
    required this.label,
    required this.amountSpend,
    required this.mostExpensive,
  });

  final String label;
  final double amountSpend;
  final double mostExpensive;

  final double _maxBarHeight = 150.0;

  @override
  Widget build(BuildContext context) {
    final barHeight = amountSpend / mostExpensive * _maxBarHeight;
    return Column(
      children: [
        Text(
          '\$${amountSpend.toStringAsFixed(2)}',
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          height: 6.0,
        ),
        Container(
          height: barHeight,
          width: 18.0,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(6.0),
          ),
        ),
        const SizedBox(
          height: 8.0,
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
