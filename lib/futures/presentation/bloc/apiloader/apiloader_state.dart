part of 'apiloader_bloc.dart';

abstract class ApiloaderState extends Equatable {
  const ApiloaderState(this.response);
  final ResponseModel response;
  @override
  List<Object> get props => [response];
}

class ApiloaderInitial extends ApiloaderState {
  const ApiloaderInitial(super.response);
  
}
