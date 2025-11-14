class Sponsor {
  final String? uuid;
  final String? name;
  final String? logo;

  Sponsor({
    this.uuid,
    this.name,
    this.logo,
  });

  factory Sponsor.fromJson(Map<String, dynamic> json) => Sponsor(
    uuid: json["uuid"],
    name: json["name"],
    logo: json["logo"],
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "name": name,
    "logo": logo,
  };
}