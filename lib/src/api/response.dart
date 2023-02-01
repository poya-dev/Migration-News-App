class Response<T> {
  Response({
    this.data,
    this.currentPage,
    this.lastPage,
  });

  T? data;
  int? currentPage;
  int? lastPage;
}
