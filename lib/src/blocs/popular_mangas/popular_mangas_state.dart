import 'package:equatable/equatable.dart';
import 'package:manga_finder/src/data/models/manga_model.dart';

import '../bloc_constants.dart';

class PopularMangaState extends Equatable {
  const PopularMangaState({
    this.status = StateStatus.initial,
    this.popularMangas = const <MangaModel>[],
    this.hasReachedMax = false,
    this.error = '',
  });

  final StateStatus status;
  final List<MangaModel> popularMangas;
  final bool hasReachedMax;
  final String error;

  PopularMangaState copyWith({
    StateStatus? status,
    List<MangaModel>? popularMangas,
    bool? hasReachedMax,
    String? error,
  }) {
    return PopularMangaState(
      status: status ?? this.status,
      popularMangas: popularMangas ?? this.popularMangas,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      error: error ?? this.error,
    );
  }

  @override
  String toString() {
    return '''PopularMangaState {status: $status, hasReachedMax: $hasReachedMax, PopularMangas: ${popularMangas.length} }, error: $error''';
  }

  @override
  List<Object?> get props => [status, popularMangas, hasReachedMax, error];
}
