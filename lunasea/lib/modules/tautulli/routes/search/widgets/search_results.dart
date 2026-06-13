import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/modules/tautulli.dart';

class TautulliSearchSearchResults extends StatefulWidget {
  final ScrollController scrollController;

  const TautulliSearchSearchResults({
    Key? key,
    required this.scrollController,
  }) : super(key: key);

  @override
  State<TautulliSearchSearchResults> createState() => _State();
}

class _State extends State<TautulliSearchSearchResults> {
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) =>
      Selector<TautulliState, Future<TautulliSearch>?>(
        selector: (_, state) => state.search,
        builder: (context, future, _) {
          if (future == null) return Container();
          return _futureBuilder(future);
        },
      );

  Widget _futureBuilder(Future<TautulliSearch> future) {
    return ArrPilotRefreshIndicator(
      context: context,
      key: _refreshKey,
      onRefresh: () async => context.read<TautulliState>().fetchSearch(),
      child: FutureBuilder(
        future: future,
        builder: (context, AsyncSnapshot<TautulliSearch> snapshot) {
          if (snapshot.connectionState == ConnectionState.none)
            return Container();
          if (snapshot.hasError) {
            if (snapshot.connectionState != ConnectionState.waiting)
              ArrPilotLogger().error(
                'Unable to fetch Tautulli search results',
                snapshot.error,
                snapshot.stackTrace,
              );
            return ArrPilotMessage.error(onTap: _refreshKey.currentState!.show);
          }
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done)
            return _results(snapshot.data);
          return const ArrPilotLoader();
        },
      ),
    );
  }

  Widget _results(TautulliSearch? search) {
    if ((search?.count ?? 0) == 0)
      return ArrPilotMessage(
        text: 'No Results Found',
        buttonText: 'Refresh',
        onTap: _refreshKey.currentState?.show,
      );
    return ArrPilotListView(
      controller: widget.scrollController,
      children: [
        ..._movies(search!.results!.movies!),
        ..._series(search.results!.shows!),
        ..._seasons(search.results!.seasons!),
        ..._episodes(search.results!.episodes!),
        ..._artists(search.results!.artists!),
        ..._albums(search.results!.albums!),
        ..._tracks(search.results!.tracks!),
        ..._collections(search.results!.collections!),
      ],
    );
  }

  List<Widget> _movies(List<TautulliSearchResult> movies) => [
        const ArrPilotHeader(text: 'movies'),
        if (movies.isEmpty) const ArrPilotMessage(text: 'No Results Found'),
        ...movies.map((movie) => TautulliSearchResultTile(
              result: movie,
              mediaType: TautulliMediaType.MOVIE,
            )),
      ];

  List<Widget> _series(List<TautulliSearchResult> series) => [
        const ArrPilotHeader(text: 'series'),
        if (series.isEmpty) const ArrPilotMessage(text: 'No Results Found'),
        ...series.map((show) => TautulliSearchResultTile(
              result: show,
              mediaType: TautulliMediaType.SHOW,
            )),
      ];

  List<Widget> _seasons(List<TautulliSearchResult> seasons) => [
        const ArrPilotHeader(text: 'seasons'),
        if (seasons.isEmpty) const ArrPilotMessage(text: 'No Results Found'),
        ...seasons.map((show) => TautulliSearchResultTile(
              result: show,
              mediaType: TautulliMediaType.SEASON,
            )),
      ];

  List<Widget> _episodes(List<TautulliSearchResult> episodes) => [
        const ArrPilotHeader(text: 'episodes'),
        if (episodes.isEmpty) const ArrPilotMessage(text: 'No Results Found'),
        ...episodes.map((show) => TautulliSearchResultTile(
              result: show,
              mediaType: TautulliMediaType.EPISODE,
            )),
      ];

  List<Widget> _artists(List<TautulliSearchResult> artists) => [
        const ArrPilotHeader(text: 'artists'),
        if (artists.isEmpty) const ArrPilotMessage(text: 'No Results Found'),
        ...artists.map((show) => TautulliSearchResultTile(
              result: show,
              mediaType: TautulliMediaType.ARTIST,
            )),
      ];

  List<Widget> _albums(List<TautulliSearchResult> albums) => [
        const ArrPilotHeader(text: 'albums'),
        if (albums.isEmpty) const ArrPilotMessage(text: 'No Results Found'),
        ...albums.map((show) => TautulliSearchResultTile(
              result: show,
              mediaType: TautulliMediaType.ALBUM,
            )),
      ];

  List<Widget> _tracks(List<TautulliSearchResult> tracks) => [
        const ArrPilotHeader(text: 'tracks'),
        if (tracks.isEmpty) const ArrPilotMessage(text: 'No Results Found'),
        ...tracks.map((show) => TautulliSearchResultTile(
              result: show,
              mediaType: TautulliMediaType.TRACK,
            )),
      ];

  List<Widget> _collections(List<TautulliSearchResult> collections) => [
        const ArrPilotHeader(text: 'collections'),
        if (collections.isEmpty) const ArrPilotMessage(text: 'No Results Found'),
        ...collections.map((show) => TautulliSearchResultTile(
              result: show,
              mediaType: TautulliMediaType.COLLECTION,
            )),
      ];
}
