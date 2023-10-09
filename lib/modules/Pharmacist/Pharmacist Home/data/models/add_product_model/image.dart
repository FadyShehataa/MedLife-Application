class Image {
  String? id;
  String? url;

  Image({this.id, this.url});

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json['id'] as String?,
        url: json['url'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'url': url,
      };
}
