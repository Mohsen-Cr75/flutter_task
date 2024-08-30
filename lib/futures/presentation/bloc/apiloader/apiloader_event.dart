part of 'apiloader_bloc.dart';

abstract class ApiLoaderEvent extends Equatable {
  const ApiLoaderEvent();

  @override
  List<Object> get props => [];
}

class LoadUsersFromApi extends ApiLoaderEvent {
  const LoadUsersFromApi();
}
