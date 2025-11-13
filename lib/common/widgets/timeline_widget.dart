import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:recharge_max/core/network/response_status_enums.dart';
import 'package:recharge_max/core/ui/colors.dart';

class TimelineStep {
  final String title;
  final String? subtitle;
  final String svgAssetPath; // Single SVG path
  final IconData? fallbackIcon; // Optional fallback icon

  TimelineStep({
    required this.title,
    this.subtitle,
    required this.svgAssetPath,
    this.fallbackIcon,
  });
}

enum TimelineStepStatus {
  completed,
  inProgress,
  pending,
}

class TimelineWidget extends StatelessWidget {
  final List<TimelineStep> steps;
  final int currentStep; // 1-based index (1/5, 2/5, etc.)
  final Color primaryColor;
  final Color completedColor;
  final Color inProgressColor;
  final Color pendingColor;
  final double stepSpacing;
  final double iconSize;
  final TextStyle? titleTextStyle;
  final TextStyle? subtitleTextStyle;
  final String? headerTitle;
  final String? headerSubtitle;
  final String username;

  const TimelineWidget({
    super.key,
    required this.steps,
    required this.currentStep,
    required this.username,
    this.primaryColor = Colors.green,
    this.completedColor = Colors.green,
    this.inProgressColor = Colors.green,
    this.pendingColor = Colors.grey,
    this.stepSpacing = 60.0,
    this.iconSize = 24.0,
    this.titleTextStyle,
    this.subtitleTextStyle,
    this.headerTitle,
    this.headerSubtitle,
  });

  TimelineStepStatus _getStepStatus(int stepIndex) {
    // Convert 1-based currentStep to 0-based for comparison
    final currentIndex = currentStep - 1;

    if (stepIndex < currentIndex) {
      return TimelineStepStatus.completed;
    } else if (stepIndex == currentIndex) {
      return TimelineStepStatus.inProgress;
    } else {
      return TimelineStepStatus.pending;
    }
  }

  String? _getStepSubtitle(int stepIndex) {
    final status = _getStepStatus(stepIndex);
    final originalSubtitle = steps[stepIndex].subtitle;

    switch (status) {
      case TimelineStepStatus.completed:
        return originalSubtitle ?? 'Completed';
      case TimelineStepStatus.inProgress:
        return originalSubtitle ?? 'In Progress';
      case TimelineStepStatus.pending:
        return originalSubtitle;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header text
            Text(
              headerTitle ?? 'Complete Steps',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
//             const SizedBox(height: 8),
//             BlocBuilder<AuthBloc, AuthState>(
//               builder: (context, state) {
//                 String? name;
//                 if (state.getProfileStatus == ResponseStatus.success) {
//                   name = toBeginningOfSentenceCase(state.profile?.firstName) ?? '';
//                 }
//                 return Text(
//               headerSubtitle ??
//                   'Hi ${name??username}, we know this form is long, but we\'ve optimized every step to be quick and easy. You\'re just a few steps away from completing your loan application—it\'ll be over before you know it.',
//               style: TextStyle(
//                 fontSize: 12,
//                 color: AppColors.grey300,
//                 height: 1.4,
//               ),
//             );
//   },
// ),
            const SizedBox(height: 32),

            // Timeline steps
            ...steps.asMap().entries.map((entry) {
              final index = entry.key;
              final step = entry.value;
              final isLast = index == steps.length - 1;
              final status = _getStepStatus(index);
              final subtitle = _getStepSubtitle(index);

              return TimelineStepWidget(
                step: step,
                status: status,
                subtitle: subtitle,
                isLast: isLast,
                completedColor: completedColor,
                inProgressColor: inProgressColor,
                pendingColor: pendingColor,
                stepSpacing: stepSpacing,
                iconSize: iconSize,
                titleTextStyle: titleTextStyle,
                subtitleTextStyle: subtitleTextStyle,
              );
            }),
          ],
        ),
      ),
    );
  }
}

class TimelineStepWidget extends StatelessWidget {
  final TimelineStep step;
  final TimelineStepStatus status;
  final String? subtitle;
  final bool isLast;
  final Color completedColor;
  final Color inProgressColor;
  final Color pendingColor;
  final double stepSpacing;
  final double iconSize;
  final TextStyle? titleTextStyle;
  final TextStyle? subtitleTextStyle;

  const TimelineStepWidget({
    super.key,
    required this.step,
    required this.status,
    this.subtitle,
    required this.isLast,
    required this.completedColor,
    required this.inProgressColor,
    required this.pendingColor,
    required this.stepSpacing,
    required this.iconSize,
    this.titleTextStyle,
    this.subtitleTextStyle,
  });

  Color _getStepColor() {
    switch (status) {
      case TimelineStepStatus.completed:
        return completedColor;
      case TimelineStepStatus.inProgress:
        return inProgressColor;
      case TimelineStepStatus.pending:
        return pendingColor;
    }
  }

  Widget _buildStepIcon() {
    final color = _getStepColor();
    const svgColor = Colors.white;

    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color:
            status == TimelineStepStatus.pending ? AppColors.hintGrey : color,
        shape: BoxShape.circle,
      ),
      padding: const EdgeInsets.all(12), // Add padding for better SVG sizing
      child: SvgPicture.asset(
        step.svgAssetPath,
        width: iconSize,
        height: iconSize,
        colorFilter: const ColorFilter.mode(
          svgColor,
          BlendMode.srcIn,
        ),
        // Fallback to regular icon if SVG fails to load
        placeholderBuilder: (context) => step.fallbackIcon != null
            ? Icon(
                step.fallbackIcon!,
                color: svgColor,
                size: iconSize,
              )
            : Icon(
                Icons.circle,
                color: svgColor,
                size: iconSize,
              ),
      ),
    );
  }

  Widget _buildConnector() {
    if (isLast) return const SizedBox.shrink();

    // Create connector line that appears to connect under the circles
    return Container(
      width: 3,
      height: stepSpacing - 50,
      margin: const EdgeInsets.only(left: 23.5),
      decoration: BoxDecoration(
        color: status == TimelineStepStatus.completed
            ? completedColor.withOpacity(0.4)
            : Colors.grey[300],
        borderRadius: BorderRadius.circular(1.5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: isLast ? null : stepSpacing,
      child: Stack(
        children: [
          // Connector line with top and bottom margins
          if (!isLast)
            Positioned(
              left: 22.5,
              top: 55,
              child: Container(
                width: 5,
                height: stepSpacing -
                    65, // Leave 10px margin at top and bottom (60 + 10)
                decoration: BoxDecoration(
                  color: status == TimelineStepStatus.completed
                      ? completedColor.withOpacity(0.4)
                      : const Color(0xffF8F8F8),
                  borderRadius: BorderRadius.circular(1.5),
                ),
              ),
            ),

          // Main content
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildStepIcon(),
              const SizedBox(width: 16),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        step.title,
                        style: titleTextStyle ??
                            TextStyle(
                              fontWeight: FontWeight.w600,
                              color: status == TimelineStepStatus.pending
                                  ? AppColors.hintGrey
                                  : AppColors.colorPrimary,
                            ),
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          subtitle!,
                          style: subtitleTextStyle ??
                              TextStyle(
                                fontSize: 12,
                                color: status == TimelineStepStatus.pending
                                    ? AppColors.hintGrey
                                    : Colors.black,
                              ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
