import 'package:flutter_bloc/flutter_bloc.dart';
import 'album_event.dart';
import 'album_state.dart';
import '../repository/album_repository.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  final AlbumRepository repository;

  AlbumBloc(this.repository) : super(AlbumInitial()) {
    on<LoadAlbums>((event, emit) async {
      emit(AlbumLoading());
      try {
        final albums = await repository.fetchAlbums();
        final photos = await repository.fetchPhotos();
        emit(AlbumLoaded(albums: albums, photos: photos));
      } catch (e) {
        emit(AlbumError(e.toString()));
      }
    });

    on<SelectAlbum>((event, emit) async {
      emit(AlbumLoading());
      try {
        final albums = await repository.fetchAlbums();
        final photos = await repository.fetchPhotos();
        final album = albums.firstWhere((a) => a.id == event.albumId);
        final albumPhotos = photos.where((p) => p.albumId == event.albumId).toList();
        emit(AlbumSelected(album: album, photos: albumPhotos));
      } catch (e) {
        emit(AlbumError(e.toString()));
      }
    });
  }
} 