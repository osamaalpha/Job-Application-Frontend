class JobAggregate {
  final int jobId;
  final Map<String, int> counts;
  JobAggregate({required this.jobId, required this.counts});

  factory JobAggregate.fromJson(Map<String, dynamic> json) => JobAggregate(
        jobId: json['jobId'] as int,
        counts: (json['counts'] as Map<String, dynamic>)
            .map((k, v) => MapEntry(k, v as int)),
      );
}
