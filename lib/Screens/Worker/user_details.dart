import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:handyhive/Screens/Common/load.dart';
import 'package:provider/provider.dart';
import '../../Models/users.dart';
import '../../Provider/users_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class UserDetails extends StatefulWidget {
  Users user;
  UserDetails(this.user);

  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  Future<String>? _imageUrlFuture;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white70,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.pinkAccent,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(children: [
                SizedBox(
                  height: 40,
                ),
                Text(
                  " ${widget.user?.nameUser} Details",
                  style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'Pacifico',
                      fontWeight: FontWeight.w100),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    color: Colors.pink.shade50,
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
                                    .getImageUrl(
                                        widget.user.uidUser.toString()),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return CircleAvatar(
                                      radius: 60,
                                      backgroundImage:
                                          CachedNetworkImageProvider(
                                        snapshot.data.toString(),
                                      ),
                                      backgroundColor: Colors.transparent,
                                    );
                                  } else {
                                    return CircleAvatar(
                                      radius: 90,
                                      backgroundColor: Colors.brown,
                                      foregroundColor: Colors.brown,
                                      // child: CircularProgressIndicator(),
                                    );
                                  }
                                }),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Name',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Source Sans Pro'),
                            ),
                            SizedBox(height: 10),
                            Text(
                              '${widget.user!.nameUser ?? ""}',
                            ),
                            Divider(thickness: 1),
                            Text(
                              'Age',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            Text('${widget.user!.ageUser ?? ""}'),
                            Divider(thickness: 1),
                            Text(
                              'Address',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            Text('${widget.user!.addressUser ?? ""}'),
                            Divider(thickness: 1),
                            Text(
                              'Number of people in house',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            Text(
                                '${widget.user!.numberOfPeopleInhouseUser ?? ""}'),
                            Divider(thickness: 1),
                            Text(
                              'Gender',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            Text('${widget.user!.genderUser ?? ""}'),
                            Divider(thickness: 1),
                            Text(
                              'Religion',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            Text(' ${widget.user!.religionUser ?? ""}'),
                            SizedBox(height: 30),
                            Center(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.pinkAccent),
                                onPressed: () async {
                                  setState(() {
                                    launch(
                                        'https://wa.me/${widget.user!.mobileNumberUser}');
                                  });
                                },
                                child: Text("Tap to chat"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ),
                ),
              ])),
        ));
  }
}
