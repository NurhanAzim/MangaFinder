part of 'trending_mangas_bloc.dart';

class TrendingMangaState extends Equatable {
  const TrendingMangaState(
      {this.status = StateStatus.initial,
      this.trendingMangas = const <MangaModel>[],
      this.hasReachedMax = false,
      this.error = ''});

  final StateStatus status;
  final List<MangaModel> trendingMangas;
  final bool hasReachedMax;
  final String error;

  TrendingMangaState copyWith({
    StateStatus? status,
    List<MangaModel>? trendingMangas,
    bool? hasReachedMax,
    String? error,
  }) {
    return TrendingMangaState(
      status: status ?? this.status,
      trendingMangas: trendingMangas ?? this.trendingMangas,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      error: error ?? this.error,
    );
  }

  @override
  String toString() {
    return '''TrendingMangaState { status: $status, hasReachedMax: $hasReachedMax, TrendingMangas: ${trendingMangas.length}}, Error: $error''';
  }

  @override
  List<Object?> get props => [status, trendingMangas, hasReachedMax, error];
}
