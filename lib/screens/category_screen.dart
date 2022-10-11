import 'package:budget_app_udemy/helpers/color_helper.dart';
import 'package:budget_app_udemy/widget/radial_painter_widget.dart';
import 'package:flutter/material.dart';
import '../models/category_model.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key, required this.category});
  final Category category;

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  _buildExpenses() {
    List<Widget> expensesList = [];
    for (var expense in widget.category.expenses) {
      expensesList.add(Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        height: 80.0,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                expense.name,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '-\$${expense.cost.toStringAsFixed(2)}',
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ));
    }
    return Column(
      children: expensesList,
    );
  }

  @override
  Widget build(BuildContext context) {
    double totalAmountSpent = 0;
    for (var expense in widget.category.expenses) {
      totalAmountSpent += expense.cost;
    }
    final double amountLeft = widget.category.maxAmount - totalAmountSpent;
    final double percent = amountLeft / widget.category.maxAmount;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.name),
        centerTitle: true,
        actions: [
          IconButton(
            iconSize: 30.0,
            onPressed: () {},
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(20.0),
            padding: const EdgeInsets.all(20.0),
            height: 250.0,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, 2),
                  blurRadius: 6.0,
                ),
              ],
            ),
            child: CustomPaint(
              foregroundPainter: RadialPainter(
                  bgColor: Colors.grey.shade200,
                  lineColor: getColor(context, percent),
                  percent: percent,
                  width: 15.0),
              child: Center(
                child: Text(
                  '\$${amountLeft.toStringAsFixed(2)} / \$${widget.category.maxAmount}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          _buildExpenses(),
        ],
      )),
    );
  }
}
