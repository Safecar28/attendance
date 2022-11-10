part of '../main.dart';

class HomeroomList extends StatelessWidget {
  const HomeroomList({
    Key? key,
    required this.add,
    required this.homerooms,
  }) : super(key: key);

  final void Function() add;
  final Iterable<Homeroom> homerooms;

  @override
  Widget build(context) {
    if (homerooms.isEmpty) {
      return EmptyListMessage(name: 'homeroom', onPressed: add);
    }

    return ListView.builder(
        itemCount: homerooms.length,
        itemBuilder: (context, index) {
          final h = homerooms.elementAt(index);
          final num = h.studentIds.length;

          return StyledCard(
              key: Key(h.id),
              child: ListTile(
                title: Text(h.name),
                subtitle: Text("$num students"),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              StudentsPage(homeroomId: h.id)));
                },
                onLongPress: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          fullscreenDialog: true,
                          builder: (context) => HomeroomForm(
                                id: h.id,
                                name: h.name,
                              )));
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
