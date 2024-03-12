import '../strrings/failure_messages.dart';
import 'failure.dart';

String mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case const (ServerFailure):
        return SERVER_FAILURE_MESSAGE;

      case const (EmptyCacheFailure) :
        return EMPTY_CACHE_FAILURE_MESSAGE;

      case const (OfflineFailure) :
        return OFFLINE_FAILURE_MESSAGE;

      default:
        return "Unexpected Error, Please try again later.";
    }
  }