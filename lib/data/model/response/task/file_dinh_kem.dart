class FileDinhKem {
  String? extension;
  String? url;

  FileDinhKem({
    this.extension,
    this.url,
  });

  factory FileDinhKem.fromJson(Map<String, dynamic> json) {
    return FileDinhKem(
      extension: json['extension'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'extension': extension,
      'url': url,
    };
  }
}