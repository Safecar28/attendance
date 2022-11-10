part of '../main.dart';

class StudentsPage extends ConsumerWidget {
  const StudentsPage({
    Key? key,
    required this.homeroomId,
  }) : super(key: key);

  final String homeroomId;

  @override
  build(context, ref) {
    final homeroom = ref.watch(homeroomProvider(homeroomId));

    return homeroom.when(
        loading: () => const Wait(),
        error: (err, stack) => Err(err: err),
        data: (homeroom) {
          return Scaffold(
              appBar: AppBar(
                title: Text("${homeroom.name} Students"),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.person_add),
                    onPressed: () {},
                  )
                ],
              ),
              body: FutureBuilder<Iterable<Student>>(
                  future: homeroom.students(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return const Wait();
                    return StudentList(students: snapshot.data!);
                  })
              // This trailing comma makes auto-formatting nicer for build methods.
              );
        });
  }
}
