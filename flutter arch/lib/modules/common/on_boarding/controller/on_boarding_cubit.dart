import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../../config/router/app_router_keys.dart';
import '../../../../core/connection/interfaces/local_data_source.dart';
import '../../../../core/utils/functions/service_locator.dart';
import '../model/on_boarding_item.dart';
import '../view/widgets/on_boarding_metrics.dart';


class OnBoardingCubit extends Cubit<int> {
  OnBoardingCubit() : super(0);

  static OnBoardingCubit get(context) => BlocProvider.of(context);

  final PageController pageController = PageController();

  int get pageCount => OnBoardingItem.items.length;

  bool get isLastPage => state == pageCount - 1;

  void onPageChanged(int index) => emit(index);

  void next() {
    if (isLastPage) {
      finish();
      return;
    }
    pageController.nextPage(
      duration: OnBoardingMetrics.transition,
      curve: Curves.easeInOut,
    );
  }

  Future<void> finish() async {
    await sl<LocalDataSource>().disableOnboarding();
    // sl<NavigationService>().navigatePushNamedAndRemoveUntil(
    //   AppRouterKeys.welcomeScreen,
    // );
  }

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }
}
