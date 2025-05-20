import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../bloc/album_bloc.dart';
import '../bloc/album_state.dart';
import '../models/album.dart';
import '../models/photo.dart';
import '../bloc/album_event.dart';

const kModernBlue = Color(0xFF1976D2);
const kBluishCard = Color(0x185178D6); // 20% opacity blue

class AlbumDetailScreen extends StatelessWidget {
  final int albumId;
  const AlbumDetailScreen({super.key, required this.albumId});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        if (didPop) {
          context.read<AlbumBloc>().add(LoadAlbums());
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F7FA),
        appBar: AppBar(
          title: Text('Album Details', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 22)),
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
                        context.read<AlbumBloc>().add(SelectAlbum(albumId));
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            } else if (state is AlbumSelected && state.album.id == albumId) {
              final Album album = state.album;
              final List<Photo> photos = state.photos;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text('Title: ${album.title}', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: kModernBlue)),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text('Photos:', style: TextStyle(fontSize: 16)),
                  ),
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                      itemCount: photos.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        final photo = photos[index];
                        return Card(
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
                                  child: SizedBox(
                                    width: 80,
                                    height: 80,
                                    child: FadeInImage.assetNetwork(
                                      placeholder: 'assets/placeholder.png',
                                      image: getWorkingImageUrl(photo.id, width: 160, height: 160),
                                      fit: BoxFit.cover,
                                      imageErrorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, size: 48, color: kModernBlue),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: Text(
                                    photo.title,
                                    style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  String getWorkingImageUrl(int id, {int width = 600, int height = 400}) {
    return 'https://picsum.photos/$width/$height?random=$id';
  }
} 