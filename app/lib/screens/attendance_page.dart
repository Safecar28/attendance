part of '../main.dart';

final currentAttendance = StateProvider.autoDispose<AttendanceType>((ref) {
  return AttendanceType.absent;
});

class AttendancePage extends ConsumerWidget {
  const AttendancePage({Key? key, required this.student}) : super(key: key);

  final Student student;

  @override
  Widget build(context, ref) {
    final s = student;
    var att = ref.watch(currentAttendance);
    final ratt = ref.read(currentAttendance.notifier);
    final date = ref.watch(currentDate);
    final attRadios = AttendanceType.values.map((e) => ListTile(
          title: Text(e.name),
          onTap: () {
            ratt.state = e;
          },
          leading: Radio<AttendanceType>(
            value: e,
            groupValue: att,
            onChanged: (v) {
              ratt.state = v!;
            },
          ),
        ));
    return Scaffold(
      appBar: AppBar(title: Text(s.name())),
      body: Column(
        children: [
          const Center(
            child: CurrentDate(),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
                '${student.name()} is ${att.name} on ${date.month}/${date.day}'),
          ),
          ...attRadios,
        ],
      ),
    );
  }
}
