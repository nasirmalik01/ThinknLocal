import 'package:flutter/material.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/model/chart_stats_model.dart';
import 'package:flutter_app/res/res.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StatsBarChartWidget extends StatelessWidget {
  final String? popUpTitle;
  final List<ChartData>? dataSource;

  const StatsBarChartWidget({
    Key? key,
    required this.popUpTitle,
    required this.dataSource,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.66,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        color: AppColors.boxGrey,
        child: Padding(
          padding: EdgeInsets.only(top: getHeight() * 0.02),
          child: SfCartesianChart(
            /// for removing outer lines
            borderWidth: 0,
            borderColor: Colors.transparent,
            plotAreaBorderColor: Colors.transparent,
            plotAreaBorderWidth: 0,

            enableAxisAnimation: true,
            zoomPanBehavior: ZoomPanBehavior(
              enablePanning: true,
              enablePinching: true,
              zoomMode: ZoomMode.x,
            ),
            legend: Legend(
              isVisible: false,
            ),
            trackballBehavior: TrackballBehavior(
              activationMode: ActivationMode.singleTap,
            ),
            tooltipBehavior: TooltipBehavior(
              enable: true,
              activationMode: ActivationMode.singleTap,
            ),
            primaryXAxis: CategoryAxis(
              placeLabelsNearAxisLine: false,
              labelAlignment: LabelAlignment.end,
              maximumLabels: 7,
              isVisible: true,
              axisLine: const AxisLine(width: 0),
              majorGridLines: const MajorGridLines(width: 0),
              majorTickLines: const MajorTickLines(width: 0),
              minorTickLines: const MinorTickLines(width: 0),
              labelStyle: TextStyle(
                fontSize: 8.sp,
                color: AppColors.grayColor,
              ),
            ),
            primaryYAxis: NumericAxis(
              majorGridLines: const MajorGridLines(width: 1),
              borderWidth: 0,
              borderColor: Colors.transparent,

              /// for removing inside grid lines
              majorTickLines: const MajorTickLines(width: 0),

              ///for removing tick
              labelStyle: TextStyle(
                fontSize: 8.sp,
                color: AppColors.grayColor,
              ),
            ),
            series: <ChartSeries<ChartData, String>>[
              ColumnSeries<ChartData, String>(
                dataSource: dataSource!,
                xValueMapper: (ChartData data, _) => data.day,
                yValueMapper: (ChartData data, _) => data.sales,
                width: 0.8,
                name: popUpTitle ?? 'Business Stats',
                color: AppColors.greenColor,
                isTrackVisible: false,
                borderRadius: const BorderRadius.all(Radius.circular(2)),
                spacing: 0.2,
              )
            ],
          ),
        ),
      ),
    );
  }
}
