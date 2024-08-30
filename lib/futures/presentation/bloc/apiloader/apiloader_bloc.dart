
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/futures/domain/response_model.dart';

import '../../../data/repasitoryimpl.dart';

part 'apiloader_event.dart';
part 'apiloader_state.dart';

class ApiLoaderBloc extends Bloc<ApiLoaderEvent, ApiloaderState> {

  ApiLoaderBloc() : super(const ApiloaderInitial(ResponseModel(users: [],statusCode:400,title: ''))) {
    on<LoadUsersFromApi>(_onLoadUsersFromApi);
  }





Future<void> _onLoadUsersFromApi(
    LoadUsersFromApi event,
    Emitter<ApiloaderState> emit,
  ) async {
 RepasitoryImpl repositoryImpl = RepasitoryImpl();
 ResponseModel result= await repositoryImpl.getUsersData();
 if (result.statusCode==200) {
    emit(ApiloaderInitial(result));
 }if (result.statusCode ==400) {
   emit(ApiloaderInitial(result));
 }if (result.statusCode ==500) {
   emit(ApiloaderInitial(result));
 }
  }
}


 