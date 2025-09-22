import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../state/jobs_controller.dart';
import 'widgets/jobs_appbar.dart';
import 'widgets/filters_drawer.dart';
import 'widgets/job_list.dart';

final jobsControllerProvider =
    StateNotifierProvider<JobsController, JobsState>((ref) {
  throw UnimplementedError();
});

class JobsPage extends ConsumerWidget {
  static const routeName = '/jobs';
  const JobsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(jobsControllerProvider);
    final controller = ref.read(jobsControllerProvider.notifier);

    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      appBar: JobsAppBar(
        showAppliedOnly: state.showAppliedOnly,
        onFilterPressed: () => scaffoldKey.currentState?.openEndDrawer(),
      ),
      endDrawer: FiltersDrawer(
        showAppliedOnly: state.showAppliedOnly,
        onToggleAppliedOnly: controller.toggleAppliedOnly,
      ),
      body: state.loading
          ? const Center(child: CircularProgressIndicator())
          : JobList(
              items: controller.visibleItems,
              onRefresh: controller.load,
            ),
    );
  }
}
