part of '../main.dart';

class StudentsPage extends ConsumerWidget {
  const StudentsPage({
    Key? key,
    required this.homeroomId,
  }) : super(key: key);

  final String homeroomId;

  void Function() addStudent(BuildContext context, Homeroom homeroom) {
    return () {
      Navigator.push(
          context,
          MaterialPageRoute<Widget>(
              fullscreenDialog: true,
              builder: (context) => StudentForm(
                    homeroom: homeroom,
                  )));
    };
  }

  @override
  build(context, ref) {
    final homeroom = ref.watch(homeroomProvider(homeroomId));

    return homeroom.when(
        loading: () => const Wait(),
        error: (err, stack) => Err(
              err: err,
              stack: stack,
            ),
        data: (homeroom) {
          return Scaffold(
              backgroundColor: Theme.of(context).backgroundColor,
              appBar: AppBar(
                title: Text('${homeroom.name} Students'),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.person_add),
                    onPressed: addStudent(context, homeroom),
                  )
                ],
              ),
              body: Column(children: [
                if (homeroom.studentIds.isEmpty)
                  const SizedBox()
                else
                  const Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: CurrentDate(),
                      )),
                FutureBuilder<Iterable<Student>>(
                    future: homeroom.students(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) return const Wait();
                      return Expanded(
                          child: StudentList(
                        students: snapshot.data!,
                        homeroom: homeroom,
                        add: addStudent(context, homeroom),
                      ));
                    })
              ]));
        });
  }
}
