import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../providers/database_provider.dart';
import 'meet_detail_screen.dart';

class MeetFormScreen extends ConsumerStatefulWidget {
  const MeetFormScreen({super.key});

  @override
  ConsumerState<MeetFormScreen> createState() => _MeetFormScreenState();
}

class _MeetFormScreenState extends ConsumerState<MeetFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _locationController = TextEditingController();
  final _durationController = TextEditingController(text: '90');
  DateTime _date = DateTime.now();
  TimeOfDay _time = TimeOfDay.now();
  int _courtCount = 1;
  bool _saving = false;

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime.now().subtract(const Duration(days: 1)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) setState(() => _date = picked);
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(context: context, initialTime: _time);
    if (picked != null) setState(() => _time = picked);
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    final scheduledAt =
        DateTime(_date.year, _date.month, _date.day, _time.hour, _time.minute);
    final meetId = await ref.read(databaseProvider).createMeet(
          name: _nameController.text.trim(),
          scheduledAt: scheduledAt,
          durationMinutes: int.parse(_durationController.text.trim()),
          location: _locationController.text.trim(),
          courtCount: _courtCount,
        );
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => MeetDetailScreen(meetId: meetId)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('EEE, MMM d, yyyy');

    return Scaffold(
      appBar: AppBar(title: const Text('New meet')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Meet name'),
              validator: (value) =>
                  (value == null || value.trim().isEmpty) ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _pickDate,
                    icon: const Icon(Icons.calendar_today),
                    label: Text(dateFormat.format(_date)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _pickTime,
                    icon: const Icon(Icons.access_time),
                    label: Text(_time.format(context)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _durationController,
              decoration: const InputDecoration(labelText: 'Duration (minutes)'),
              keyboardType: TextInputType.number,
              validator: (value) {
                final n = int.tryParse(value?.trim() ?? '');
                if (n == null || n <= 0) return 'Enter a valid number of minutes';
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _locationController,
              decoration: const InputDecoration(labelText: 'Location'),
              validator: (value) =>
                  (value == null || value.trim().isEmpty) ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('Courts'),
                const Spacer(),
                IconButton(
                  onPressed:
                      _courtCount > 1 ? () => setState(() => _courtCount--) : null,
                  icon: const Icon(Icons.remove_circle_outline),
                ),
                Text('$_courtCount', style: Theme.of(context).textTheme.titleMedium),
                IconButton(
                  onPressed:
                      _courtCount < 12 ? () => setState(() => _courtCount++) : null,
                  icon: const Icon(Icons.add_circle_outline),
                ),
              ],
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _saving ? null : _save,
              child: _saving
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Create meet'),
            ),
          ],
        ),
      ),
    );
  }
}
