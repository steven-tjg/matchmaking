import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../data/database.dart';
import '../providers/database_provider.dart';
import 'meet_detail_screen.dart';

class MeetFormScreen extends ConsumerStatefulWidget {
  final Meet? meet;

  const MeetFormScreen({super.key, this.meet});

  @override
  ConsumerState<MeetFormScreen> createState() => _MeetFormScreenState();
}

const _locationOptions = [
  'The Khourt',
  'Sempurna Tennis Center',
  'Kin Urban Ground',
  'The Racket Club',
  'Terminal Sports Center',
  'The Orange Court',
  'Quantum Sports',
];

class _MeetFormScreenState extends ConsumerState<MeetFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  String? _location;
  int _durationHours = 1;
  DateTime _date = DateTime.now();
  TimeOfDay _time = TimeOfDay.now();
  int _courtCount = 1;
  bool _saving = false;

  bool get _isEditing => widget.meet != null;

  @override
  void initState() {
    super.initState();
    final meet = widget.meet;
    if (meet != null) {
      _nameController.text = meet.name;
      _location = meet.location;
      _durationHours = (meet.durationMinutes / 60).round().clamp(1, 8).toInt();
      _date = meet.scheduledAt;
      _time = TimeOfDay(hour: meet.scheduledAt.hour, minute: meet.scheduledAt.minute);
      _courtCount = meet.courtCount;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
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
    var selected = DateTime(0, 1, 1, _time.hour);
    final confirmed = await showCupertinoModalPopup<bool>(
      context: context,
      builder: (context) => Container(
        height: 300,
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CupertinoButton(
                    child: const Text('Cancel'),
                    onPressed: () => Navigator.of(context).pop(false),
                  ),
                  CupertinoButton(
                    child: const Text('Done'),
                    onPressed: () => Navigator.of(context).pop(true),
                  ),
                ],
              ),
              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.time,
                  initialDateTime: selected,
                  minuteInterval: 60,
                  onDateTimeChanged: (value) => selected = value,
                ),
              ),
            ],
          ),
        ),
      ),
    );
    if (confirmed == true) {
      setState(() => _time = TimeOfDay(hour: selected.hour, minute: 0));
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    final scheduledAt =
        DateTime(_date.year, _date.month, _date.day, _time.hour, _time.minute);
    final db = ref.read(databaseProvider);

    if (_isEditing) {
      await db.updateMeet(widget.meet!.copyWith(
        name: _nameController.text.trim(),
        scheduledAt: scheduledAt,
        durationMinutes: _durationHours * 60,
        location: _location!,
        courtCount: _courtCount,
      ));
      if (!mounted) return;
      Navigator.of(context).pop();
      return;
    }

    final meetId = await db.createMeet(
      name: _nameController.text.trim(),
      scheduledAt: scheduledAt,
      durationMinutes: _durationHours * 60,
      location: _location!,
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
      appBar: AppBar(title: Text(_isEditing ? 'Edit meet' : 'New meet')),
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
            DropdownButtonFormField<int>(
              initialValue: _durationHours,
              decoration: const InputDecoration(labelText: 'Duration'),
              items: [
                for (var hours = 1; hours <= 8; hours++)
                  DropdownMenuItem(
                    value: hours,
                    child: Text(hours == 1 ? '1 hour' : '$hours hours'),
                  ),
              ],
              onChanged: (value) {
                if (value != null) setState(() => _durationHours = value);
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _location,
              decoration: const InputDecoration(labelText: 'Location'),
              items: [
                for (final option in _locationOptions)
                  DropdownMenuItem(value: option, child: Text(option)),
              ],
              onChanged: (value) => setState(() => _location = value),
              validator: (value) => value == null ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.sports_tennis, color: Theme.of(context).colorScheme.onSurfaceVariant),
                  const SizedBox(width: 12),
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
                  : Text(_isEditing ? 'Save changes' : 'Create meet'),
            ),
          ],
        ),
      ),
    );
  }
}
