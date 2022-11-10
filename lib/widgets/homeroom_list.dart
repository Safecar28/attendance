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
  Widget build(BuildContext context) => FutureBuilder<Iterable<Student>>(
      future: students,
      builder: ((context, snapshot) {
        if (!snapshot.hasData) return const Wait();

        return ListView.builder(
            itemCount: homerooms.length,
            itemBuilder: (context, index) {
              final h = homerooms.elementAt(index);
              final num = h.studentIds.length;
              final page = StudentPage(homeroomId: h.id, data: snapshot.data!);

              // return list
              return HomeroomCard(
                  key: Key(h.id),
                  child: ListTile(
                    title: Text(h.name),
                    subtitle: Text("$num students"),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => page));
                    },
                  ));
            });
      }));
}

class HomeroomCard extends StatelessWidget {
  const HomeroomCard({
    Key? key,
    required this.child,
  }) : super(key: key);

  final ListTile child;

  @override
  Widget build(BuildContext context) => Card(
      key: key,
      shadowColor: Theme.of(context).primaryColor,
      clipBehavior: Clip.antiAlias,
      surfaceTintColor: Theme.of(context).colorScheme.background,
      elevation: 0.9,
      child: child);
}
