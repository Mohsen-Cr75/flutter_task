part of 'appcontroller_bloc.dart';




abstract class AppControllerState extends Equatable {
  const AppControllerState({this.connectivityResult,});
 
  final ConnectivityResult? connectivityResult;

  @override
  List<Object> get props => [connectivityResult ?? ConnectivityResult.none];
}



class ConnectivityStatus extends AppControllerState {
  const ConnectivityStatus({
    required ConnectivityResult super.connectivityResult,
  });
}
