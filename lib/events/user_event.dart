import 'package:equatable/equatable.dart';
import '../models/user_model.dart';

abstract class UserEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadUserEvent extends UserEvent {}

class UpdateUserEvent extends UserEvent {
  final int id;
  final User user;

  UpdateUserEvent({required this.id, required this.user});

  @override
  List<Object> get props => [id, user];
}
