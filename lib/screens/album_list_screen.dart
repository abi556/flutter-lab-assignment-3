import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../bloc/album_bloc.dart';
import '../bloc/album_event.dart';
import '../bloc/album_state.dart';
import '../models/album.dart';
import '../models/photo.dart';
import 'package:go_router/go_router.dart';

const kModernBlue = Color(0xFF1976D2);
const kBluishCard = Color(0x185178D6); // 20% opacity blue

class AlbumListScreen extends StatelessWidget {
  const AlbumListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7FA),
      appBar: AppBar(
        title: Text('Albums', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 26)),
        backgroundColor: Colors.white,
        elevation: 0.5,
        foregroundColor: kModernBlue,
        iconTheme: const IconThemeData(color: kModernBlue),
      ),
      body: BlocBuilder<AlbumBloc, AlbumState>(
        builder: (context, state) {
          if (state is AlbumLoading) {
            return const Center(child: CircularProgressIndicator(color: kModernBlue));
          } else if (state is AlbumError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Error: ${state.message}', textAlign: TextAlign.center, style: GoogleFonts.poppins()),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: kModernBlue),
                    onPressed: () {
                      context.read<AlbumBloc>().add(LoadAlbums());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          } else if (state is AlbumLoaded) {
            return ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              itemCount: state.albums.length,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final Album album = state.albums[index];
                final albumPhotos = state.photos.where((p) => p.albumId == album.id);
                final Photo? photo = albumPhotos.isNotEmpty ? albumPhotos.first : null;
                return Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    splashColor: kModernBlue.withAlpha((0.1 * 255).toInt()),
                    highlightColor: kModernBlue.withAlpha((0.05 * 255).toInt()),
                    onTap: () {
                      context.read<AlbumBloc>().add(SelectAlbum(album.id));
                      context.go('/album/${album.id}');
                    },
                    child: Card(
                      color: kBluishCard,
                      elevation: 3,
                      shadowColor: kModernBlue.withAlpha((0.15 * 255).toInt()),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: photo != null
                                  ? SizedBox(
                                      width: 80,
                                      height: 80,
                                      child: FadeInImage.assetNetwork(
                                        placeholder: 'assets/placeholder.png',
                                        image: getWorkingImageUrl(photo.id, width: 160, height: 160),
                                        fit: BoxFit.cover,
                                        imageErrorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, size: 48, color: kModernBlue),
                                      ),
                                    )
                                  : const Icon(Icons.photo, size: 48, color: kModernBlue),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Text(
                                album.title,
                                style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  String getWorkingImageUrl(int id, {int width = 200, int height = 200}) {
    return 'https://picsum.photos/$width/$height?random=$id';
  }
} 