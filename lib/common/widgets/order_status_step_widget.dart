import 'package:flutter/material.dart';
import 'package:recharge_max/common/models/track_status_type.dart';
import 'package:recharge_max/core/ui/colors.dart';
import 'dotted_seperator_widget.dart';

// This version uses TrackStatus like A, but styling and structure like B.
class OrderStatusStep extends StatelessWidget {
  final TrackStatus status;
  final bool isLastOne;

  const OrderStatusStep({
    super.key,
    required this.status,
    required this.isLastOne,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildStatusIcon(),
            if (!isLastOne)
              SizedBox(
                height: 100,
                child: VerticalDottedSeparator(
                  color: AppColors.colorPrimary,
                ),
              ),
          ],
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  status.label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black100,
                  ),
                ),
                if (status.subtitle != null)
                  status.subtitle!
                else if (status.time.isNotEmpty)
                  Text(
                    status.time,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.grey50,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusIcon() {
    return Container(
      decoration: BoxDecoration(color:status.status == TrackStatusType.future ?
      AppColors.hintGrey.withOpacity(.2)
          : AppColors.colorPrimary.withOpacity(.2),
        shape: BoxShape.circle
      ),
      padding: EdgeInsets.all(status.status == TrackStatusType.past ? 8:4),
      child: (status.status == TrackStatusType.current)
          ? Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.colorPrimary,
              ),
              padding: const EdgeInsets.all(5),
              child: Icon(
                Icons.check,
                color: AppColors.colorWhite,
                size: 10,
              ),
            )
          : (status.status == TrackStatusType.past)
              ? Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.colorPrimary,
                  ),
                )
              :
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.hintGrey,
                    ),
                    padding: EdgeInsets.all(4),
                    child: Icon(
                      Icons.location_pin,
                      color: AppColors.colorWhite,
                      size: 10,
                    ),
                  ),
    );
  }
}
