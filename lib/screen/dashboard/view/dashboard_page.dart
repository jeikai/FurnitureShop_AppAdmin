// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:furnitureshop_appadmin/data/models/dashboard.dart';
import 'package:furnitureshop_appadmin/data/values/colors.dart';
import 'package:furnitureshop_appadmin/data/values/fonts.dart';
import 'package:furnitureshop_appadmin/data/values/strings.dart';
import 'package:furnitureshop_appadmin/screen/dashboard/controller/dashboard_controller.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashBoardPage extends GetView<DashBoardController> {
  const DashBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashBoardController>(
        builder: (value) => Scaffold(
              appBar: appBarCustom(),
              body: buildBody(),
            ));
  }

  SizedBox buildBody() {
    return SizedBox(
      width: Get.width,
      height: Get.height,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 200,
              width: 340,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.db.length,
                  itemBuilder: (BuildContext context, int itemIndex) {
                    return card(controller.db[itemIndex]);
                  }),
            ),
            userLastWeek(),
            lastOrder(),
            monthlyProfits(),
            // recentSale(),
          ],
        ),
      ),
    );
  }

  Container recentSale() {
    return Container(
      height: Get.height * 0.348,
      width: Get.width,
      padding: EdgeInsets.only(top: Get.height * 0.025, right: Get.height * 0.0124, left: Get.height * 0.0124, bottom: Get.height * 0.025),
      margin: EdgeInsets.only(right: Get.height * 0.0124, left: Get.height * 0.0124),
      decoration: BoxDecoration(color: const Color.fromARGB(255, 212, 207, 191), borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                recent_sale,
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: Get.height * 0.025, fontFamily: jose_fin_sans, fontWeight: FontWeight.w700),
              ),
              Text(
                see_all,
                style: TextStyle(fontSize: Get.height * 0.015, color: Colors.black),
              ),
            ],
          ),
          SizedBox(
            height: Get.height * 0.0124,
          ),
          SizedBox(
            height: Get.height * 0.248,
            child: ListView.builder(
                itemCount: controller.recentSale_.length,
                itemBuilder: (BuildContext context, int itemIndex) {
                  return recentSl(controller.recentSale_[itemIndex]);
                }),
          ),
        ],
      ),
    );
  }

  Widget recentSl(MyDashBoard value) {
    return Container(
      margin: EdgeInsets.all(Get.height * 0.0062),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Get.height * 0.025),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.all(Get.height * 0.0062),
            height: Get.height * 0.05,
            width: Get.height * 0.05,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              image: DecorationImage(
                image: NetworkImage(value.avt.toString()),
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(
            width: Get.height * 0.01,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value.name.toString(),
                style: TextStyle(fontFamily: jose_fin_sans, fontWeight: FontWeight.w500, fontSize: Get.height * 0.019),
              ),
              Text(
                '${value.time} Minutes Ago',
                style: TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: Get.height * 0.0124,
                ),
              ),
            ],
          ),
          SizedBox(
            width: Get.height * 0.068,
          ),
          Text(
            '+ \$${value.money}',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: Get.height * 0.0149),
          ),
        ],
      ),
    );
  }

  Container monthlyProfits() {
    return Container(
      height: Get.height * 0.559,
      width: Get.width,
      alignment: AlignmentDirectional.centerStart,
      padding: EdgeInsets.only(top: Get.height * 0.025, right: Get.height * 0.0124, left: Get.height * 0.0124, bottom: Get.height * 0.025),
      margin: EdgeInsets.only(top: Get.height * 0.025, right: Get.height * 0.0124, left: Get.height * 0.0124),
      decoration: BoxDecoration(color: backgroundColor, borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            monthlyPro,
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: Get.height * 0.025, fontFamily: jose_fin_sans, fontWeight: FontWeight.w700),
          ),
          Text(
            total_profit,
            style: TextStyle(fontSize: Get.height * 0.015, fontWeight: FontWeight.w300, color: Colors.grey),
          ),
          pieChart(controller.db_),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // linear(give_away, Color.fromARGB(255, 175, 215, 247), 22.21),
              // linear(affiliate, Color.fromARGB(255, 210, 183, 215), 25.32),
              linear(offline_sale, const Color.fromARGB(255, 239, 180, 199), controller.productOffline),
              linear(online_sale, const Color.fromARGB(255, 175, 215, 247), controller.productOnline),
            ],
          ),
        ],
      ),
    );
  }

  Stack pieChart(MyDashBoard value) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        SfCircularChart(
          series: <CircularSeries>[
            DoughnutSeries<ChartData, String>(
              dataSource: controller.chartData,
              pointColorMapper: (ChartData data, _) => data.color,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y,
              innerRadius: '60%',
              dataLabelSettings: const DataLabelSettings(
                isVisible: true,
                labelIntersectAction: LabelIntersectAction.hide,
                labelAlignment: ChartDataLabelAlignment.top,
                labelPosition: ChartDataLabelPosition.inside,
              ),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              total,
              style: TextStyle(
                fontSize: Get.height * 0.019,
                color: Colors.grey,
              ),
            ),
            Text(
              '\$${value.totalProfit}',
              style: TextStyle(fontSize: Get.height * 0.031, color: Colors.black, fontWeight: FontWeight.w900),
            ),
          ],
        ),
      ],
    );
  }

  Column linear(String title, Color color, double rate) {
    // double? rt = controller.db_.totalProfit?.abs();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: Get.height * 0.0124),
        ),
        Text(
          '${(rate).toStringAsFixed(2)}%',
          style: TextStyle(fontSize: Get.height * 0.019, fontWeight: FontWeight.w700),
        ),
        LinearPercentIndicator(
          width: 100,
          animation: true,
          animationDuration: 1000,
          lineHeight: 10.0,
          percent: rate / 100,
          linearStrokeCap: LinearStrokeCap.roundAll,
          progressColor: color,
          backgroundColor: Colors.orange[100],
        ),
      ],
    );
  }

  Container userLastWeek() {
    return Container(
      margin: const EdgeInsets.only(left: 20, top: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            user_in_lastweek,
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 20, fontFamily: jose_fin_sans, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          Text(
            'User_Week',
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 18, fontFamily: jose_fin_sans, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          graphWeek(),
        ],
      ),
    );
  }

  Container card(MyDashBoard value) {
    return Container(
      height: 200,
      width: 300,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: value.color,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                monthly_profits + controller.format(value.month),
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w300),
              ),
              Text(
                '+ ${value.profit!.toStringAsFixed(2)} %',
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              )
            ],
          ),
          const SizedBox(height: 20),
          Text(
            '\$${value.totalPrice!.toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 50, fontWeight: FontWeight.w900),
          ),
          graphMonth(),
        ],
      ),
    );
  }

  Widget graphMonth() {
    return SizedBox(
      height: 90,
      child: LineChart(
        LineChartData(
          minX: 0,
          maxX: 10,
          minY: 0,
          maxY: 10,
          borderData: FlBorderData(border: const Border()),
          lineBarsData: [
            LineChartBarData(
              spots: [
                const FlSpot(0, 4),
                const FlSpot(1, 6),
                const FlSpot(2, 8),
                const FlSpot(3, 6.2),
                const FlSpot(4, 6),
                const FlSpot(5, 8),
                const FlSpot(6, 9),
                const FlSpot(7, 7),
                const FlSpot(8, 6),
                const FlSpot(9, 7.8),
                const FlSpot(10, 8),
              ],
              isCurved: true,
              gradient: const LinearGradient(
                colors: [
                  Colors.blue,
                  Colors.green,
                ],
              ),
              barWidth: 3,
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [
                    Colors.purple.withOpacity(0.2),
                    Colors.pink.withOpacity(0.2),
                  ],
                ),
              ),
              dotData: FlDotData(show: false),
            ),
          ],
          gridData: FlGridData(
              show: true,
              drawHorizontalLine: false,
              drawVerticalLine: false,
              getDrawingVerticalLine: (value) {
                return FlLine(
                  color: Colors.grey.shade800,
                  strokeWidth: 0.8,
                );
              }),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
        ),
      ),
    );
  }

  Widget graphWeek() {
    return AspectRatio(
      aspectRatio: 1.6,
      child: BarChart(
        BarChartData(
          barTouchData: barTouchData,
          titlesData: titlesData,
          borderData: borderData,
          barGroups: barGroups,
          gridData: FlGridData(show: false),
          alignment: BarChartAlignment.spaceAround,
          maxY: controller.userOrderInWeek[7],
        ),
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          // tooltipBgColor: Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 20,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              const TextStyle(
                color: textBlackColor,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: textBlackColor,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Mn';
        break;
      case 1:
        text = 'Te';
        break;
      case 2:
        text = 'Wd';
        break;
      case 3:
        text = 'Tu';
        break;
      case 4:
        text = 'Fr';
        break;
      case 5:
        text = 'St';
        break;
      case 6:
        text = 'Sn';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 50,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  LinearGradient get _barsGradient => LinearGradient(
        colors: [
          Colors.purple.withOpacity(0.2),
          Colors.pink.withOpacity(0.2),
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );

  List<BarChartGroupData> get barGroups => [
        BarChartGroupData(
          x: 0,
          barRods: [
            BarChartRodData(
              toY: controller.userOrderInWeek[0],
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [
            0
          ],
        ),
        BarChartGroupData(
          x: 1,
          barRods: [
            BarChartRodData(
              toY: controller.userOrderInWeek[1],
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [
            0
          ],
        ),
        BarChartGroupData(
          x: 2,
          barRods: [
            BarChartRodData(
              toY: controller.userOrderInWeek[2],
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [
            0
          ],
        ),
        BarChartGroupData(
          x: 3,
          barRods: [
            BarChartRodData(
              toY: controller.userOrderInWeek[3],
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [
            0
          ],
        ),
        BarChartGroupData(
          x: 4,
          barRods: [
            BarChartRodData(
              toY: controller.userOrderInWeek[4],
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [
            0
          ],
        ),
        BarChartGroupData(
          x: 5,
          barRods: [
            BarChartRodData(
              toY: controller.userOrderInWeek[5],
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [
            0
          ],
        ),
        BarChartGroupData(
          x: 6,
          barRods: [
            BarChartRodData(
              toY: controller.userOrderInWeek[6],
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [
            0
          ],
        ),
      ];

  Container lastOrder() {
    return Container(
      margin: const EdgeInsets.only(left: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                last_order,
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 20, fontFamily: jose_fin_sans, fontWeight: FontWeight.w700),
              ),
              // Container(
              //   margin: const EdgeInsets.only(right: 30),
              //   child: DropdownButton(
              //     value: controller.selectedType,
              //     items: controller.dropdownItems,
              //     onChanged: (value) {
              //       if (value != null) {
              //         controller.selectedType = value;
              //         controller.update();
              //       }
              //     },
              //   ),
              // ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 200,
            child: ListView.builder(
                itemCount: controller.db.length,
                itemBuilder: (BuildContext context, int itemIndex) {
                  return lastOrderItem(controller.db[itemIndex]);
                }),
          ),
        ],
      ),
    );
  }

  Widget lastOrderItem(MyDashBoard value) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.all(5),
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            image: DecorationImage(
              image: NetworkImage(value.ava.toString()),
              fit: BoxFit.fill,
            ),
            //shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            value.username.toString(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontFamily: jose_fin_sans, fontWeight: FontWeight.w500, fontSize: 14),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            '\$${value.totalPrice!.toStringAsFixed(2)}',
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            value.dateTime.toString(),
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
          ),
        ),
      ],
    );
  }

  AppBar appBarCustom() {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      backgroundColor: backgroundColor,
      title: Text(
        'DashBoard',
        style: TextStyle(fontFamily: 'JosefinSans', fontWeight: FontWeight.w800, fontSize: Get.width * 0.045, color: textBlackColor),
      ),
      leading: InkWell(
        onTap: () {
          Get.back();
        },
        child: const Icon(
          Icons.arrow_back_ios,
          color: textBlackColor,
        ),
      ),
    );
  }
}
