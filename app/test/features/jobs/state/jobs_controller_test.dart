import 'package:flutter_test/flutter_test.dart';
import 'package:jobs_dashboard/features/jobs/domin/models/job_aggregate.dart';
import 'package:jobs_dashboard/features/jobs/state/jobs_controller.dart';
import 'package:jobs_dashboard/features/jobs/data/jobs_repository.dart';

class FakeJobsRepository implements JobsRepository {
  final List<JobAggregate> fakeData;

  FakeJobsRepository(this.fakeData);

  @override
  Future<List<JobAggregate>> fetchAggregates({
    List<Map<String, dynamic>>? body,
    bool useCache = true,
  }) async {
    return fakeData;
  }

  @override
  get api => throw UnimplementedError();

  @override
  get cache => throw UnimplementedError();
}

void main() {
  group('JobsController', () {
    test('toggleAppliedOnly filters jobs with at least 1 applied', () async {
      final controller = JobsController(FakeJobsRepository([
        JobAggregate(jobId: 101, counts: {'applied': 2, 'rejected': 1}),
        JobAggregate(jobId: 102, counts: {'applied': 0, 'rejected': 3}),
      ]));

      // Load fake data
      await controller.load();

      // Initially: should contain both jobs
      expect(controller.state.items.length, 2);
      expect(controller.visibleItems.length, 2);

      // Toggle filter on
      controller.toggleAppliedOnly();

      // Now: should only include job 101 (applied = 2)
      expect(controller.visibleItems.length, 1);
      expect(controller.visibleItems.first.jobId, 101);

      // Toggle filter off again
      controller.toggleAppliedOnly();
      expect(controller.visibleItems.length, 2);
    });

    test('toggleAppliedOnly can return empty list if no jobs have applied',
        () async {
      final controller = JobsController(FakeJobsRepository([
        JobAggregate(jobId: 201, counts: {'rejected': 4}),
        JobAggregate(jobId: 202, counts: {'rejected': 2, 'offer': 1}),
      ]));

      await controller.load();

      // Without filter → shows all jobs
      expect(controller.visibleItems.length, 2);

      // With filter → no job has applied, so list is empty
      controller.toggleAppliedOnly();
      expect(controller.visibleItems.isEmpty, true);
    });
  });
}
