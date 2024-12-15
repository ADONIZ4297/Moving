import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:moving/extension.dart';

class BusRoutePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint linePaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 6.0
      ..style = PaintingStyle.stroke;

    final Paint stationFillPaint = Paint()
      ..color = red
      ..style = PaintingStyle.fill;

    final Paint stationBorderPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke;

    // 둥근 모서리의 직사각형 경로 그리기
    final RRect roundedRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(size.height / 2),
    );
    canvas.drawRRect(roundedRect, linePaint);

    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final double stationRadius = 12.0;

    // 정류장 위치 정의
    final List<Offset> stationPositions = [
      // 왼쪽
      Offset(0, centerY),
      // 오른쪽
      Offset(size.width, centerY),
      // 위쪽 두개
      Offset(centerX - size.width / 5, 0),
      Offset(centerX + size.width / 5, 0),
      // 아래쪽 두개
      Offset(centerX - size.width / 5, size.height),
      Offset(centerX + size.width / 5, size.height),
    ];

    // 각 정류장 그리기
    for (var position in stationPositions) {
      // 빨간 원 그리기
      canvas.drawCircle(
        position,
        stationRadius,
        stationFillPaint,
      );

      // 흰색 테두리 그리기
      canvas.drawCircle(
        position,
        stationRadius,
        stationBorderPaint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
