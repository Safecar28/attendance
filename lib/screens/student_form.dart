part of '../main.dart';

class StudentForm extends ConsumerStatefulWidget {
  const StudentForm(
      {Key? key, this.id, this.firstName = '', this.lastName = ''})
      : super(key: key);

  final String? id;
  final String firstName;
  final String lastName;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _StudentFormState();
}

class _StudentFormState extends ConsumerState<StudentForm> {
  var _firstName = '';
  var _lastName = '';

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _firstName = widget.firstName;
    _lastName = widget.lastName;
  }

  void setFirstName(String val) {
    setState(() {
      _firstName = val;
    });
  }

  void setLastName(String val) {
    setState(() {
      _lastName = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.id != null
            ? "${widget.firstName} ${widget.lastName}"
            : "Add Student"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.save_rounded))
        ],
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextInput(
              label: 'First Name',
              value: _firstName,
              setState: setFirstName,
            ),
            TextInput(
              label: 'Last Name',
              value: _lastName,
              setState: setLastName,
            ),
          ],
        ),
      ),
    );
  }
}

class TextInput extends StatelessWidget {
  const TextInput({
    Key? key,
    required this.label,
    required this.value,
    required this.setState,
  }) : super(key: key);

  final String label;
  final String value;
  final void Function(String) setState;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextFormField(
        initialValue: value,
        onChanged: setState,
        decoration: InputDecoration(
            border: const UnderlineInputBorder(), labelText: label),
      ),
    );
  }
}
