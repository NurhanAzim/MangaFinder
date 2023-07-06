import 'package:flutter/material.dart';
import 'package:manga_finder/src/constants/app_colors.dart';
import 'package:manga_finder/src/data/models/library_manga_model.dart';
import 'package:manga_finder/src/presentation/screens/screen_layout/screen_layout.dart';
import 'package:manga_finder/src/utils/services/database_service.dart';
import 'package:sizer/sizer.dart';
import 'widgets/library_card.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  late Stream<List<LibraryManga>> _mangaStream;

  @override
  void initState() {
    super.initState();
    _mangaStream = DatabaseService().mangaStream();
  }

  Future<void> _refreshLibrary() async {
    setState(() {
      _mangaStream = DatabaseService().mangaStream();
    });
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return ScreenLayout(
        child: RefreshIndicator(
      onRefresh: _refreshLibrary,
      child: StreamBuilder<List<LibraryManga>>(
          stream: _mangaStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data!;
              if (data.isEmpty) {
                return SizedBox(
                  height: 70.h,
                  child: const Center(
                    child: Text('No Favorite Yet'),
                  ),
                );
              } else {
                return SizedBox(
                  height: 70.h,
                  child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        LibraryManga manga = data[index];
                        return LibraryCard(
                            title: manga.title,
                            imageUrl: manga.imageUrl,
                            synopsis: manga.synopsis,
                            malId: manga.malId);
                      }),
                );
              }
            } else if (snapshot.hasError) {
              return SizedBox(
                height: 70.h,
                child: const Center(
                  child: Text('Something went wrong'),
                ),
              );
            } else {
              return SizedBox(
                height: 70.h,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              );
            }
          }),
    ));
  }
}
