part of 'app_controller_bloc.dart';

class AppControllerState extends Equatable {
  final int unreadCount;

  const AppControllerState({
    this.unreadCount = 0,
  });

  AppControllerState copyWith({
    int? unreadCount,
  }) {
    return AppControllerState(
      unreadCount: unreadCount ?? this.unreadCount,
    );
  }

  @override
  List<Object?> get props => [unreadCount];
}

final class AppControllerInitial extends AppControllerState {
  const AppControllerInitial() : super(unreadCount: 0);
}
