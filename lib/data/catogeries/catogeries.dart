class CatogeriesModel {
  final String image;
  final String title;

  CatogeriesModel(this.image, this.title);
  static List<CatogeriesModel> catogeriesList = [
    CatogeriesModel("assets/images/catogeryimage/Ellipse 1.png", "Hoodies"),
    CatogeriesModel("assets/images/catogeryimage/Ellipse 2.png", "Shorts"),
    CatogeriesModel("assets/images/catogeryimage/Ellipse 3.png", "Shoes"),
    CatogeriesModel("assets/images/catogeryimage/Ellipse 3-1.png", "Bag"),
    CatogeriesModel("assets/images/catogeryimage/Ellipse 4.png", "Accessories"),
  ];
}
