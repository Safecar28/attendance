part of '../main.dart';

final currentAttendance = StateProvider<Attendance>((ref) {
  return Attendance(date: ref.watch(currentDate), status: AttendanceType.none);
});

final currentStudent = StateProvider<Student>((ref) {
  return Student();
});

class AttendancePage extends ConsumerWidget {
  const AttendancePage({
    Key? key,
    required this.students,
  }) : super(key: key);

  final List<Student> students;

  void navigateTo(Student s, int p, WidgetRef ref) {
    final idx = students.indexOf(s) + p;
    if (idx >= 0 && idx < students.length) {
      ref.read(currentStudent.notifier).update((state) => students[idx]);
    }
  }

  @override
  Widget build(context, ref) {
    var student = ref.watch(currentStudent);
    var state = ref.watch(currentAttendance);
    final notify = ref.read(currentAttendance.notifier);
    final choices = AttendanceType.values.map((e) => ListTile(
          title: Text(e.title),
          onTap: () => notify.update((state) {
            return Attendance(
                date: state.date,
                status: e,
                reason: state.reason,
                studentId: student.id);
          }),
          leading: Radio<AttendanceType>(
            value: e,
            groupValue: state.status,
            onChanged: (_) => {},
          ),
        ));
    return Scaffold(
      appBar: AppBar(title: Text(student.name())),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CurrentDate(),
            ...choices,
            if (state.status == AttendanceType.excused) ...[
              const Divider(),
              const ExcusedReason()
            ],
            const Divider(),
            AttendanceDisplay(student: student, att: state),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.red, minimumSize: const Size(100, 40)),
                    onPressed: () => navigateTo(student, -1, ref),
                    child: const Text('Previous')),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        minimumSize: const Size(100, 40)),
                    onPressed: () => navigateTo(student, 1, ref),
                    child: const Text('Next'))
              ],
            )
          ],
        ),
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
    var state = ref.watch(currentAttendance);
    final notify = ref.read(currentAttendance.notifier);
    return Padding(
      padding: const EdgeInsets.all(7),
      child: TextFormField(
        maxLength: 100,
        initialValue: state.reason,
        onChanged: (value) => notify.update((state) => state..reason = value),
        decoration: const InputDecoration.collapsed(hintText: 'Excused for?'),
      ),
    );
  }
}

class AttendanceDisplay extends ConsumerWidget {
  const AttendanceDisplay({
    Key? key,
    required this.student,
    required this.att,
  }) : super(key: key);

  final Student student;
  final Attendance att;

  @override
  Widget build(context, ref) {
    final date = DateFormat.Md().format(ref.watch(currentDate));
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Text(
        '${student.firstName} ${att.status?.display} on $date',
        style: TextStyle(color: Theme.of(context).primaryColorDark),
      ),
    );
  }
}
