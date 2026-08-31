part of 'asset_bloc.dart';

enum AssetStatus { initial, loading, success, failure }

extension AssetStatusX on AssetStatus {
  bool get isInitial => this == AssetStatus.initial;
  bool get isLoading => this == AssetStatus.loading;
  bool get isSuccess => this == AssetStatus.success;
  bool get isFailure => this == AssetStatus.failure;
}

@immutable
final class AssetState extends Equatable {
  const AssetState({
    this.status = AssetStatus.initial,
    this.assets = const [],
    this.hasReachedMax = false,
    this.isLoadingMore = false,
    this.errorMessage,
  });

  final AssetStatus status;
  final List<Asset> assets;
  final bool hasReachedMax;
  final bool isLoadingMore;
  final String? errorMessage;

  AssetState copyWith({
    AssetStatus? status,
    List<Asset>? assets,
    bool? hasReachedMax,
    bool? isLoadingMore,
    String? errorMessage,
    bool clearErrorMessage = false,
  }) {
    return AssetState(
      status: status ?? this.status,
      assets: assets ?? this.assets,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      errorMessage:
          clearErrorMessage ? null : errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        assets,
        hasReachedMax,
        isLoadingMore,
        errorMessage,
      ];
}
