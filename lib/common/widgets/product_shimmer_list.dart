import 'package:flutter/material.dart';
import 'package:recharge_max/common/widgets/shimmer_placeholder.dart';


class HorizontalProductShimmerList extends StatelessWidget {
  const HorizontalProductShimmerList({super.key,  this.count = 6});
  final int count;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(count, (index){
          return const ProductShimmerWidget(
            padding: EdgeInsets.only(right: 15),
          );
        }).toList(),
      ),
    );
  }
}

class GridProductShimmerList extends StatelessWidget {
  const GridProductShimmerList({super.key, this.count = 6, this.padding});
  final int count;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2, // 2 columns
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      padding: padding?? const EdgeInsets.all(16),
      childAspectRatio: .95, // Adjust to match shimmer card size
      children: List.generate(count, (index) => const ProductShimmerWidget()),
    );
  }
}


class ProductShimmerWidget extends StatelessWidget {
  const ProductShimmerWidget({
    super.key, this.padding,
  });
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image placeholder
          Container(
            width: 170,
            height: 120.0, // Adjust based on the image size
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: ShimmerPlaceholder.create(),
          ),
          const SizedBox(height: 8.0),
          // Title placeholder
          Container(
            width: 100.0, // Adjust width for title
            height: 12.0,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: ShimmerPlaceholder.create(),
          ),
          const SizedBox(height: 4.0),
          // Subtitle placeholder
          Container(
            width: 140.0, // Adjust width for subtitle
            height: 8.0,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: ShimmerPlaceholder.create(),
          ),
        ],
      ),
    );
  }
}