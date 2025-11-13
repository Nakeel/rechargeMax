import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class EmploymentShimmerRow extends StatelessWidget {
  const EmploymentShimmerRow({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50, // height of your buttons
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 3, // exactly 3 shimmer objects
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              width: 120, // approximate width of buttons
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );
        },
      ),
    );
  }
}
