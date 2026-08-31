part of 'asset_bloc.dart';

sealed class AssetEvent extends Equatable {
  const AssetEvent();

  @override
  List<Object?> get props => [];
}

final class FetchAssets extends AssetEvent {
  const FetchAssets();
}

final class FetchNextPage extends AssetEvent {
  const FetchNextPage();
}
