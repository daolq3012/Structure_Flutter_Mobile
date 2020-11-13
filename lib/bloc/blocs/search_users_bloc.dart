import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:structure_flutter_mobile/bloc/events/search_users_event.dart';
import 'package:structure_flutter_mobile/bloc/states/search_users_state.dart';
import 'package:structure_flutter_mobile/data/source/remote/service/callback.dart';
import 'package:structure_flutter_mobile/repositories/user_repository.dart';

class SearchUserBloc extends Bloc<SearchUserEvent, SearchUserState> {
  final UserRepository userRepository;
  final String keyword = "daol";

  SearchUserBloc(this.userRepository) : super(SearchUserInitialized());

  @override
  Stream<SearchUserState> mapEventToState(SearchUserEvent event) async* {
    if (event is FetchUsersEvent && _canFetchData(state)) {
      if (state is SearchUserInitialized) {
        Callback result = await userRepository.searchUsers(keyword);
        yield result.when(
          onSuccess: (data) {
            return SearchUserLoaded(users: data, hasReachMax: false);
          },
          onFailure: (e) {
            return SearchUserError();
          },
        );
      } else if (state is SearchUserLoaded) {
        final currentState = state as SearchUserLoaded;
        // increase page
        int page = (currentState.users.length / 10).ceil() + 1;
        Callback result = await userRepository.searchUsers(keyword, page: page);
        yield result.when(
          onSuccess: (data) {
            return SearchUserLoaded(
                users: currentState.users + data, hasReachMax: false);
          },
          onFailure: (e) {
            return SearchUserError();
          },
        );
      }
    }
  }

  bool _canFetchData(SearchUserState state) {
    return (state is SearchUserLoaded && !state.hasReachMax) ||
        state is SearchUserInitialized;
  }
}
