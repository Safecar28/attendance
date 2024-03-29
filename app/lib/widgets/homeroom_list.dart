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
      return EmptyListMessage(
        name: 'homeroom',
        message: 'Generate your first homeroom!',
        onPressed: add,
      );
    }

    return ListView.builder(
        padding: const EdgeInsets.only(top: 3),
        itemCount: homerooms.length,
        itemBuilder: (context, index) {
          final h = homerooms.elementAt(index);
          final num = h.studentIds.length;

          return StyledCard(
              key: Key(h.id),
              child: ListTile(
                trailing: const Icon(Icons.people_alt_outlined),
                title: Text(h.name),
                subtitle: Text('$num students'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute<Widget>(
                          builder: (context) =>
                              StudentsPage(homeroomId: h.id)));
                },
                onLongPress: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute<Widget>(
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
      clipBehavior: Clip.antiAlias,
      color: Theme.of(context).cardColor,
      elevation: 0.9,
      child: child);
}
