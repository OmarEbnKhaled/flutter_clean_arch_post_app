import '../strrings/failure_messages.dart';
import 'failure.dart';

String mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure _:
        return SERVER_FAILURE_MESSAGE;

      case EmptyCacheFailure _:
        return EMPTY_CACHE_FAILURE_MESSAGE;

      case OfflineFailure _:
        return OFFLINE_FAILURE_MESSAGE;

      default:
        return "Unexpected Error, Please try again later.";
    }
  }