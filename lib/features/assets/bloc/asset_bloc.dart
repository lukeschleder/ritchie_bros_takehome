import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/consts.dart';
import '../data/models/asset_model.dart';
import '../data/repositories/asset_repository.dart';

part 'asset_event.dart';
part 'asset_state.dart';

EventTransformer<E> _sequential<E>() {
  return (events, mapper) => events.asyncExpand(mapper);
}

class AssetBloc extends Bloc<AssetEvent, AssetState> {
  AssetBloc({required AssetRepository repository})
      : _repository = repository,
        super(const AssetState()) {
    on<FetchAssets>(_onFetchAssets);
    on<FetchNextPage>(_onFetchNextPage, transformer: _sequential());
  }

  final AssetRepository _repository;

  Future<void> _onFetchAssets(
    FetchAssets event,
    Emitter<AssetState> emit,
  ) async {
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
    if (!state.status.isSuccess || state.hasReachedMax || state.isLoadingMore) {
      return;
    }

    emit(state.copyWith(isLoadingMore: true));

    try {
      final nextPage = await _repository.fetchAssets(
        offset: state.assets.length,
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
}
