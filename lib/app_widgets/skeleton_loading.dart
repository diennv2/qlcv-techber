import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SkeletonLoadingView extends StatelessWidget {
  final int count;

  const SkeletonLoadingView({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
        enabled: true,
        enableSwitchAnimation: true,
        ignoreContainers: true,
        child: Column(
          children: [
            ...List.generate(count, (index) {
              return const Card(
                child: ListTile(
                  title: Text('Item number  as title'),
                  subtitle: Text('Subtitle here'),
                  trailing: Icon(
                    Icons.ac_unit,
                    size: 32,
                  ),
                ),
              );
            })
          ],
        ));
  }
}
