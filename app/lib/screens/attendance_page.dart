part of '../main.dart';

final currentAttendance = StateProvider.autoDispose<AttendanceType>((ref) {
  return AttendanceType.none;
});

class AttendancePage extends ConsumerWidget {
  const AttendancePage({Key? key, required this.student}) : super(key: key);

  final Student student;

  @override
  Widget build(context, ref) {
    var state = ref.watch(currentAttendance);
    final notify = ref.read(currentAttendance.notifier);
    final date = DateFormat.Md().format(ref.watch(currentDate));
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
          const Center(
            child: CurrentDate(),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              '${student.firstName} ${state.titleVerb} on $date',
              style: const TextStyle(color: Colors.blueGrey),
            ),
          ),
          ...choices,
        ],
      ),
    );
  }
}
