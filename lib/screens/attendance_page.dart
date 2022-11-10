part of '../main.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({Key? key, required this.student}) : super(key: key);

  final Student student;

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  DateTime _selectedDate = DateTime.now();

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 7)))
        .then((pickedDate) {
      // Check if no date is selected
      if (pickedDate == null) return;

      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final s = widget.student;
    return Scaffold(
      appBar: AppBar(title: Text(s.name())),
      body: Center(
          child: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                _presentDatePicker();
              },
              child: Text(_displayDate()))
        ],
      )),
    );
  }

  String _displayDate() => DateFormat("dd MMM ’yy").format(_selectedDate);
}
