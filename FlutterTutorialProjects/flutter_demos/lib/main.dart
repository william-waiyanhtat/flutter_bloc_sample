import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demos/api/services.dart';
import 'package:flutter_demos/screens/albums_screen.dart';
import 'bloc/album_list/bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider(
        create: (context) => SpotifyBloc(spotifyRepo: SpotifyAlbumServices()),
        child: AlbumsScreen(),
      ),
    );
  }
}
