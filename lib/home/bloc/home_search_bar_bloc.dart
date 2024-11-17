import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';

part 'home_search_bar_event.dart';
part 'home_search_bar_state.dart';

class HomeSearchBarBloc extends Bloc<HomeSearchBarEvent, HomeSearchBarState> {
  HomeSearchBarBloc() : super(HomeSearchBarInitial()) {
    on<HomeSearchBarEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
