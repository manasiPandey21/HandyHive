import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
  bool _isInit = true;
  bool isLoading = true;
  

  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    if (_isInit) {
      await Provider.of<UsersProvider>(context, listen: false)
          .fetchAndSetUsers()
          .then((value) async {
        setState(() {
          
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
            
            body:Column(children: [
           
             Container(
              height: MediaQuery.of(context).size.height,
               child:Column(children: [

              SizedBox(height: 50,),
               Text(" ${widget.user?.nameUser} Details",style: TextStyle(fontSize: 60,fontFamily: 'Pacifico',fontWeight: FontWeight.w100),),
               Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  color:Colors.pink.shade50,
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
                                .getImageUrl(widget.user.uidUser.toString()),
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
                            
                            Text(
                              'Name',
                              style: TextStyle(fontWeight: FontWeight.bold,fontFamily:  'Source Sans Pro'),
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
                            Text('${widget.user!.numberOfPeopleInhouseUser ?? ""}'),
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
                    ),
                  ]),
                ),
              ),
             ])) ]));
  }
}
