import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import 'package:meta/meta.dart';
import '../api/error.dart';
import '../api/services.dart';
import '../models/albums_list.dart';
import '../models/spotify_error.dart';

@immutable
abstract class SpotifyState extends Equatable {
  @override
  List<Object> get props => [];
}

class AlbumsInitState extends SpotifyState {
  //
}

class AlbumsLoading extends SpotifyState {
  //
}

class AlbumsLoaded extends SpotifyState {
  final AlbumsList albumsList;
  AlbumsLoaded(this.albumsList);
}

class AlbumListError extends SpotifyState {
  final error;
  AlbumListError({this.error});
}

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
            error: NoInternetException('No Service Found.'),
          );
        } on FormatException {
          yield AlbumListError(
            error: InvalidFormatException('Parse Error'),
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

enum SpotifyEvents {
  fetchAlbums,
}
