import 'package:dio/dio.dart';
import '../models/album.dart';
import '../models/photo.dart';
import '../network/api_client.dart';

class AlbumRepository {
  final ApiClient apiClient;

  AlbumRepository({ApiClient? apiClient})
      : apiClient = apiClient ?? ApiClient(Dio());

  Future<List<Album>> fetchAlbums() async {
    return await apiClient.getAlbums();
  }

  Future<List<Photo>> fetchPhotos() async {
    return await apiClient.getPhotos();
  }
} 