import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'bloc/album_bloc.dart';
import 'bloc/album_event.dart';
import 'repository/album_repository.dart';
import 'screens/album_list_screen.dart';
import 'screens/album_detail_screen.dart';
import 'models/album.dart';
import 'models/photo.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(AlbumAdapter());
  Hive.registerAdapter(PhotoAdapter());
  await Hive.openBox<Album>('albums');
  await Hive.openBox<Photo>('photos');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final albumRepository = AlbumRepository();
    return BlocProvider(
      create: (context) => AlbumBloc(albumRepository)..add(LoadAlbums()),
      child: MaterialApp.router(
        title: 'Album App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        routerConfig: _router,
      ),
    );
  }
}

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const AlbumListScreen(),
      routes: [
        GoRoute(
          path: 'album/:id',
          builder: (context, state) {
            final id = int.tryParse(state.pathParameters['id'] ?? '') ?? 0;
            return AlbumDetailScreen(albumId: id);
          },
        ),
      ],
    ),
  ],
);
