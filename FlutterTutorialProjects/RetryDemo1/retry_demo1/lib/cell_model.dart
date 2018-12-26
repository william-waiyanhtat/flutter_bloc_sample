class CellModel {
  int albumId;
  int id;
  String title;
  String url;
  String thumbnailUrl;

  CellModel({this.albumId, this.id, this.title, this.url, this.thumbnailUrl});

  factory CellModel.fromJson(Map<String, dynamic> json) {
    return CellModel(
        albumId: json['albumId'] as int,
        id: json['id'] as int,
        title: json['title'] as String,
        url: json['url'] as String,
        thumbnailUrl: json['thumbnailUrl'] as String);
  }
}
