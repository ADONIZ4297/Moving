import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moving/extension.dart';
import 'package:moving/main.dart';
import 'package:moving/provider/destinationProvider.dart';
import 'package:styled_widget/styled_widget.dart';

class DestinationDialog extends HookConsumerWidget {
  const DestinationDialog({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Container(
        // padding: const EdgeInsets.all(20),
        width: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Material(
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // const Text('목적지를 선택해주세요.')
              //     .bold()
              //     .fontSize(14)
              //     .textColor(Colors.black.withOpacity(0.6))
              //     .padding(all: 10),
              for (var i = 0; i < stopList.length; i++) ...[
                Divider(
                  height: 1,
                  color: Colors.black.withOpacity(0.2),
                ),
                GestureDetector(
                  onTap: () {
                    ref.read(destinationProvider.notifier).state = i;
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Text(stopList[i])
                        .fontWeight(FontWeight.w500)
                        .fontSize(20),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
