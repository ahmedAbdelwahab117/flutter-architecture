import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/constant/app_colors.dart';
import '../../controller/on_boarding_cubit.dart';
import 'on_boarding_metrics.dart';


class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = OnBoardingCubit.get(context);

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.only(bottom: OnBoardingMetrics.bottomInset),
        child: BlocBuilder<OnBoardingCubit, int>(
          builder: (context, page) {
            final bool isLast = cubit.isLastPage;

            return SizedBox.square(
              dimension: OnBoardingMetrics.nextButtonSize,
              child: TweenAnimationBuilder<double>(
                tween: Tween(end: (page + 1) / cubit.pageCount),
                duration: OnBoardingMetrics.transition,
                builder: (context, progress, child) => Stack(
                  fit: StackFit.expand,
                  children: [
                    CircularProgressIndicator(
                      value: progress,
                      strokeWidth: OnBoardingMetrics.ringWidth,
                      strokeCap: StrokeCap.round,
                      color: AppColors.primaryColor,
                      backgroundColor: AppColors.transparent,
                    ),
                    child!,
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(OnBoardingMetrics.ringWidth * 2),
                  child: Material(
                    color: isLast ? AppColors.transparent : AppColors.primaryColor,
                    shape: const CircleBorder(),
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      onTap: cubit.next,
                      child: Icon(
                        isLast
                            ? Icons.check_rounded
                            : Icons.arrow_forward_ios_rounded,
                        size: isLast ? 26 : 18,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
