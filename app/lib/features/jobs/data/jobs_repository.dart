import 'package:jobs_dashboard/core/api_client.dart';
import 'package:jobs_dashboard/core/cache.dart';
import 'package:jobs_dashboard/features/jobs/domin/models/job_aggregate.dart';

class JobsRepository {
  final ApiClient api;
  final SimpleCache<List<JobAggregate>> cache;

  JobsRepository(this.api)
      : cache = SimpleCache(ttl: const Duration(seconds: 60));

  Future<List<JobAggregate>> fetchAggregates({
    bool useCache =
        true, // Switch cache off by putting this to false TODO:This also should be environmental should be moved from here
    List<Map<String, dynamic>>? body,
  }) async {
    if (useCache) {
      final cached = cache.get();
      if (cached != null) return cached;
    }

    final res = await api.post('/api/jobs/aggregate', data: body);

    final list = (res.data as List<dynamic>)
        .map((e) => JobAggregate.fromJson(e as Map<String, dynamic>))
        .toList();

    cache.set(list);
    return list;
  }
}
