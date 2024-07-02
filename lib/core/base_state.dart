import 'package:equatable/equatable.dart';

enum ListStatus {
  initial,
  refreshing,
  loadingMore,
  success,
  refreshError,
  loadMoreError,
  loadNoMore
}

class ListState<T> extends Equatable {
  final int currentPage;
  final List<T> data;
  final ListStatus status;
  final String? errorMessage;

  const ListState({
    this.currentPage = 0,
    this.data = const [],
    this.status = ListStatus.initial,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [currentPage, data, status, errorMessage];

  ListState<T> copyWith({
    ListStatus? status,
    List<T>? data,
    int? currentPage,
    String? errorMessage,
  }) {
    return ListState<T>(
      status: status ?? this.status,
      data: data ?? this.data,
      currentPage: currentPage ?? this.currentPage,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

enum DataStatus { initial, loading, success, error }

class DataState<T> extends Equatable {
  final DataStatus status;
  final T? data;
  final String? errorMessage;

  const DataState({
    this.status = DataStatus.initial,
    this.data,
    this.errorMessage,
  });

  bool get isInitial => status == DataStatus.initial;
  bool get isLoading => status == DataStatus.loading;
  bool get isSuccess => status == DataStatus.success;
  bool get isError => status == DataStatus.error;

  DataState<T> copyWith({
    DataStatus? status,
    T? data,
    String? errorMessage,
  }) {
    return DataState<T>(
      status: status ?? this.status,
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, data, errorMessage];
}
