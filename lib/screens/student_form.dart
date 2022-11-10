part of '../main.dart';

class StudentForm extends ConsumerStatefulWidget {
  const StudentForm(
      {Key? key,
      this.id,
      this.firstName = '',
      this.lastName = '',
      required this.homeroom})
      : super(key: key);

  final String? id;
  final String firstName;
  final String lastName;
  final Homeroom homeroom;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _StudentFormState();
}

class _StudentFormState extends ConsumerState<StudentForm> {
  var _firstName = '';
  var _lastName = '';
  var editing = false;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _firstName = widget.firstName;
    _lastName = widget.lastName;
    editing = widget.id != null;
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
        title: Text(
            editing ? "${widget.firstName} ${widget.lastName}" : "Add Student"),
        actions: [
          IconButton(
              onPressed: () {
                final id = widget.id ?? studentID();
                FirebaseDatabase.instance
                    .ref("students/$id")
                    .set({'id': id, 'name': _firstName, 'lastName': _lastName})
                    .then((value) => Navigator.pop(context))
                    .onError((error, stackTrace) => print(error));
                FirebaseDatabase.instance
                    .ref("homerooms/${widget.homeroom.id}/students")
                    .set([...widget.homeroom.studentIds, id]);
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
