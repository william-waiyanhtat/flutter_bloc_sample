import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demos/models/albums_list.dart';
import 'dart:async';
import '../../api/exceptions.dart';
import '../../api/services.dart';
import 'states.dart';
import 'events.dart';

class AlbumsBloc extends Bloc<AlbumEvents, AlbumsState> {
  //
  final AlbumsRepo albumsRepo;
  List<Album> albumsList;

  AlbumsBloc({this.albumsRepo}) : super(AlbumInitState());

  @override
  Stream<AlbumsState> mapEventToState(AlbumEvents event) async* {
    switch (event) {
      case AlbumEvents.fetchAlbums:
        yield AlbumsLoading();
        try {
          albumsList = await albumsRepo.getAlbumsList();
          yield AlbumsLoaded(albumsList);
        } on SocketException {
          yield AlbumListError(
            error: NoInternetException('No Internet'),
          );
        } on HttpException {
          yield AlbumListError(
            error: NoServiceFoundException('No Service Found'),
          );
        } on FormatException {
          yield AlbumListError(
            error: InvalidFormatException('Invalid Response Format'),
          );
        } catch (e) {
          yield AlbumListError(
            error: UnknownException('Unknown Error'),
          );
        }
        break;
    }
  }
}
