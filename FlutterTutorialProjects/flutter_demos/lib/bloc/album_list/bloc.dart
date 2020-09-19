import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import '../../api/exceptiions.dart';
import '../../api/services.dart';
import '../../models/albums_list.dart';
import '../../models/album_list_error.dart';
import 'states.dart';
import 'events.dart';

class SpotifyBloc extends Bloc<SpotifyEvents, SpotifyState> {
  //
  final SpotifyRepo spotifyRepo;
  AlbumsList albumsList;

  SpotifyBloc({this.spotifyRepo}) : super(AlbumsInitState());

  @override
  Stream<SpotifyState> mapEventToState(SpotifyEvents event) async* {
    switch (event) {
      case SpotifyEvents.fetchAlbums:
        yield AlbumsLoading();
        try {
          albumsList = await spotifyRepo.getAlbumsList();
          yield AlbumsLoaded(albumsList);
        } on SocketException {
          yield AlbumListError(
            error: NoInternetException('No Internet'),
          );
        } on HttpException {
          yield AlbumListError(
            error: NoInternetException('No Service Found'),
          );
        } on FormatException {
          yield AlbumListError(
            error: InvalidFormatException('Invalid Response Format'),
          );
        } on SpotifyException catch (e) {
          SpotifyError spotifyError = e.error;
          yield AlbumListError(
            error: SpotifyException(message: spotifyError.error.message),
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
