import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../state/jobs_controller.dart';
import 'widgets/job_tile.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

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
      appBar: AppBar(
        title: const Text('Job Applications'),
        actions: [
          IconButton(
            tooltip: 'Filters',
            onPressed: () {
              scaffoldKey.currentState?.openEndDrawer();
            },
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  MdiIcons.tune,
                  color: state.showAppliedOnly ? Colors.amber : Colors.black,
                ),
                if (state.showAppliedOnly)
                  Positioned(
                    right: -2,
                    top: -2,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      constraints:
                          const BoxConstraints(minWidth: 14, minHeight: 14),
                      child: const Text(
                        '1',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      endDrawer: Drawer(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Filters',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const Divider(),
              SwitchListTile(
                title: const Text('Show only jobs with applied applicants'),
                value: state.showAppliedOnly,
                onChanged: (_) => controller.toggleAppliedOnly(),
              ),
            ],
          ),
        ),
      ),
      body: state.loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: controller.load,
              child: ListView.separated(
                itemCount: controller.visibleItems.length,
                separatorBuilder: (_, __) => const Divider(height: 0),
                itemBuilder: (context, i) =>
                    JobTile(item: controller.visibleItems[i]),
              ),
            ),
    );
  }
}
