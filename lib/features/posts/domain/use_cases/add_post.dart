import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/post.dart';
import '../repositories/posts_repository.dart';

class AddPostUsecase {
  final PostsRepository repository;

  AddPostUsecase({required this.repository});

  Future<Either<Failure, Unit>> call(Post post) async {
    return repository.addPost(post);
  }
}