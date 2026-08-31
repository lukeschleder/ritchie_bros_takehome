import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/consts.dart';
import '../data/models/asset_model.dart';
import '../data/repositories/asset_repository.dart';

part 'asset_event.dart';
part 'asset_state.dart';

class AssetBloc extends Bloc<AssetEvent, AssetState> {
  AssetBloc({required AssetRepository repository})
      : _repository = repository,
        super(const AssetState()) {
    on<FetchAssets>(_onFetchAssets);
    on<FetchNextPage>(_onFetchNextPage);
  }

  final AssetRepository _repository;
  var _nextPageInFlight = false;

  Future<void> _onFetchAssets(
    FetchAssets event,
    Emitter<AssetState> emit,
  ) async {
    _nextPageInFlight = false;
    emit(
      state.copyWith(
        status: AssetStatus.loading,
        isLoadingMore: false,
      ),
    );

    try {
      final assets = await _repository.fetchAssets(
        offset: 0,
        limit: Consts.pageSize,
      );

      emit(
        state.copyWith(
          status: AssetStatus.success,
          assets: List<Asset>.unmodifiable(assets),
          hasReachedMax: assets.length < Consts.pageSize,
          isLoadingMore: false,
          clearErrorMessage: true,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: AssetStatus.failure,
          isLoadingMore: false,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  Future<void> _onFetchNextPage(
    FetchNextPage event,
    Emitter<AssetState> emit,
  ) async {
    if (_nextPageInFlight || !state.status.isSuccess || state.hasReachedMax) {
      return;
    }

    _nextPageInFlight = true;
    final offset = state.assets.length;
    emit(state.copyWith(isLoadingMore: true));

    try {
      final nextPage = await _repository.fetchAssets(
        offset: offset,
        limit: Consts.pageSize,
      );

      emit(
        state.copyWith(
          status: AssetStatus.success,
          assets: List<Asset>.unmodifiable([...state.assets, ...nextPage]),
          hasReachedMax: nextPage.length < Consts.pageSize,
          isLoadingMore: false,
          clearErrorMessage: true,
        ),
      );
    } catch (_) {
      emit(state.copyWith(isLoadingMore: false));
    } finally {
      _nextPageInFlight = false;
    }
  }
}
