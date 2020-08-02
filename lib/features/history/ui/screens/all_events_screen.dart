import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/ui/widgets/center_progress_indicator.dart';
import 'package:spacex_guide/core/ui/widgets/app_scaffold.dart';
import 'package:spacex_guide/core/ui/widgets/default_texts.dart';
import 'package:spacex_guide/features/history/bloc/all_events_list/all_events_list_cubit.dart';
import 'package:spacex_guide/features/history/ui/widgets/all_events_list.dart';

class AllEventsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) => AllEventsListCubit(
      repository: RepositoryProvider.of(context),
    )..getAllEvents(),
    child: _scaffold,
  );

  // Widget
  
  Widget get _scaffold => AppScaffold(
    title: Text('All Events'),
    child: _eventList,
  );

  Widget get _eventList => BlocBuilder<AllEventsListCubit, AllEventsListState>(
    builder: (context, state) {
      if (state is AllEventsListLoading) {
        return CenterProgressIndicator();
      }

      if (state is AllEventsListLoaded) {
        return AllEventsList(events: state.allEvents,);
      }

      return DefaultScreenError();
    },
  );
}