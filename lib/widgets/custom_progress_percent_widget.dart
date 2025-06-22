import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rate/configs/app_config.dart';
import 'package:rate/providers/providers.dart';

class CustomProgressPercentWidget extends ConsumerWidget {
  const CustomProgressPercentWidget({
    super.key,
    this.boxWidth = 30,
    this.boxHeight = 30,
    this.indicatorColor = Colors.white,
    this.indicatorWidth = 2,
    this.textSize = 10
  });

  final double boxWidth;
  final double boxHeight;
  final Color indicatorColor;
  final double indicatorWidth;
  final double textSize;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(uploadProgressProvider);
    final length = progress.length;
    double percent = 0;

    if(length > 0) {
      percent = progress.reduce((v, e) => v + e) / length;
    }

    return SizedBox(
      width: boxWidth,
      height: boxHeight,
      child: Stack(
        children: [
          CircularProgressIndicator(
            strokeWidth: indicatorWidth,
            color: indicatorColor,
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              '${percent.toStringAsFixed(AppConfig.percentFractionDigits)}%',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: textSize
              ),
            ),
          )
        ],
      ),
    );
  }
}
