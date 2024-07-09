/// récupérer la liste de tous les items d'un modele
List<T>? fetchItemsList<T>(Map<String, dynamic> model, String attribute,
    {required T Function(Map<String, dynamic>) itemMapper}) {
  List<T>? itemsList = [];
  if (model[attribute] != null) {
    List<dynamic> itemsData = model[attribute];
    itemsList = itemsData.map((item) => itemMapper(item)).toList();
  }
  return itemsList;
}

/// extraire les données d'un modèle
T? extractData<T>(Map<String, dynamic>? data,
        T Function(Map<String, dynamic>) modelMapper) =>
    data != null ? modelMapper(data) : null;
