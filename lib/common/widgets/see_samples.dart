import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recharge_max/common/models/pdf_preview_item.dart';
import 'package:recharge_max/common/widgets/pdf_preview_modal.dart';
import 'package:recharge_max/core/network/api_routes.dart';
import 'package:recharge_max/core/ui/colors.dart';

class SeeSamplesWidget extends StatelessWidget {
  const SeeSamplesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showSamplePreview(
          context: context,
          title: 'Offer Letter Sample',
          pdfItems: [
            PdfPreviewItem(path: ApiRouteConstant.tenancyDoc, title: 'Apartment offer Letter OR Tenancy Agreement'),
            PdfPreviewItem(path: ApiRouteConstant.offerLetterDoc, title: 'Valid ID'),
            PdfPreviewItem(path: ApiRouteConstant.bankStatementDoc, title: '6-month Account Statement'),
          ],
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: AppColors.itemGrey,
          borderRadius: BorderRadius.circular(100),
        ),
        child: const Text(
          'See Samples',
          style: TextStyle(
            color: AppColors.black100,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  void _showSamplePreview(
      {required BuildContext context,
      required String title,
      required List<PdfPreviewItem> pdfItems}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20), // rounded top corners
        bottom: Radius.zero,      // no radius at bottom
      ),
    ),
      builder: (_) => PdfPreviewModal(
        showButtons: false,
        title: title,
        pdfItems: pdfItems,
      ),
    );
  }
}
