import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moving/extension.dart';
import 'package:moving/provider/destinationProvider.dart';
import 'package:moving/provider/selectProvider.dart';
import 'package:moving/provider/waitingProvider.dart';
import 'package:moving/widgets/destinationDialog.dart';
import 'package:styled_widget/styled_widget.dart';
import 'widgets/bus_route_map.dart';

class NavigationScreen extends HookConsumerWidget {
  const NavigationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 20),
              Expanded(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('출발지')
                          .bold()
                          .fontSize(14)
                          .textColor(Colors.black.withOpacity(0.6)),
                      Row(
                        // mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            stopList[ref.watch(selectProvider)],
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 5),
                          // Icon(
                          //   CupertinoIcons.chevron_down,
                          //   color: Colors.black,
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                color: Colors.black.withOpacity(0.4),
                width: 1,
                height: 40,
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('목적지')
                          .bold()
                          .fontSize(14)
                          .textColor(Colors.black.withOpacity(0.6)),
                      GestureDetector(
                        onTap: () {
                          showCupertinoDialog(
                            barrierDismissible: true,
                            barrierLabel: MaterialLocalizations.of(context)
                                .modalBarrierDismissLabel,
                            // useRootNavigator: true,
                            context: context,
                            builder: (context) => const DestinationDialog(),
                          );
                        },
                        child: Row(
                          // mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              ref.watch(destinationProvider) != null
                                  ? stopList[ref.watch(destinationProvider)!]
                                  : '선택해주세요',
                              style: TextStyle(
                                color: ref.watch(destinationProvider) != null
                                    ? Colors.black
                                    : Colors.black.withOpacity(0.4),
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Icon(
                              CupertinoIcons.chevron_down,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          // if (ref.watch(destinationProvider) != null)
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            child: Container(
              height: ref.watch(destinationProvider) != null ? null : 0,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: red.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          padding: const EdgeInsets.all(10),
                          child: Image.asset(
                            'assets/bus.png',
                            width: 40,
                            color: red,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Consumer(builder: (context, ref, child) {
                          // var waiting = ref.watch(waitingProvider).value;
                          var waiting = 29;
                          var currentMinute = DateTime.now().minute;
                          if (ref.watch(destinationProvider) == null) {
                            return Container();
                          }
                          // print(currentMinute);
                          // print((waiting! + 1 / 30));
                          var calculate = (((waiting! + 1) / 30) - 1) * 5 +
                              (5 - currentMinute % 5) +
                              ref.watch(destinationProvider)! * 3;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('무당이')
                                  .bold()
                                  .fontSize(14)
                                  .textColor(Colors.black.withOpacity(0.6)),
                              if (ref.watch(waitingProvider).value != null)
                                Text(calculate.round().toString() + "분")
                                    .bold()
                                    .fontSize(22)
                                    .textColor(red)
                                    .fontWeight(FontWeight.w900),
                            ],
                          );
                        })
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          padding: const EdgeInsets.all(10),
                          child: Image.asset(
                            'assets/walk.png',
                            width: 40,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('도보')
                                .bold()
                                .fontSize(14)
                                .textColor(Colors.black.withOpacity(0.6)),
                            if (ref.watch(destinationProvider) != null)
                              Text(walkTimeList[
                                      ref.watch(destinationProvider)!])
                                  .fontWeight(FontWeight.w800)
                                  .fontSize(22)
                                  .textColor(Colors.blue),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
