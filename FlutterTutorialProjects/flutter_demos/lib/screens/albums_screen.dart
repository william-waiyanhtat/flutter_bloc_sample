import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demos/bloc/album_list/states.dart';
import 'package:flutter_demos/bloc/album_list/bloc.dart';
import 'package:flutter_demos/bloc/album_list/events.dart';
import 'package:flutter_demos/models/albums_list.dart';
import 'package:flutter_demos/widgets/list_row.dart';
import 'package:flutter_demos/widgets/loading.dart';
import 'package:flutter_demos/widgets/retry.dart';
import '../bloc/album_list/bloc.dart';

class AlbumsScreen extends StatefulWidget {
  @override
  _AlbumsScreenState createState() => _AlbumsScreenState();
}

class _AlbumsScreenState extends State<AlbumsScreen> {
  //
  @override
  void initState() {
    super.initState();
    _loadAlbums();
  }

  _loadAlbums() async {
    context.bloc<AlbumsBloc>().add(AlbumEvents.fetchAlbums);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Albums'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: _body(),
      ),
    );
  }

  _body() {
    return Column(
      children: [
        BlocBuilder<AlbumsBloc, AlbumsState>(
            builder: (BuildContext context, AlbumsState state) {
          if (state is AlbumListError) {
            return Retry(
              message: state.error.message,
              onTap: _loadAlbums,
            );
          }
          if (state is AlbumsLoaded) {
            List<Album> albums = state.albums;
            return _list(albums);
          }
          return Loading();
        }),
        SizedBox(height: 30),
      ],
    );
  }

  Widget _list(List<Album> albums) {
    return Expanded(
      child: ListView.builder(
        itemCount: albums.length,
        itemBuilder: (_, index) {
          Album album = albums[index];
          return ListRow(album: album);
        },
      ),
    );
  }
}
