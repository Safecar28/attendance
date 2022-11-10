part of '../main.dart';

class AttendancePage extends ConsumerWidget {
  const AttendancePage({Key? key, required this.student}) : super(key: key);

  final Student student;

  @override
  Widget build(context, ref) {
    final s = student;
    return Scaffold(
      appBar: AppBar(title: Text(s.name())),
      body: Column(
        children: [
          const Center(
            child: CurrentDate(),
          ),
          Column(
            children: List<Widget>.generate(
              3,
              (int index) {
                return ChoiceChip(
                  label: Text('Item $index'),
                  selected: 1 == index,
                );
              },
            ).toList(),
          )
        ],
      ),
    );
  }
}
