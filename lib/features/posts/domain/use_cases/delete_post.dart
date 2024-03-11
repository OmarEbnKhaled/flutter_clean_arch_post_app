import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../repositories/posts_repository.dart';

class DeletePostUsecase {
  final PostsRepository repository;

  DeletePostUsecase({required this.repository});

  Future<Either<Failure, Unit>> call(int id) async {
    return await repository.deletePost(id);
  }
}