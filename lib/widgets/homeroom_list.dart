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
                final sp = StudentPage(homeroomId: h.id, data: snapshot.data!);
                // return list
                return ListTile(
                  title: Text(h.name),
                  subtitle: Text("${h.studentIds.length} students"),
                  onTap: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => sp));
                  },
                );
              });
        }));
  }
}
