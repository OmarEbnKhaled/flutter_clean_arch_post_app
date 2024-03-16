// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/error/map_failure_to_message_fn.dart';
import '../../../../../core/strrings/success_messages.dart';
import '../../../domain/entities/post.dart';
import '../../../domain/use_cases/add_post.dart';
import '../../../domain/use_cases/delete_post.dart';
import '../../../domain/use_cases/update_post.dart';

part 'add_delete_update_post_event.dart';
part 'add_delete_update_post_state.dart';

class AddDeleteUpdatePostBloc
    extends Bloc<AddDeleteUpdatePostEvent, AddDeleteUpdatePostState> {
  final AddPostUsecase addPost;
  final DeletePostUsecase deletePost;
  final UpdatePostUsecase updatePost;
  AddDeleteUpdatePostBloc({
    required this.deletePost,
    required this.updatePost,
    required this.addPost,
  }) : super(AddDeleteUpdatePostInitial()) {
    on<AddDeleteUpdatePostEvent>((event, emit) async {
      emit(LoadingAddDeleteUpdatePostState());

      final Either<Failure, Unit> failureOrDoneMessage;

      if (event is AddPostEvent) {
        failureOrDoneMessage = await addPost(event.post);
        emit(_mapFailureOrDoneMessage(
          failureOrDoneMessage,
          ADD_SUCCESS_MESSAGE,
        ));
      } else if (event is DeletePostEvent) {
        failureOrDoneMessage = await deletePost(event.postId);
        emit(_mapFailureOrDoneMessage(
          failureOrDoneMessage,
          DELETE_SUCCESS_MESSAGE,
        ));
      } else if (event is UpdatePostEvent) {
        failureOrDoneMessage = await updatePost(event.post);
        emit(_mapFailureOrDoneMessage(
          failureOrDoneMessage,
          UPDATE_SUCCESS_MESSAGE,
        ));
      }
    });
  }

  AddDeleteUpdatePostState _mapFailureOrDoneMessage(
    Either<Failure, Unit> either,
    String message,
  ) {
    return either.fold(
      (failure) => ErrorAddDeleteUpdatePostState(
        message: mapFailureToMessage(failure),
      ),
      (_) => MessageAddDeleteUpdatePostState(message: message),
    );
  }
}
