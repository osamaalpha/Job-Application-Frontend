import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/jobs_repository.dart';
import '../domin/models/job_aggregate.dart';
import '../../../core/error_handler.dart';

class JobsState {
  final List<JobAggregate> items;
  final bool loading;
  final bool showAppliedOnly;
  JobsState({
    required this.items,
    this.loading = false,
    this.showAppliedOnly = false,
  });

  JobsState copyWith({
    List<JobAggregate>? items,
    bool? loading,
    bool? showAppliedOnly,
  }) =>
      JobsState(
        items: items ?? this.items,
        loading: loading ?? this.loading,
        showAppliedOnly: showAppliedOnly ?? this.showAppliedOnly,
      );
}

class JobsController extends StateNotifier<JobsState> {
  final JobsRepository repo;
  JobsController(this.repo) : super(JobsState(items: const [], loading: true)) {
    load();
  }

  Future<void> load() async {
    try {
      state = state.copyWith(loading: true);
      final data = await repo.fetchAggregates();
      state = state.copyWith(items: data, loading: false);
    } catch (e, s) {
      handleError(e, s);
      state = state.copyWith(loading: false);
    }
  }

  void toggleAppliedOnly() {
    state = state.copyWith(showAppliedOnly: !state.showAppliedOnly);
  }

  List<JobAggregate> get visibleItems => state.showAppliedOnly
      ? state.items
          .where((j) => j.counts['applied'] != null && j.counts['applied']! > 0)
          .toList()
      : state.items;
}
