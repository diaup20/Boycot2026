part of 'search_cubit.dart';

abstract class SearchState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchIdle extends SearchState {}

class SearchEmptyInput extends SearchState {}

class SearchNoResults extends SearchState {}

class SearchLoaded extends SearchState {
  final ProductModel product;
  SearchLoaded(this.product);
  @override
  List<Object?> get props => [product];
}

class SearchError extends SearchState {
  final String message;
  SearchError(this.message);
  @override
  List<Object?> get props => [message];
}

class SearchLoadedList extends SearchState {
  final List<ProductModel> products;
  SearchLoadedList(this.products);
  @override
  List<Object?> get props => [products];
}
