import 'package:equatable/equatable.dart';
import '../models/album.dart';
import '../models/photo.dart';

abstract class AlbumState extends Equatable {
  const AlbumState();

  @override
  List<Object?> get props => [];
}

class AlbumInitial extends AlbumState {}

class AlbumLoading extends AlbumState {}

class AlbumLoaded extends AlbumState {
  final List<Album> albums;
  final List<Photo> photos;
  const AlbumLoaded({required this.albums, required this.photos});

  @override
  List<Object?> get props => [albums, photos];
}

class AlbumError extends AlbumState {
  final String message;
  const AlbumError(this.message);

  @override
  List<Object?> get props => [message];
}

class AlbumSelected extends AlbumState {
  final Album album;
  final List<Photo> photos;
  const AlbumSelected({required this.album, required this.photos});

  @override
  List<Object?> get props => [album, photos];
} 