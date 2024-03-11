import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/post.dart';
import '../repositories/posts_repository.dart';

class GetAllPostsUescase {
  final PostsRepository repository;

  GetAllPostsUescase({required this.repository});

  Future<Either<Failure, List<Post>>> call() async {
    return await repository.getAllPosts();
  }
}