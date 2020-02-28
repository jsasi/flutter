class CustomerEntity {
  String code;

  String name;

  String url;

  CustomerEntity({this.code, this.name, this.url});

  factory CustomerEntity.fromJson(Map<String, dynamic> json) {
    return CustomerEntity(
      code: json["code"],
      name: json["name"],
      url: json["url"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "code": this.code,
      "name": this.name,
      "url": this.url,
    };
  }
}
