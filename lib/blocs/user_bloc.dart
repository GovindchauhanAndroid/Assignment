import 'package:flutter_bloc/flutter_bloc.dart';

import '../events/user_event.dart';
import '../services/user_api_service.dart';
import '../states/user_state.dart';


class UserBloc extends Bloc<UserEvent, UserState> {
  UserApiService? userApiService;

  UserBloc() : super(UserInitial()) {
    on<LoadUserEvent>((event, emit) async {
    try {
      final users = await UserApiService().getUsers();
      emit(UserLoaded(users: users));
    } on UserRepositoryException catch (e) {
      emit(UserError(message: 'Repository error: ${e.message}'));
    } on Exception catch (e) {
      emit(UserError(message: 'Unexpected error: ${e.toString()}'));
    }
    });
  }
}
class UserRepositoryException implements Exception {
  final String message;
  UserRepositoryException(this.message);

  @override
  String toString() => message;
}