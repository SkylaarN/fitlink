import 'package:flutter/material.dart';

class AnalysisPage extends StatelessWidget {
  final List<double> waterData; // Water intake data
  final List<double> stepsData; // Steps data
  final List<String> waterXAxisScale;
  final List<String> stepsXAxisScale;

  const AnalysisPage({
    Key? key,
    required this.waterData,
    required this.stepsData,
    required this.waterXAxisScale,
    required this.stepsXAxisScale,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Colors.blueGrey[900],
      child: Column(
        children: [
          // First Bar Graph (Water Intake)
          BarGraphWithScales(
            data: waterData,
            title: "Water Intake",
            xAxisLabel: "Days",
            yAxisLabel: "Liters",
            xAxisScale: waterXAxisScale,
          ),
          const SizedBox(height: 24),
          // Second Bar Graph (Steps)
          BarGraphWithScales(
            data: stepsData,
            title: "Steps",
            xAxisLabel: "Days",
            yAxisLabel: "Steps (in thousands)",
            xAxisScale: stepsXAxisScale,
            isSmaller: true, 
          ),
        ],
      ),
    );
  }
}

class BarGraphWithScales extends StatelessWidget {
  final List<double> data; // List of data points (values between 0 and 1)
  final String title;
  final String xAxisLabel;
  final String yAxisLabel;
  final List<String> xAxisScale;
  final bool isSmaller; 

  const BarGraphWithScales({
    Key? key,
    required this.data,
    required this.title,
    required this.xAxisLabel,
    required this.yAxisLabel,
    required this.xAxisScale,
    this.isSmaller = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.blueGrey[800],
        borderRadius: BorderRadius.circular(12),
      ),
      width: isSmaller ? MediaQuery.of(context).size.width * 0.85 : double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: isSmaller ? 120 : 200, 
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Y-axis scale
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    6, // Number of Y-axis ticks
                    (index) => Text(
                      '${(1.0 - index * 0.2).toStringAsFixed(1)}', // Y-axis scale
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // Bar graph
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: data.map((value) {
                          final barHeight = value * constraints.maxHeight;
                          return Container(
                            width: constraints.maxWidth / (data.length * 2),
                            height: barHeight,
                            decoration: BoxDecoration(
                              color: Colors.lightBlue,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // X-axis scale
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: xAxisScale.map((label) {
              return Text(
                label,
                style: const TextStyle(color: Colors.white, fontSize: 12),
              );
            }).toList(),
          ),
          const SizedBox(height: 8),
          // X-axis label
          Align(
            alignment: Alignment.center,
            child: Text(
              xAxisLabel,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
