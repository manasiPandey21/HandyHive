import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Models/users.dart';
import '../../Provider/users_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class UserDetails extends StatefulWidget {
   String userId;

   UserDetails(this.userId);

  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  Future<String>? _imageUrlFuture;
  bool _isInit = true;
  bool isLoading = true;
  Users? user;

  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    if (_isInit) {
      await Provider.of<UsersProvider>(context, listen: false)
          .fetchAndSetUsers()
          .then((value) async {
        setState(() {
          user = Provider.of<UsersProvider>(context, listen: false)
              .getUser(widget.userId);
          isLoading =false;
        });
      });
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.pinkAccent,
              title: Center(child: Text('Users Details')),
            ),
            body: Container(
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Column(children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: CircleAvatar(
                          radius: 80,
                          backgroundColor: Colors.transparent,
                          child: FutureBuilder(
                            future: Provider.of<UsersProvider>(context,
                                    listen: false)
                                .getImageUrl(widget.userId.toString()),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return CircleAvatar(
                                  radius: 60,
                                  backgroundImage: CachedNetworkImageProvider(
                                    snapshot.data.toString(),
                                  ),
                                  backgroundColor: Colors.transparent,
                                );
                              } else if (snapshot.hasError) {
                                return Icon(Icons.error);
                              } else {
                                return CircularProgressIndicator();
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Name',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            Text(
                              '${user!.nameUser ?? ""}',
                            ),
                            Divider(thickness: 1),
                            Text(
                              'Age',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            Text('${user!.ageUser ?? ""}'),
                            Divider(thickness: 1),
                            Text(
                              'Address',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            Text('${user!.addressUser ?? ""}'),
                            Divider(thickness: 1),
                            Text(
                              'Number of people in house',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            Text('${user!.numberOfPeopleInhouseUser ?? ""}'),
                            Divider(thickness: 1),
                            Text(
                              'Gender',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            Text('${user!.genderUser ?? ""}'),
                            Divider(thickness: 1),
                            Text(
                              'Religion',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            Text(' ${user!.religionUser ?? ""}'),
                            SizedBox(height: 30),
                            Center(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.pinkAccent),
                                onPressed: () async {
                                  setState(() {
                                    launch(
                                        'https://wa.me/${user!.mobileNumberUser}');
                                  });
                                },
                                child: Text("Tap to chat"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
            ));
  }
}
