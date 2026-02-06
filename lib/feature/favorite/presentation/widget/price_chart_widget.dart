import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:realtime_stock_monitoring/core/utils/price_formatter.dart';

/// 가격 차트 위젯 (Mock 데이터 사용)
class PriceChartWidget extends StatefulWidget {
  const PriceChartWidget({
    required this.currentPrice,
    required this.changeRate,
    super.key,
  });

  final int currentPrice;
  final double changeRate;

  @override
  State<PriceChartWidget> createState() => _PriceChartWidgetState();
}

class _PriceChartWidgetState extends State<PriceChartWidget> {
  late List<FlSpot> _chartData;
  final Random _random = Random(42); // 고정 시드로 일관된 데이터 생성

  @override
  void initState() {
    super.initState();
    _generateChartData();
  }

  @override
  void didUpdateWidget(PriceChartWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentPrice != widget.currentPrice) {
      _updateChartData();
    }
  }

  void _generateChartData() {
    // 초기 Mock 데이터 생성 (과거 20개 데이터 포인트)
    _chartData = List.generate(20, (index) {
      final variation = (_random.nextDouble() - 0.5) * 0.05;
      return FlSpot(
        index.toDouble(),
        widget.currentPrice * (1 + variation),
      );
    });
    // 마지막 포인트는 현재 가격
    _chartData.add(FlSpot(20, widget.currentPrice.toDouble()));
  }

  void _updateChartData() {
    // 새 데이터 포인트 추가 및 오래된 데이터 제거
    if (_chartData.length > 20) {
      _chartData = _chartData.sublist(1);
    }
    // x값 재조정
    _chartData = _chartData.asMap().entries.map((entry) {
      return FlSpot(entry.key.toDouble(), entry.value.y);
    }).toList();
    // 현재 가격 추가
    _chartData.add(
      FlSpot(_chartData.length.toDouble(), widget.currentPrice.toDouble()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isPositive = widget.changeRate >= 0;
    final chartColor = isPositive ? Colors.red : Colors.blue;

    final minY = _chartData.map((spot) => spot.y).reduce(min) * 0.98;
    final maxY = _chartData.map((spot) => spot.y).reduce(max) * 1.02;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 현재 가격 표시
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '현재가',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    PriceFormatter.formatPrice(widget.currentPrice),
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: chartColor,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    PriceFormatter.formatChangeRate(widget.changeRate),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: chartColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        // 차트
        SizedBox(
          height: 200,
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  drawVerticalLine: false,
                  // 최소 1000 간격 보장 (0.1만 단위 중복 방지)
                  horizontalInterval: max((maxY - minY) / 4, 1000),
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: Colors.grey.shade200,
                      strokeWidth: 1,
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  rightTitles: const AxisTitles(),
                  topTitles: const AxisTitles(),
                  bottomTitles: const AxisTitles(),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      // 최소 1000 간격 보장 (0.1만 단위 중복 방지)
                      interval: max((maxY - minY) / 4, 1000),
                      reservedSize: 45,
                      getTitlesWidget: (value, meta) {
                        // 최소/최대 값은 라벨 잘림 방지를 위해 숨김
                        if (value == meta.min || value == meta.max) {
                          return const SizedBox.shrink();
                        }
                        return Text(
                          PriceFormatter.formatPriceShort(value.toInt()),
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 10,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                minX: 0,
                maxX: _chartData.length.toDouble() - 1,
                minY: minY,
                maxY: maxY,
                lineBarsData: [
                  LineChartBarData(
                    spots: _chartData,
                    isCurved: true,
                    color: chartColor,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      color: chartColor.withAlpha(25),
                    ),
                  ),
                ],
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    tooltipBgColor: Colors.black87,
                    getTooltipItems: (touchedSpots) {
                      return touchedSpots.map((spot) {
                        return LineTooltipItem(
                          PriceFormatter.formatPrice(spot.y.toInt()),
                          const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }).toList();
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
