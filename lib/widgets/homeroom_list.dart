part of '../main.dart';

class HomeroomList extends StatelessWidget {
  const HomeroomList({
    Key? key,
    required Iterable<Homeroom> homerooms,
    required Future<Iterable<Student>> students,
  })  : _homerooms = homerooms,
        _students = students,
        super(key: key);

  final Iterable<Homeroom> _homerooms;
  final Future<Iterable<Student>> _students;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Iterable<Student>>(
        future: _students,
        builder: ((context, snapshot) {
          if (!snapshot.hasData) return const Wait();

          return ListView.builder(
              itemCount: _homerooms.length,
              itemBuilder: (context, index) {
                final homeroom = _homerooms.elementAt(index);
                return ListTile(
                  title: Text(homeroom.name),
                  subtitle: Text("${homeroom.studentIds.length} students"),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StudentPage(
                                  homeroomId: homeroom.id,
                                  allStudents: snapshot.data!,
                                )));
                  },
                );
              });
        }));
  }
}
