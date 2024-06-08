class ProductModel {
  String? id;
  String? name;
  int? price;
  String? img;

  ProductModel({this.id, this.name, this.price, this.img});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['img'] = this.img;
    return data;
  }
}