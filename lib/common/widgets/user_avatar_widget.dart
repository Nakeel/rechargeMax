import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recharge_max/common/widgets/image_shimmer_widget_loader.dart';
import 'package:recharge_max/core/ui/app_theme.dart';
import 'package:recharge_max/core/ui/colors.dart';
import 'package:recharge_max/core/utils/app_logger.dart';

class UserAvatarWidget extends StatelessWidget {
  const UserAvatarWidget({Key? key, this.imageUrl,  this.size = 100}) : super(key: key);
  final String? imageUrl;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                  color: AppColors.colorPrimary, width: 1)),
          padding: EdgeInsets.all(3),
          child: ClipOval(
            child: imageUrl == null
                ?  Center(
                child: Icon(
                  Icons.person,
                  size: size,
                ))
                : ImageWidgetWithShimmerLoader(
              image: imageUrl ?? '',
              height: size,
              errorWidget:  Center(
                  child: Icon(
                    Icons.person,
                    size: size,
                  )),
              width: size,
            ),
          ),
        ),
      );
  }
}



class InitialsAvatar extends StatelessWidget {
  final String firstName;
  final String lastName;
  final Color backgroundColor;
  final Color textColor;
  final double radius;

  const InitialsAvatar({
    super.key,
    required this.firstName,
    required this.lastName,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.green,
    this.radius = 30.0,
  });

  String getInitials(String firstName, String lastName) {
    return '${firstName.isEmpty ? '' : firstName[0]} ${lastName.isEmpty ? '' : lastName[0]}';
  }

  @override
  Widget build(BuildContext context) {
    return firstName.isEmpty? UserAvatarWidget(
      size: 25,
    )
        :Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
              color: AppColors.colorPrimary, width: 1)),
      child: Text(
        getInitials(firstName, lastName),
        style: TextStyle(
          color: textColor,
          fontSize: (radius * 1).sp,
          fontWeight: FontWeight.w500,
          letterSpacing: -2,
          leadingDistribution: TextLeadingDistribution.even,
        ),
      ),
    );
  }
}

class BorderedAvatar extends StatelessWidget {
  final String? imageUrl;
  final double? size;
  final String firstName, lastName;

  const BorderedAvatar(
      {super.key,  this.imageUrl, this.size, required this.firstName, required this.lastName });

  String getInitials() {
    try {
      return '${firstName.isEmpty ? '' : firstName[0]} ${lastName.isEmpty
          ? ''
          : lastName[0]}';
    }catch(e){
      AppLogger.info('Error at getInitials: $e');
      return 'UA';
    }
  }

  @override
  Widget build(BuildContext context) {
    final initials = getInitials();
    return Center(
      child: Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
                color: AppColors.colorPrimary, width: 1)),
        child: ClipOval(
          child: imageUrl == null
              ?  Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                child: Text(
                  initials,
                  style: TextStyle(
                    color: AppColors.colorPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -2,
                    leadingDistribution: TextLeadingDistribution.even,
                  ),
                )),
              )
              : ImageWidgetWithShimmerLoader(
            image: imageUrl ?? '',
            height: size ?? 100,
            errorWidget:  Center(
                child: Icon(
                  Icons.person,
                  size: size ?? 110,
                )),
            width: size ??100,
          ),
        ),
      ),
    );
  }
}