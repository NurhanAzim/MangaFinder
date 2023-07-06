part of 'random_manga_bloc.dart';

class RandomMangaState extends Equatable {
  final List<MangaModel> randomMangas;
  final StateStatus status;
  final bool hasReachedMax;
  final String error;

  const RandomMangaState(
      {this.randomMangas = const <MangaModel>[],
      this.status = StateStatus.initial,
      this.hasReachedMax = false,
      this.error = ''});

  RandomMangaState copyWith({
    List<MangaModel>? randomMangas,
    StateStatus? status,
    bool? hasReachedMax,
    String? error,
  }) {
    return RandomMangaState(
        randomMangas: randomMangas ?? this.randomMangas,
        status: status ?? this.status,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        error: error ?? this.error);
  }

  @override
  String toString() {
    return '''RandomMangaState {status: $status, randomMangas: ${randomMangas.length}, hasReachedMax: $hasReachedMax} error: $error''';
  }

  @override
  List<Object?> get props => [status, randomMangas, hasReachedMax, error];
}
