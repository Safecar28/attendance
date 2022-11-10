part of '../main.dart';

class StudentForm extends ConsumerStatefulWidget {
  const StudentForm({Key? key, required this.homeroom, this.student})
      : super(key: key);

  final Student? student;
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
    if (widget.student != null) {
      _firstName = widget.student!.firstName;
      _lastName = widget.student!.lastName;
      editing = widget.student!.id != '';
    }
  }

  void setFirstName(String val) {
    setState(() {
      _firstName = val.trim();
    });
  }

  void setLastName(String val) {
    setState(() {
      _lastName = val.trim();
    });
  }

  void Function() _removeStudent(BuildContext context) {
    return () {
      widget.student!
          .removeFrom(widget.homeroom)
          .then((value) => Navigator.pop(context))
          .onError((error, stackTrace) => print(error));
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(editing ? 'Edit $_firstName $_lastName' : 'Add Student'),
        actions: [
          IconButton(
              onPressed: () {
                Student.upsertStudent(widget.student?.id, _firstName, _lastName,
                        widget.homeroom)
                    .then((value) => Navigator.pop(context))
                    .onError((error, stackTrace) => print(error));
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
            const SizedBox(height: 45),
            editing
                ? ElevatedButton(
                    onPressed: _removeStudent(context),
                    style: deleteButtonStyle,
                    child:
                        Text('Remove $_firstName from ${widget.homeroom.name}'),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}

final deleteButtonStyle = TextButton.styleFrom(
    backgroundColor: Colors.redAccent,
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30));
