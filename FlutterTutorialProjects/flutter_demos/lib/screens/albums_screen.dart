import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demos/bloc/albums/bloc.dart';
import 'package:flutter_demos/bloc/albums/events.dart';
import 'package:flutter_demos/bloc/albums/states.dart';
import 'package:flutter_demos/bloc/theme/theme_bloc.dart';
import 'package:flutter_demos/model/albums_list.dart';
import 'package:flutter_demos/settings/theme.dart';
import 'package:flutter_demos/widgets/error.dart';
import 'package:flutter_demos/widgets/list_row.dart';
import 'package:flutter_demos/widgets/loading.dart';
import 'package:flutter_demos/widgets/txt.dart';

class AlbumsScreen extends StatefulWidget {
  @override
  _AlbumsScreenState createState() => _AlbumsScreenState();
}

class _AlbumsScreenState extends State<AlbumsScreen> {
  //
  bool _isDarkTheme;

  @override
  void initState() {
    super.initState();
    _isDarkTheme = false;
    _loadAlbums();
  }

  _loadAlbums() async {
    context.bloc<AlbumsBloc>().add(AlbumEvents.fetchAlbums);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        title: Txt(text: 'Albums'),
        actions: [
          Switch(
            value: _isDarkTheme,
            onChanged: (val) {
              _isDarkTheme = !_isDarkTheme;
              _toggleTheme(context);
            },
          )
        ],
      ),
      body: Container(
        child: _body(),
      ),
    );
  }

  void _toggleTheme(BuildContext context) {
    var theme = _isDarkTheme ? AppTheme.darkTheme : AppTheme.lightTheme;
    context.bloc<ThemeBloc>().add(ThemeEvent(appTheme: theme));
  }

  _body() {
    return Column(
      children: [
        BlocBuilder<AlbumsBloc, AlbumsState>(
            builder: (BuildContext context, AlbumsState state) {
          if (state is AlbumsListError) {
            final error = state.error;
            String message = '${error.message}\nTap to Retry.';
            return ErrorTxt(
              message: message,
              onTap: _loadAlbums,
            );
          }
          if (state is AlbumsLoaded) {
            List<Album> albums = state.albums;
            return _list(albums);
          }
          return Loading();
        }),
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
