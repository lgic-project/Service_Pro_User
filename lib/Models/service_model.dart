class ServiceModel {
  String? id;
  String? name;
  String? description;
  String? createdAt;
  String? updatedAt;
  String? duration;
  int? price;

  ServiceModel({
    this.id,
    this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.duration,
    this.price,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['_id'],
      name: json['Name'],
      description: json['Description'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      duration: json['Duration'],
      price: json['Price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'Name': name,
      'Description': description,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'Duration': duration,
      'Price': price,
    };
  }
}
