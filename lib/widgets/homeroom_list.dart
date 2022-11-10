part of '../main.dart';

class HomeroomList extends StatelessWidget {
  const HomeroomList({
    Key? key,
    required this.homerooms,
  }) : super(key: key);

  final Iterable<Homeroom> homerooms;

  @override
  Widget build(context) {
    return ListView.builder(
        itemCount: homerooms.length,
        itemBuilder: (context, index) {
          final h = homerooms.elementAt(index);
          final num = h.studentIds.length;
          final page = StudentsPage(homeroomId: h.id);

          // return list
          return StyledCard(
              key: Key(h.id),
              child: ListTile(
                title: Text(h.name),
                subtitle: Text("$num students"),
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => page));
                },
              ));
        });
  }
}

class StyledCard extends StatelessWidget {
  const StyledCard({
    Key? key,
    required this.child,
  }) : super(key: key);

  final ListTile child;

  @override
  Widget build(BuildContext context) => Card(
      shadowColor: Theme.of(context).primaryColor,
      clipBehavior: Clip.antiAlias,
      surfaceTintColor: Theme.of(context).colorScheme.background,
      elevation: 0.9,
      child: child);
}
