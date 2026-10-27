part of 'app_controller_bloc.dart';

sealed class AppControllerEvent extends Equatable {
  const AppControllerEvent();

  @override
  List<Object> get props => [];
}

final class AppControllerUnreadCountChanged extends AppControllerEvent {
  final int unreadCount;

  const AppControllerUnreadCountChanged(this.unreadCount);

  @override
  List<Object> get props => [unreadCount];
}

final class AppControllerFetchUnreadCount extends AppControllerEvent {
  const AppControllerFetchUnreadCount();
}
