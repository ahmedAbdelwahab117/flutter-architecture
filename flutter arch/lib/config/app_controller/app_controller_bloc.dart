import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/connection/concept/end_points.dart';
import '../../core/connection/interfaces/api_consumer.dart';
import '../../core/utils/functions/service_locator.dart';

part 'app_controller_event.dart';
part 'app_controller_state.dart';

class AppControllerBloc extends Bloc<AppControllerEvent, AppControllerState> {
  AppControllerBloc() : super(const AppControllerInitial()) {
    on<AppControllerUnreadCountChanged>(_onUnreadCountChanged);
    on<AppControllerFetchUnreadCount>(_onFetchUnreadCount);
  }

  void _onUnreadCountChanged(
    AppControllerUnreadCountChanged event,
    Emitter<AppControllerState> emit,
  ) {
    emit(state.copyWith(unreadCount: event.unreadCount));
  }

  Future<void> _onFetchUnreadCount(
    AppControllerFetchUnreadCount event,
    Emitter<AppControllerState> emit,
  ) async {
    try {
      final response = await sl<ApiConsumer>().get(
        EndPoints.notifications,
        queryParameters: {'page': 1, 'page_size': 1},
      );

      response.fold(
        (failure) {},
        (success) {
          final responseData = success.response;
          int unreadCount = 0;
          if (responseData['stats'] != null && responseData['stats']['unread'] != null) {
            unreadCount = responseData['stats']['unread'] as int;
          } else {
            unreadCount = responseData['unread'] as int? ?? 0;
          }
          emit(state.copyWith(unreadCount: unreadCount));
        },
      );
    } catch (e) {
      // Keep current state on error
    }
  }
}
