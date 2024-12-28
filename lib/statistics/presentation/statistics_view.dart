import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_note/shared/bloc/helpers/status.dart';
import 'package:hive_note/statistics/bloc/statistics_bloc.dart';
import 'package:fl_chart/fl_chart.dart';

class StatisticsView extends StatelessWidget {
  const StatisticsView({super.key});

  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatisticsBloc, StatisticsState>(
      builder: (context, state) {
        if (state.status == Status.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is FeedingStatisticsState && state.graphData != null && state.graphData!.isNotEmpty) {
          return _buildFeedingGraph(state);
        } else if (state is HarvestStatisticsState && state.graphData != null && state.graphData!.isNotEmpty) {
          return _buildHarvestGraph(state);
        } else if (state is FinancesStatisticsState && state.graphData != null && state.graphData!.isNotEmpty) {
          return _buildFinancesGraph(state);
        } else {
            return Center(child: Text('no_data_available'.tr()));
        }
      },
    );
  }

  Widget _buildFeedingGraph(FeedingStatisticsState state) {
    return SingleChildScrollView(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Builder(
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 16.0),
              child: SizedBox(
                width: max(
                  MediaQuery.of(context).size.width,
                  state.graphData!.length * 150.0,
                ),
                height: MediaQuery.of(context).size.height * 0.8,
                child: Column(
                  children: [
                    Expanded(
                      flex: 4,
                      child: BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceAround,
                          groupsSpace: 20,
                          maxY: state.graphData!.values.reduce((a, b) => a > b ? a : b) * 1.1,
                          barGroups: _createBarGroups(state.graphData!),
                          titlesData: FlTitlesData(
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  if (value.toInt() >= state.graphData!.keys.length) return const Text('');
                                  return RotatedBox(
                                    quarterTurns: 1,
                                    child: Text(
                                      state.graphData!.keys.elementAt(value.toInt()),
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  );
                                },
                                reservedSize: 60,
                              ),
                            ),
                            rightTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            topTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            leftTitles: AxisTitles(
                              axisNameSize: 20,
                              axisNameWidget: Text('liters'.tr()),
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 60,
                                getTitlesWidget: (value, meta) {
                                  return Text(
                                    value.toStringAsFixed(1) + 'L',
                                    style: const TextStyle(fontSize: 12),
                                  );
                                },
                              ),
                            ),
                          ),
                          gridData: FlGridData(show: true),
                          borderData: FlBorderData(show: false),
                          barTouchData: BarTouchData(
                            enabled: true,
                            touchTooltipData: BarTouchTooltipData(
                              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                                final feedType = state.graphData!.keys.elementAt(group.x.toInt());
                                final amount = state.graphData![feedType] ?? 0.0;
                                return BarTooltipItem(
                                  '$feedType\n${amount.toStringAsFixed(1)}L',
                                  const TextStyle(color: Colors.white),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            );
          }
        ),
      ),
    );
  }

  Widget _buildHarvestGraph(HarvestStatisticsState state) {
    final usedJarTypes = <String>{};
    state.detailedGraphData.values.forEach((jarData) {
      usedJarTypes.addAll(jarData.keys.where((key) => jarData[key]! > 0));
    });

    final jarColors = {
      'jar_0.7l': Colors.blue[200],
      'jar_1.0l': Colors.blue[400],
      'jar_1.5l': Colors.blue[600],
      'jar_2.0l': Colors.blue[800],
      'custom_liters': Colors.blue[900],
    };

    return SingleChildScrollView(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Builder(
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.only(top: 40.0), // Added top padding
              child: SizedBox(
                width: max(
                  MediaQuery.of(context).size.width,
                  state.graphData!.length * 150.0,
                ),
                height: MediaQuery.of(context).size.height * 0.8,
                child: Column(
                  children: [
                    Expanded(
                      flex: 4,
                      child: BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceAround,
                          groupsSpace: 20,
                          maxY: state.graphData!.values.reduce((a, b) => a > b ? a : b) * 1.1,
                          barGroups: _createStackedBarGroups(state),
                          titlesData: FlTitlesData(
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  if (value.toInt() >= state.graphData!.keys.length) return const Text('');
                                  return RotatedBox(
                                    quarterTurns: 1,
                                    child: Text(
                                      state.graphData!.keys.elementAt(value.toInt()),
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  );
                                },
                                reservedSize: 60,
                              ),
                            ),
                            rightTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            topTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            leftTitles: AxisTitles(
                              axisNameSize: 20,
                              axisNameWidget: Text('liters'.tr()),
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 60,
                                getTitlesWidget: (value, meta) {
                                  return Text(
                                    value.toStringAsFixed(1) + 'L',
                                    style: const TextStyle(fontSize: 12),
                                  );
                                },
                              ),
                            ),
                          ),
                          gridData: FlGridData(show: true),
                          borderData: FlBorderData(show: false),
                          barTouchData: BarTouchData(
                            enabled: true,
                            touchTooltipData: BarTouchTooltipData(
                              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                                final honeyType = state.graphData!.keys.elementAt(group.x.toInt());
                                final jarData = state.detailedGraphData[honeyType];
                                if (jarData == null) return null;
                                
                                // final sortedJarTypes = jarData.keys.where((key) => jarData[key]! > 0).toList()..sort();
                                // final total = jarData.values.reduce((a, b) => a + b);
                                
                                return BarTooltipItem(
                                  '${jarData.entries.where((e) => e.value > 0).map((e) {
                                    if (e.key == 'custom_liters') {
                                      return '${e.key}: ${e.value.toStringAsFixed(1)}L';
                                    }
                                    final jarVolume = double.tryParse(e.key.substring(4, e.key.length - 1)) ?? 1.0;
                                    final jarCount = (e.value / jarVolume).round();
                                    return '${e.key}: $jarCount × ${jarVolume}L';
                                  }).join('\n')}',
                                  const TextStyle(color: Colors.white),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Legend
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: usedJarTypes.map((jarType) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            children: [
                              Container(
                                width: 16,
                                height: 16,
                                color: jarColors[jarType],
                              ),
                              const SizedBox(width: 4),
                              Text(jarType),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            );
          }
        ),
      ),
    );
  }

  Widget _buildFinancesGraph(FinancesStatisticsState state) {
    // Calculate the maximum value for Y axis scaling
    final maxValue = state.detailedGraphData.values
        .expand((type) => type.values)
        .reduce((a, b) => a > b ? a : b);
    
    final hasBuy = state.detailedGraphData.values.any((type) => (type['Buy'] ?? 0) > 0);
    final hasSell = state.detailedGraphData.values.any((type) => (type['Sell'] ?? 0) > 0);

    // Calculate totals
    double totalBuy = 0;
    double totalSell = 0;
    
    state.detailedGraphData.values.forEach((typeData) {
      totalBuy += typeData['Buy'] ?? 0;
      totalSell += typeData['Sell'] ?? 0;
    });
    
    final earnings = totalSell - totalBuy;

    return SingleChildScrollView(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Builder(
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 16.0),
              child: SizedBox(
                width: max(
                  MediaQuery.of(context).size.width,
                  state.detailedGraphData.length * 150.0, // Increased spacing
                ),
                height: MediaQuery.of(context).size.height * 0.8, // Increased height
                child: Column(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Stack(
                        children: [
                          BarChart(
                            BarChartData(
                              alignment: BarChartAlignment.spaceAround,
                              groupsSpace: 20,
                              maxY: maxValue * 1.1, // 10% padding on top
                              barGroups: _createFinancesBarGroups(state),
                              titlesData: FlTitlesData(
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    getTitlesWidget: (value, meta) {
                                      if (value.toInt() >= state.detailedGraphData.keys.length) 
                                        return const Text('');
                                      return RotatedBox(
                                        quarterTurns: 1, // Rotate text 90 degrees
                                        child: Text(
                                          state.detailedGraphData.keys.elementAt(value.toInt()),
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      );
                                    },
                                    reservedSize: 60, // Space for rotated labels
                                  ),
                                ),
                                rightTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                topTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                leftTitles: AxisTitles(
                                  axisNameSize: 20,
                                  axisNameWidget: Text('cost'.tr()),
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    reservedSize: 60,
                                    getTitlesWidget: (value, meta) {
                                      return Text(
                                        value.toStringAsFixed(0),
                                        style: const TextStyle(fontSize: 12),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              gridData: FlGridData(
                                show: true,
                                drawVerticalLine: false,
                              ),
                              borderData: FlBorderData(show: false),
                              barTouchData: BarTouchData(
                                enabled: true,
                                touchTooltipData: BarTouchTooltipData(
                                  fitInsideHorizontally: true,
                                  fitInsideVertically: true,
                                  tooltipRoundedRadius: 4,
                                  tooltipPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  tooltipMargin: 0,
                                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                                    return BarTooltipItem(
                                      rod.toY.toStringAsFixed(2),
                                      TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                          // Summary overlay in top right corner
                          Positioned(
                            top: 8,
                            right: 8,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '${'bought'.tr()}: ${totalBuy.toStringAsFixed(2)}',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  Text(
                                    '${'sold'.tr()}: ${totalSell.toStringAsFixed(2)}',
                                    style: TextStyle(color: Colors.green),
                                  ),
                                  const Divider(height: 4),
                                  Text(
                                    '${'earnings'.tr()}: ${earnings.toStringAsFixed(2)}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: earnings >= 0 ? Colors.green : Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Legend
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (hasBuy) _buildLegendItem('Buy', Colors.red),
                        if (hasSell) _buildLegendItem('Sell', Colors.green),
                      ],
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            );
          }
        ),
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          color: color,
        ),
        const SizedBox(width: 4),
        Text(label),
      ],
    );
  }

  List<BarChartGroupData> _createBarGroups(Map<String, double> graphData) {
    List<BarChartGroupData> groups = [];
    int index = 0;
    graphData.forEach((label, value) {
      groups.add(
        BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(
              toY: value,
              color: Colors.blue,
              width: 30,
              borderRadius: BorderRadius.zero,
            ),
          ],
          showingTooltipIndicators: [0],
        ),
      );
      index++;
    });
    return groups;
  }

  List<BarChartGroupData> _createStackedBarGroups(HarvestStatisticsState state) {
    final jarColors = {
      'jar_0.7l': Colors.blue[200],
      'jar_1.0l': Colors.blue[400],
      'jar_1.5l': Colors.blue[600],
      'jar_2.0l': Colors.blue[800],
      'custom_liters': Colors.blue[900],
    };

    List<BarChartGroupData> groups = [];
    int index = 0;

    for (var honeyType in state.graphData!.keys) {
      final List<BarChartRodStackItem> stackItems = [];
      double currentHeight = 0;

      // Sort jar types to ensure consistent stacking order
      final sortedJarTypes = state.jarTypes.where((jarType) =>
        (state.detailedGraphData[honeyType]?[jarType] ?? 0) > 0
      ).toList()..sort(); // Sort jar types alphabetically

      for (var jarType in sortedJarTypes) {
        final amount = state.detailedGraphData[honeyType]?[jarType] ?? 0.0;
        if (amount > 0) {
          stackItems.add(
            BarChartRodStackItem(
              currentHeight,
              currentHeight + amount,
              jarColors[jarType]!,
            ),
          );
          currentHeight += amount;
        }
      }

      // Create a single rod with all stack items
      if (stackItems.isNotEmpty) {
        groups.add(
          BarChartGroupData(
            x: index,
            barRods: [
              BarChartRodData(
                toY: currentHeight,
                width: 30,
                borderRadius: BorderRadius.zero,
                rodStackItems: stackItems,
              ),
            ],
            showingTooltipIndicators: [0],
          ),
        );
        index++;
      }
    }

    return groups;
  }

  List<BarChartGroupData> _createFinancesBarGroups(FinancesStatisticsState state) {
    List<BarChartGroupData> groups = [];
    int index = 0;
    
    state.detailedGraphData.forEach((item, typeData) {
      final barRods = <BarChartRodData>[];
      
      if ((typeData['Buy'] ?? 0) > 0) {
        barRods.add(
          BarChartRodData(
            toY: typeData['Buy']!,
            color: Colors.red.withOpacity(0.8),
            width: 20,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(4),
              topRight: Radius.circular(4),
            ),
          ),
        );
      }

      if ((typeData['Sell'] ?? 0) > 0) {
        barRods.add(
          BarChartRodData(
            toY: typeData['Sell']!,
            color: Colors.green.withOpacity(0.8),
            width: 20,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(4),
              topRight: Radius.circular(4),
            ),
          ),
        );
      }

      if (barRods.isNotEmpty) {
        groups.add(
          BarChartGroupData(
            x: index,
            barRods: barRods,
            showingTooltipIndicators: List.generate(barRods.length, (i) => i),
          ),
        );
      }
      index++;
    });
    return groups;
  }
}

class GraphData {
  final String label;
  final int value;

  GraphData({required this.label, required this.value});
}
