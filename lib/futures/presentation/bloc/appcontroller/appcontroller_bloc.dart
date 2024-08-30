import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:connectivity_plus/connectivity_plus.dart';
part 'appcontroller_event.dart';
part 'appcontroller_state.dart';

class AppControllerBloc extends Bloc<AppcontrollerEvent, AppControllerState> {
  final Connectivity _connectivity = Connectivity();
  AppControllerBloc()
      : super(const ConnectivityStatus(
          connectivityResult: ConnectivityResult.none,
        )) {
    _connectivity.onConnectivityChanged.listen((result) async {
      if (result == ConnectivityResult.mobile) {
        add(const ConnectivityChanged(ConnectivityResult.mobile));
      } else if (result == ConnectivityResult.wifi) {
        add(const ConnectivityChanged(ConnectivityResult.wifi));
      } else if (result == ConnectivityResult.vpn) {
        add(const ConnectivityChanged(ConnectivityResult.vpn));
      } else if (result == ConnectivityResult.none) {
        add(const ConnectivityChanged(ConnectivityResult.none));
      }
    });
    on<ConnectivityChanged>(_onConnectivityChanged);
  }
  void _onConnectivityChanged(
    ConnectivityChanged event,
    Emitter<AppControllerState> emit,
  ) {
    emit(ConnectivityStatus(
      connectivityResult: event.connectivityResult,
    ));
  }
}
