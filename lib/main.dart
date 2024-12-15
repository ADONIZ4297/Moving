import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:math';

import 'package:http/http.dart';
import 'package:moving/extension.dart';
import 'package:moving/navigationScreen.dart';
import 'package:moving/provider/destinationProvider.dart';
import 'package:moving/provider/selectProvider.dart';
import 'package:moving/provider/waitingProvider.dart';
import 'package:moving/widgets/bus_route_map.dart';
import 'package:styled_widget/styled_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Pretendard',
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFD32F2F)),
          useMaterial3: true,
        ),
        home: const MovingScreen(),
      ),
    );
  }
}

class MovingScreen extends StatelessWidget {
  const MovingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: red,
      appBar: AppBar(
        title: Image.asset(
          'assets/logo.png',
          width: 120,
        ),
        centerTitle: false,
        backgroundColor: red,
      ),
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // SizedBox(height: 40),
          Spacer(),
          BusRouteMap(),
          Spacer(),
          WaitingPeople(),
          // SizedBox(height: 40),
          Spacer(),
          NavigationScreen(),
        ],
      ),
    );
  }
}

class WaitingPeople extends HookConsumerWidget {
  const WaitingPeople({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ref.watch(selectProvider) == 0
                ? Text('대기 인원: ${ref.watch(waitingProvider).value ?? 0}명')
                    .bold()
                    .fontSize(18)
                : const Text("지원하지 않는 위치").bold().fontSize(18),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                ref.invalidate(waitingProvider);
              },
              child: Icon(Icons.refresh, size: 20),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom Painter for the route circle
class RoutePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10.0;

    final dotPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final path = Path();
    path.addOval(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawPath(path, paint);

    // Draw dots
    final double radius = 15.0;
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final double width = size.width;
    final double height = size.height;

    // Draw 6 dots around the oval
    for (int i = 0; i < 6; i++) {
      final double angle = (i * 60) * (3.14159 / 180);
      final double x = centerX + (width / 2) * cos(angle);
      final double y = centerY + (height / 2) * sin(angle);
      canvas.drawCircle(Offset(x, y), radius, dotPaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
