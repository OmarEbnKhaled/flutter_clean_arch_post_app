part of 'add_delete_update_post_bloc.dart';

sealed class AddDeleteUpdatePostState extends Equatable {
  const AddDeleteUpdatePostState();

  @override
  List<Object> get props => [];
}

final class AddDeleteUpdatePostInitial extends AddDeleteUpdatePostState {}

final class LoadingAddDeleteUpdatePostState extends AddDeleteUpdatePostState {}

final class MessageAddDeleteUpdatePostState extends AddDeleteUpdatePostState {
  final String message;

  const MessageAddDeleteUpdatePostState({required this.message});

  @override
  List<Object> get props => [];
}

final class ErrorAddDeleteUpdatePostState extends AddDeleteUpdatePostState {
  final String message;

  const ErrorAddDeleteUpdatePostState({required this.message});

  @override
  List<Object> get props => [message];
}
