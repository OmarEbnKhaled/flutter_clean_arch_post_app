import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/post.dart';
import '../repositories/posts_repository.dart';

class UpdatePostUsecase {
  final PostsRepository repository;

  UpdatePostUsecase({required this.repository});

  Future<Either<Failure, Unit>> call(Post post) async {
    return repository.updatePost(post);
  }
}