import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:discovery/components/custom_image.dart';
import 'package:discovery/models/user.dart';
import 'package:discovery/utils/firebase.dart';
import 'package:discovery/view_models/post/posts_view_model.dart';
import 'package:discovery/widgets/indicators.dart';

class CreatePost extends StatefulWidget {
  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  @override
  Widget build(BuildContext context) {
    currentUserId() {
      return firebaseAuth.currentUser!.uid;
    }

    PostsViewModel viewModel = Provider.of<PostsViewModel>(context);
    return WillPopScope(
      onWillPop: () async {
        await viewModel.resetPost();
        return true;
      },
      child: LoadingOverlay(
        progressIndicator: circularProgress(context),
        isLoading: viewModel.loading,
        child: Scaffold(
          key: viewModel.scaffoldKey,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Ionicons.arrow_back_outline),
              onPressed: () {
                viewModel.resetPost();
                Navigator.pop(context);
              },
            ),
          ),
          body: ListView(
            padding: EdgeInsets.only(left: 32.0, right: 32.0),
            children: [
              StreamBuilder(
                stream: usersRef.doc(currentUserId()).snapshots(),
                builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasData) {
                    UserModel user = UserModel.fromJson(
                      snapshot.data!.data() as Map<String, dynamic>,
                    );
                    return ListTile(
                      leading: CircleAvatar(
                        radius: 25.0,
                        backgroundImage: NetworkImage(user.photoUrl!),
                      ),
                      title: Text(
                        user.username!,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        user.email!,
                      ),
                    );
                  }
                  return Container();
                },
              ),
              InkWell(
                onTap: () => showImageChoices(context, viewModel),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width - 30,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  child: viewModel.imgLink != null
                      ? CustomImage(
                          imageUrl: viewModel.imgLink,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width - 30,
                          fit: BoxFit.cover,
                        )
                      : viewModel.mediaUrl == null
                          ? Center(
                              child: Text(
                                'Upload New Post',
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Roboto',
                                  fontSize: 16,
                                ),
                              ),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(30.0),
                              child: Image.file(
                                viewModel.mediaUrl!,
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                fit: BoxFit.cover,
                              ),
                            ),
                ),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                initialValue: viewModel.caption,
                style: TextStyle(
                  color: Color(0xff205065),
                  fontFamily: 'Robot',
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                  hintText: 'Write A Caption...',
                  hintStyle: TextStyle(
                      color: Color(0xFF9593a8),
                      fontFamily: 'Roboto',
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none),
                ),
                maxLines: 1,
                onChanged: (val) => viewModel.setCaption(val),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                initialValue: viewModel.description,
                style: TextStyle(
                  color: Color(0xff205065),
                  fontFamily: 'Robot',
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                  hintText: 'Write A Description...',
                  hintStyle: TextStyle(
                      color: Color(0xFF9593a8),
                      fontFamily: 'Roboto',
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none),
                ),
                maxLines: null,
                onChanged: (val) => viewModel.setDescription(val),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                initialValue: viewModel.howToGetThere,
                style: TextStyle(
                  color: Color(0xff205065),
                  fontFamily: 'Robot',
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                  hintText: 'How To Get There...',
                  hintStyle: TextStyle(
                      color: Color(0xFF9593a8),
                      fontFamily: 'Roboto',
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                ),
                maxLines: null,
                onChanged: (val) => viewModel.setHowToGetThere(val),
              ),
              SizedBox(height: 10.0),
              ListTile(
                contentPadding: EdgeInsets.all(0.0),
                title: Container(
                  width: 250.0,
                  child: TextFormField(
                    controller: viewModel.locationTEC,
                    style: TextStyle(
                      color: Color(0xff205065),
                      fontFamily: 'Robot',
                      fontSize: 14,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Location',
                      hintStyle: TextStyle(
                          color: Color(0xFF9593a8),
                          fontFamily: 'Roboto',
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none),
                    ),
                    maxLines: null,
                    onChanged: (val) => viewModel.setLocation(val),
                  ),
                ),
                trailing: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  child: IconButton(
                    tooltip: "Use your current location",
                    icon: Icon(
                      CupertinoIcons.location_solid,
                      size: 25.0,
                    ),
                    iconSize: 30.0,
                    color: Theme.of(context).colorScheme.secondary,
                    onPressed: () => viewModel.getLocation(),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Center(
                child: RatingBar(
                    initialRating: 0,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 50,
                    ratingWidget: RatingWidget(
                        full: Icon(Icons.star, color: Colors.amber),
                        half: Icon(Icons.star_half, color: Colors.amber,),
                        empty: Icon(Icons.star_outline, color: Colors.amber,)),
                    onRatingUpdate: (value) {
                      setState(() {
                        viewModel.rating = value;
                      });
                    }),
              ),
              SizedBox(height: 30.0),
              Padding(
                padding: const EdgeInsets.only(bottom: 46),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 146,
                      height: 46,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: Color(0xff3e97bd),
                          )),
                      child: MaterialButton(
                        onPressed: () {
                          viewModel.resetPost();
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Clear',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Roboto',
                            color: Color(0xff3e97bd),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Container(
                      width: 146,
                      height: 46,
                      decoration: BoxDecoration(
                        color: Color(0xff3e97bd),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: MaterialButton(
                        onPressed: () async {
                          await viewModel.uploadPosts(context);
                          Navigator.pop(context);
                          viewModel.resetPost();
                        },
                        child: Text(
                          'Share',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Roboto',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showImageChoices(BuildContext context, PostsViewModel viewModel) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: .4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.0),
              Center(
                child: Text(
                  'Select Image',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff205065),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Divider(),
              ListTile(
                leading:
                    Icon(Ionicons.camera_outline, color: Color(0xff205065)),
                title: Text(
                  'Camera',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff205065),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  viewModel.pickImage(camera: true);
                },
              ),
              ListTile(
                leading: Icon(Ionicons.image, color: Color(0xff205065)),
                title: Text(
                  'Gallery',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff205065),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  viewModel.pickImage();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
