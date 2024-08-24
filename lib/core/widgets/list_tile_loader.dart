import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ListTileLoader extends StatelessWidget {
  const ListTileLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 6,
      itemBuilder: (context, item) {
        return Card(
          elevation: 4.0,
          margin: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 16.0,
          ),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            enabled: true,
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              minLeadingWidth: 100,
              horizontalTitleGap: 10,
              minVerticalPadding: 10,
              leading: Container(
                height: 100,
                width: 100,
                color: Colors.white,
              ),
              title: Container(
                height: 120.0,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}
