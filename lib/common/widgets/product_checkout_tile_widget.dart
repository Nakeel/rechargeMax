import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:recharge_max/common/widgets/naira_richtext_widget.dart';
import 'package:recharge_max/core/ui/app_theme.dart';
import 'package:recharge_max/core/ui/colors.dart';

import 'product_image_card.dart';

class ProductSummaryTile extends StatelessWidget {
  final String imageUrl;
  final String title;
  final int quantity;
  final String amountDue;
  final String dueLabel;
  final String monthlyPayment;
  final double imageHeight;
  final double imageWidth;
  final double containerWidth;
  final double containerHeight;

  const ProductSummaryTile({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.quantity,
    required this.amountDue,
    required this.dueLabel,
    required this.monthlyPayment,
    this.imageHeight = 60,
    this.imageWidth = 60,
    this.containerWidth = 80,
    this.containerHeight = 80,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProductImageCardWidget(
          image: imageUrl,
          height: imageHeight,
          width: imageWidth,
          padding: const EdgeInsets.all(5),
          hasBorder: true,
          containerWidth: containerWidth,
          containerHeight: containerWidth,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: AppColors.black100,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                dueLabel,
                style: TextStyle(
                  color: AppColors.grey50,
                  fontFamily: AppTheme.roboto,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  NairaRichText(
                    value: amountDue,
                    symbolStyle: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                    valueStyle: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'Due Today',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: AppColors.black100,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  NairaRichText(
                    value: monthlyPayment,
                    symbolStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: AppColors.grey50,
                    ),
                    valueStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: AppColors.grey50,
                    ),
                  ),
                  // Text(
                  //   '/m',
                  //   style: TextStyle(
                  //     fontWeight: FontWeight.w500,
                  //     fontSize: 12,
                  //     color: AppColors.grey50,
                  //   ),
                  // ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                'Quantity: $quantity',
                style: TextStyle(
                  color: AppColors.grey50,
                  fontFamily: AppTheme.roboto,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ColumnTitleDescWidget extends StatelessWidget {
  const ColumnTitleDescWidget(
      {super.key,
      required this.title,
      required this.desc,
      this.subTitle,
      this.isCurrency = false});

  final String title;
  final String? subTitle;
  final String desc;
  final bool isCurrency;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isCurrency
              ? NairaRichText(
                  value: title,
                  symbolStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                  minFontSize: 8,
                  maxLines: 2,
                  valueStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                )
              : AutoSizeText(
                  title,
                  maxFontSize: 14,
                  minFontSize: 8,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
          const SizedBox(height: 4),
          Text(
            desc,
            style: TextStyle(
              color: AppColors.grey50,
              fontFamily: AppTheme.roboto,
              fontSize: 12,
            ),
          ),
          if (subTitle != null)
            NairaRichText(
              value: subTitle ?? '',
              symbolStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
              maxLines: 2,
              minFontSize: 8,
              valueStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ),
        ],
      ),
    );
  }
}
