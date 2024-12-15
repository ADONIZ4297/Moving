import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moving/extension.dart';
import 'package:moving/navigationScreen.dart';
import 'package:moving/provider/selectProvider.dart';
import 'package:styled_widget/styled_widget.dart';
import 'bus_route_painter.dart';

class BusRouteMap extends HookConsumerWidget {
  const BusRouteMap({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget _buildStationText(int index) {
      final selectedIndex = ref.watch(selectProvider);
      return GestureDetector(
        onTap: () {
          ref.read(selectProvider.notifier).state = index;
        },
        child: Text(
          stopList[index],
          style: TextStyle(
            color: selectedIndex == index
                ? Colors.white
                : Colors.white.withOpacity(0.4),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(40),
      child: AspectRatio(
        aspectRatio: 1.7,
        child: LayoutBuilder(builder: (context, constraints) {
          return CustomPaint(
            painter: BusRoutePainter(),
            child: Stack(
              children: [
                // 왼쪽
                Positioned(
                  left: 30,
                  top: constraints.maxHeight / 2 - 10,
                  child: _buildStationText(0),
                ),
                // 오른쪽
                Positioned(
                  right: 30,
                  top: constraints.maxHeight / 2 - 10,
                  child: _buildStationText(3),
                ),
                // 위쪽 두개
                Positioned(
                  left: constraints.maxWidth / 4 - 20,
                  top: 30,
                  child: _buildStationText(5),
                ),
                Positioned(
                  right: constraints.maxWidth / 4 - 20,
                  top: 30,
                  child: _buildStationText(4),
                ),
                // 아래쪽 두개
                Positioned(
                  left: constraints.maxWidth / 3.2 - 20,
                  bottom: 30,
                  child: _buildStationText(1),
                ),
                Positioned(
                  right: constraints.maxWidth / 4 - 20,
                  bottom: 30,
                  child: _buildStationText(2),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
