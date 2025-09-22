import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/api_client.dart';
import 'features/jobs/data/jobs_repository.dart';
import 'features/jobs/presentation/jobs_page.dart';
import 'features/jobs/state/jobs_controller.dart';
import 'core/theme/app_theme.dart';

void main() {
  const baseUrl = String.fromEnvironment('API_BASE',
      defaultValue:
          'http://localhost:3000'); // TODO: add environments dev and prod
  final providerContainer = ProviderContainer(overrides: [
    jobsControllerProvider.overrideWith((ref) {
      final api = ApiClient(baseUrl);
      final repo = JobsRepository(api);
      return JobsController(repo);
    })
  ]);
  runApp(UncontrolledProviderScope(
      container: providerContainer, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jobs Dashboard',
      theme: AppTheme.lightTheme,
      initialRoute: JobsPage.routeName,
      routes: {
        JobsPage.routeName: (_) => const JobsPage(),
      },
    );
  }
}
