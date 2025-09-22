import 'package:flutter/material.dart';

class FiltersDrawer extends StatelessWidget {
  final bool showAppliedOnly;
  final VoidCallback onToggleAppliedOnly;

  const FiltersDrawer({
    super.key,
    required this.showAppliedOnly,
    required this.onToggleAppliedOnly,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
              value: showAppliedOnly,
              onChanged: (_) => onToggleAppliedOnly(),
            ),
            // 🔮 Future: add more filters here
          ],
        ),
      ),
    );
  }
}
