class CatalogModel {
  static final items = [
    Item(id: 1, name: "shanti", age: "28", priceRange: "2000-3000", desc: "hello,I am shanti.I live in ahemdabad.I need person for cleaning and cooking porpose",image: "https://th.bing.com/th?id=OIF.%2bHmYga3Dn5BS9FAWHM94Lg&w=265&h=180&c=7&r=0&o=5&dpr=1.1&pid=1.7"),
    Item(id: 2, name: "Angelina", age: "30", priceRange: "1000-3000", desc: "hello,I am Angelina.I live in assam.I need person for cleaning,gardening,cooking porpose", image: "https://th.bing.com/th/id/OIP.jYOnoe6-2OcEgbsgmCivtgHaFj?w=235&h=180&c=7&r=0&o=5&dpr=1.1&pid=1.7"),
    Item(id: 3, name: "dhoni", age: "40", priceRange: "2000-5000", desc: "hello,I am dhoni.I live in gandhinagar.I need person for cleaning,gardening,cooking porpose", image: "https://th.bing.com/th/id/OIP.rjR2sMyxk2PmMDfez_v89wHaEo?w=274&h=180&c=7&r=0&o=5&dpr=1.1&pid=1.7"),
    Item(id: 4, name: "Selena", age: "36", priceRange: "3000-5000", desc: "hello,I am Selena.I live in MahaveerHills.I need person for cleaning,gardening,cooking porpose", image: "https://th.bing.com/th/id/OIP.D5DYGU2NdBg1FviiOOBBPAHaE5?w=196&h=130&c=7&r=0&o=5&dpr=1.1&pid=1.7"),
    Item(id: 5, name: "Zayn", age: "27", priceRange: "2000-4000", desc: "hello,I am Zayn.I live in Banaras.I need person for cleaning,gardening,cooking porpose", image: "https://th.bing.com/th/id/OIP.JUF2SkUtVDo309Mc6ZARrAHaEK?w=301&h=180&c=7&r=0&o=5&dpr=1.1&pid=1.7"),
    Item(id: 6, name: "kristen", age: "55", priceRange: "2000-3000", desc: "hello,I am kristen.I live in america.I need person for cleaning,gardening,cooking porpose", image: "https://th.bing.com/th/id/OIP.E9BApszlCEmCh1K9DRJN0AHaEo?w=281&h=180&c=7&r=0&o=5&dpr=1.1&pid=1.7"),
  ];
}

class Item {
  final int id;
  final String name;
  final String age;
  final String priceRange;
  final String desc;
  final String image;

  Item({required this.id, required this.name,required this.age, required this.priceRange, required this.desc, required this.image});
}