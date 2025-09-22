import 'package:flutter/material.dart';
import '../../domin/models/job_aggregate.dart';

class JobTile extends StatelessWidget {
  final JobAggregate item;
  const JobTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final countsStr =
        item.counts.entries.map((e) => '${e.key}: ${e.value}').join(', ');
    return ListTile(
      title: Text('Job ${item.jobId}'),
      subtitle: Text(countsStr),
    );
  }
}
