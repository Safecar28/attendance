part of '../main.dart';

final currentAttendance = StateProvider.autoDispose<AttendanceType>((ref) {
  return AttendanceType.none;
});

final currentReason = StateProvider<String>((ref) {
  return '';
});

class AttendancePage extends ConsumerWidget {
  const AttendancePage({Key? key, required this.student}) : super(key: key);

  final Student student;

  @override
  Widget build(context, ref) {
    var state = ref.watch(currentAttendance);
    final notify = ref.read(currentAttendance.notifier);
    final choices = AttendanceType.values.map((e) => ListTile(
          title: Text(e.title),
          onTap: () => notify.state = e,
          leading: Radio<AttendanceType>(
            value: e,
            groupValue: state,
            onChanged: (_) => notify.state = e,
          ),
        ));
    return Scaffold(
      appBar: AppBar(title: Text(student.name())),
      body: Column(
        children: [
          const Center(child: CurrentDate()),
          AttendanceDisplay(student: student, state: state),
          ...choices,
          const Divider(),
          if (state == AttendanceType.excused) const ExcusedReason()
        ],
      ),
    );
  }
}

class ExcusedReason extends ConsumerWidget {
  const ExcusedReason({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(context, ref) {
    var state = ref.watch(currentReason);
    final notify = ref.read(currentReason.notifier);
    return Padding(
      padding: const EdgeInsets.all(7),
      child: TextFormField(
        maxLength: 100,
        initialValue: state,
        onChanged: (value) => notify.state = value,
        decoration: const InputDecoration.collapsed(hintText: 'Excused for?'),
      ),
    );
  }
}

class AttendanceDisplay extends ConsumerWidget {
  const AttendanceDisplay({
    Key? key,
    required this.student,
    required this.state,
  }) : super(key: key);

  final Student student;
  final AttendanceType state;

  @override
  Widget build(context, ref) {
    final date = DateFormat.Md().format(ref.watch(currentDate));
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Text(
        '${student.firstName} ${state.display} on $date',
        style: TextStyle(color: Theme.of(context).primaryColorDark),
      ),
    );
  }
}
