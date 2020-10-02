import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demos/models/albums_list.dart';

@immutable
abstract class AlbumsState extends Equatable {
  @override
  List<Object> get props => [];
}

class AlbumInitState extends AlbumsState {}

class AlbumsLoading extends AlbumsState {}

class AlbumsLoaded extends AlbumsState {
  final List<Album> albums;
  AlbumsLoaded(this.albums);
}

class AlbumListError extends AlbumsState {
  final error;
  AlbumListError({this.error});
}
