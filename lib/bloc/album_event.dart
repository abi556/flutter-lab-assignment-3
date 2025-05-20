import 'package:equatable/equatable.dart';

abstract class AlbumEvent extends Equatable {
  const AlbumEvent();

  @override
  List<Object?> get props => [];
}

class LoadAlbums extends AlbumEvent {}

class SelectAlbum extends AlbumEvent {
  final int albumId;
  const SelectAlbum(this.albumId);

  @override
  List<Object?> get props => [albumId];
} 