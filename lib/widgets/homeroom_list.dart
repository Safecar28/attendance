part of '../main.dart';

class HomeroomList extends StatelessWidget {
  const HomeroomList({
    Key? key,
    required this.homerooms,
    required this.students,
  }) : super(key: key);

  final Iterable<Homeroom> homerooms;
  final Future<Iterable<Student>> students;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Iterable<Student>>(
        future: students,
        builder: ((context, snapshot) {
          if (!snapshot.hasData) return const Wait();

          return ListView.builder(
              itemCount: homerooms.length,
              itemBuilder: (context, index) {
                final h = homerooms.elementAt(index);
                final num = h.studentIds.length;
                final page =
                    StudentPage(homeroomId: h.id, data: snapshot.data!);

                // return list
                return StudentCard(
                    child: ListTile(
                  title: Text(h.name),
                  subtitle: Text("$num students"),
                  onTap: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => page));
                  },
                ));
              });
        }));
  }
}

class StudentCard extends StatelessWidget {
  const StudentCard({
    Key? key,
    required this.child,
  }) : super(key: key);

  final ListTile child;

  @override
  Widget build(BuildContext context) {
    return Card(
        shadowColor: Colors.lightGreenAccent,
        clipBehavior: Clip.antiAlias,
        surfaceTintColor: Colors.deepPurpleAccent,
        elevation: 1,
        child: child);
  }
}
