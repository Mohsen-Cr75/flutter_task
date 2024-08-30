part of 'appcontroller_bloc.dart';

abstract class AppcontrollerEvent extends Equatable {
  const AppcontrollerEvent();
}



class ConnectivityChanged extends AppcontrollerEvent {
  final ConnectivityResult connectivityResult;

  const ConnectivityChanged(this.connectivityResult);
  @override
  List<Object?> get props => [connectivityResult];
}
