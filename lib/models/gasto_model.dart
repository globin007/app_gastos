class GastoModel {
  int? id; // Campo ID agregado
  String title;
  double price;
  String datetime;
  String type;

  GastoModel({
    this.id, // Acepta ID opcional
    required this.title,
    required this.price,
    required this.datetime,
    required this.type,
  });

  // Constructor de fábrica para crear una instancia desde un mapa de la base de datos
  factory GastoModel.fromDB(Map<String, dynamic> data) => GastoModel(
      id: data["ID"], // Asegúrate de usar el nombre correcto del campo ID
      title: data["title"],
      price: data["price"],
      datetime: data["datetime"],
      type: data["type"]);

  // Convierte el objeto a un mapa para almacenarlo en la base de datos
  Map<String, dynamic> convertirMap() => {
        if (id != null) "ID": id, // Incluye el ID solo si no es nulo
        "title": title,
        "price": price,
        "datetime": datetime,
        "type": type,
      };
}
