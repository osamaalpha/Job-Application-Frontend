import 'package:flutter/material.dart';
import '../../domin/models/job_aggregate.dart';
import 'job_tile.dart';

class JobList extends StatelessWidget {
  final List<JobAggregate> items;
  final Future<void> Function() onRefresh;

  const JobList({
    super.key,
    required this.items,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.separated(
        itemCount: items.length,
        separatorBuilder: (_, __) => const Divider(height: 0),
        itemBuilder: (context, i) => JobTile(item: items[i]),
      ),
    );
  }
}
