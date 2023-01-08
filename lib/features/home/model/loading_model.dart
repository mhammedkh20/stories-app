class LoadingModel {
  String id;
  bool downloading;
  double progress;

  LoadingModel(
      {required this.downloading, required this.id, required this.progress});
}
