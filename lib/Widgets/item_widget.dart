import 'package:flutter/material.dart';

import '../Screens/Worker/worker_registration_page1.dart';
import '../Additional/users_items.dart';

class ItemWidget extends StatelessWidget {
  final Item item;
  const ItemWidget({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 0,
        color: Colors.pink.shade200,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: Image.network(
              item.image,
              height: 90,
              width: 90,
            ),
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(item.name,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18)),
            ),
            subtitle: Center(
                child: Text(item.desc,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15))),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const WorkerRegistrationPage1(),
                ),
              );
            },
            onLongPress: () {},
            // trailing: Text(
            //   "${item.priceRange}",
            //   style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
            // ),
          ),
        ),
      ),
    );
  }
}
