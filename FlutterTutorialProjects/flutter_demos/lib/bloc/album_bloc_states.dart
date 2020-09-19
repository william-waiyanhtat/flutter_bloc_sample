import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demos/models/albums_list.dart';

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
