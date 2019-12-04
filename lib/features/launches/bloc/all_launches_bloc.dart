import 'package:spacex_guide/features/launches/bloc/all_launches_events.dart';
import 'package:spacex_guide/features/launches/bloc/all_launches_states.dart';
import 'package:spacex_guide/features/launches/data/repositories/launch_repository.dart';
import 'package:bloc/bloc.dart';

class AllLaunchesBloc extends Bloc<AllLaunchesEvent, AllLaunchesState> {
  final _repo = LaunchRepository();

  @override
  AllLaunchesState get initialState => AllLaunchesEmpty();

  @override
  Stream<AllLaunchesState> mapEventToState(AllLaunchesEvent event) async* {
    if (event is GetAllLaunches) {
      yield AllLaunchesLoading();

      try {
        final launches = await _repo.getAllLaunches();
        yield AllLaunchesLoaded(launches);
      } catch (_) {
        yield AllLaunchesError();
      }
    }
  }
}