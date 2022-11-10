part of '../main.dart';

class HomeroomForm extends ConsumerStatefulWidget {
  const HomeroomForm({Key? key, this.name = '', this.id}) : super(key: key);

  final String? id;
  final String name;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeroomFormState();
}

class _HomeroomFormState extends ConsumerState<HomeroomForm> {
  var _name = '';

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _name = widget.name;
  }

  void setName(String val) {
    setState(() {
      _name = val.trim();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.id != null ? widget.name : 'Add Homeroom'),
        actions: [
          IconButton(
              onPressed: () {
                Homeroom.upsertHomeroom(widget.id, _name)
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
              label: 'Homeroom Name',
              value: _name,
              setState: setName,
            ),
          ],
        ),
      ),
    );
  }
}
