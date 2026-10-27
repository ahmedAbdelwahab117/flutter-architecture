import 'package:flutter/material.dart';
import 'package:nidaa_khafia/modules/common/on_boarding/view/widgets/on_boarding_next_button.dart';
import 'package:nidaa_khafia/modules/common/on_boarding/view/widgets/on_boarding_page.dart';
import 'package:nidaa_khafia/modules/common/on_boarding/view/widgets/on_boarding_skip_button.dart';

import '../controller/on_boarding_cubit.dart';
import '../model/on_boarding_item.dart';


class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = OnBoardingCubit.get(context);
    final items = OnBoardingItem.items;

    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: cubit.pageController,
            onPageChanged: cubit.onPageChanged,
            itemCount: items.length,
            itemBuilder: (context, index) => OnBoardingPage(
              item: items[index],
              index: index,
              count: items.length,
            ),
          ),
          PositionedDirectional(
            top: 0,
            end: 0,
            child: OnBoardingSkipButton(onPressed: cubit.finish),
          ),
        ],
      ),
      bottomNavigationBar: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [OnBoardingNextButton()],
      ),
    );
  }
}
