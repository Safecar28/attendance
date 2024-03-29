part of '../main.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  VoidCallback addHomeroom(BuildContext context) => () {
        Navigator.push(
            context,
            MaterialPageRoute<Widget>(
                fullscreenDialog: true,
                builder: (context) => const HomeroomForm()));
      };

  @override
  build(context, ref) => ref.watch(homeroomsProvider).when(
      loading: () => const Wait(),
      error: (err, stack) => Err(
            err: err,
            stack: stack,
          ),
      data: (homerooms) {
        return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            appBar: AppBar(
              title: Text(title),
              actions: [
                IconButton(
                  icon: const Icon(Icons.add_home),
                  onPressed: addHomeroom(context),
                ),
              ],
            ),
            drawer: Drawer(
              child: ListView(
                children: [
                  SizedBox(
                    height: 90,
                    child: DrawerHeader(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                      ),
                      child: const Text(
                        'Reports and settings',
                        textScaleFactor: 1.6,
                        style: TextStyle(color: Colors.white70),
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.grid_goldenratio_outlined),
                    title: const Text('Yearly'),
                    onTap: () {
                      // Update the state of the app.
                      // ...
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings_outlined),
                    title: const Text('Settings'),
                    onTap: () {
                      // Update the state of the app.
                      // ...
                    },
                  )
                ],
              ),
            ),
            body: HomeroomList(
              homerooms: homerooms,
              add: addHomeroom(context),
            ));
      });
}
