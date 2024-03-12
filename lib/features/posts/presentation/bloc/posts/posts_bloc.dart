// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/error/map_failure_to_message_fn.dart';
import '../../../domain/entities/post.dart';
import '../../../domain/use_cases/get_all_posts.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPostsUescase getAllPosts;
  PostsBloc({
    required this.getAllPosts,
  }) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetAllPostsEvent || event is RefreshPostsEvent) {
        emit(LoadingPostsState());

        final failureOrPosts = await getAllPosts();
        _mapFailureOrPostsState(failureOrPosts);
      }
    });
  }

  PostsState _mapFailureOrPostsState(Either<Failure, List<Post>> either) {
    return either.fold(
      (failure) => ErrorPostsState(message: mapFailureToMessage(failure)),
      (posts) => LoadedPostsState(posts: posts),
    );
  }
}
