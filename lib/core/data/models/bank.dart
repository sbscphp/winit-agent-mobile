class Bank {
  final String? name;
  final String? code;
  final String? slug;
  final String? type;

  Bank({
    this.name,
    this.code,
    this.slug,
    this.type,
  });

  factory Bank.fromJson(Map<String, dynamic> json) => Bank(
    name: json["name"],
    code: json["code"],
    slug: json["slug"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "code": code,
    "slug": slug,
    "type": type,
  };
}