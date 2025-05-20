import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import '../models/album.dart';
import '../models/photo.dart';
import '../network/api_client.dart';

class AlbumRepository {
  final ApiClient apiClient;
  final Box<Album> albumBox = Hive.box<Album>('albums');
  final Box<Photo> photoBox = Hive.box<Photo>('photos');

  AlbumRepository({ApiClient? apiClient})
      : apiClient = apiClient ?? ApiClient(Dio());

  Future<List<Album>> fetchAlbums() async {
    try {
      final albums = await apiClient.getAlbums();
      await albumBox.clear();
      await albumBox.addAll(albums);
      return albums;
    } catch (e) {
      // On error, return cached albums
      return albumBox.values.toList();
    }
  }

  Future<List<Photo>> fetchPhotos() async {
    try {
      final photos = await apiClient.getPhotos();
      await photoBox.clear();
      await photoBox.addAll(photos);
      return photos;
    } catch (e) {
      // On error, return cached photos
      return photoBox.values.toList();
    }
  }
} 