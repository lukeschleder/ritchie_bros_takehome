import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/asset_bloc.dart';
import '../../constants/consts.dart';
import '../../data/repositories/asset_repository.dart';
import '../widgets/asset_card_widget.dart';
import '../widgets/asset_error_view.dart';
import '../../../../src/settings/settings_view.dart';

class AssetSearchScreen extends StatelessWidget {
  const AssetSearchScreen({super.key});

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          AssetBloc(repository: AssetRepository())..add(const FetchAssets()),
      child: const _AssetSearchView(),
    );
  }
}

class _AssetSearchView extends StatefulWidget {
  const _AssetSearchView();

  @override
  State<_AssetSearchView> createState() => _AssetSearchViewState();
}

class _AssetSearchViewState extends State<_AssetSearchView> {
  final _scrollController = ScrollController();
  var _loadMoreArmed = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final position = _scrollController.position;
    final bloc = context.read<AssetBloc>();

    if (position.extentAfter > Consts.loadMoreThreshold) {
      if (!bloc.state.isLoadingMore) {
        _loadMoreArmed = true;
      }
      return;
    }

    if (!_loadMoreArmed ||
        bloc.state.isLoadingMore ||
        bloc.state.hasReachedMax ||
        position.userScrollDirection != ScrollDirection.reverse) {
      return;
    }

    _loadMoreArmed = false;
    bloc.add(const FetchNextPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assets'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),
      body: BlocBuilder<AssetBloc, AssetState>(
        builder: (context, state) {
          if (state.status.isLoading && state.assets.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status.isFailure && state.assets.isEmpty) {
            return AssetErrorView(
              message: state.errorMessage ?? 'Failed to load assets',
              onRetry: () => context.read<AssetBloc>().add(const FetchAssets()),
            );
          }

          if (state.assets.isEmpty) {
            return const Center(child: Text('No assets found'));
          }

          return ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.only(
              top: Consts.listTopPadding,
              bottom: Consts.listBottomPadding,
            ),
            itemCount: state.assets.length + (state.isLoadingMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index >= state.assets.length) {
                return const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: Consts.paginationSpinnerPadding,
                  ),
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              final asset = state.assets[index];
              return AssetCardWidget(
                imageUrl: asset.imageUrl,
                description: asset.assetDescription,
                location: asset.formattedLocation,
                eventName: asset.eventAdvertisedName,
                date: asset.formattedDate,
              );
            },
          );
        },
      ),
    );
  }
}
