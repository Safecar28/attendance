part of '../main.dart';

final currentDate = StateProvider<DateTime>((ref) {
  return DateTime.now();
});

class CurrentDate extends ConsumerWidget {
  const CurrentDate({Key? key}) : super(key: key);

  void Function() _datePicker(BuildContext context, WidgetRef ref) {
    return () {
      final DateTime dt = DateTime.now().subtract(const Duration(days: 30));
      final DateTime lt = DateTime.now();
      showDatePicker(
              context: context,
              initialDate: ref.read(currentDate),
              firstDate: dt,
              helpText: 'Take attendance for',
              lastDate: lt)
          .then((val) {
        ref.read(currentDate.notifier).update((state) => val ?? state);
      });
    };
  }

  String _displayDt(DateTime d) => DateFormat('dd MMM ’yy').format(d);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final DateTime dt = ref.watch(currentDate);
    return ElevatedButton(
        onPressed: _datePicker(context, ref), child: Text(_displayDt(dt)));
  }
}
