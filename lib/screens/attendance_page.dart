part of '../main.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({Key? key, required this.student}) : super(key: key);

  final Student student;

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  DateTime _dt = DateTime.now();
  final DateTime _lt = DateTime.now().add(const Duration(days: 7));

  void _datePicker() {
    showDatePicker(
            context: context, initialDate: _dt, firstDate: _dt, lastDate: _lt)
        .then((val) {
      setState(() => _dt = val ?? _dt);
    });
  }

  @override
  Widget build(BuildContext context) {
    final s = widget.student;
    return Scaffold(
      appBar: AppBar(title: Text(s.name())),
      body: Column(
        children: [
          Center(
            child: ElevatedButton(
                style: TextButton.styleFrom(
                    primary: Colors.indigo, backgroundColor: Colors.white70),
                onPressed: _datePicker,
                child: Text(_displayDt())),
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

  String _displayDt() => DateFormat("dd MMM ’yy").format(_dt);
}
