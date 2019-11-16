import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class LaunchImages extends StatefulWidget {
  LaunchImages({
    Key key,
    this.imageUrls,
  }) : super(key: key);

  final List<String> imageUrls;

  @override
  _LaunchImagesState createState() => _LaunchImagesState();
}

class _LaunchImagesState extends State<LaunchImages> {

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      viewportFraction: 1.0, // make image use the full screen width
      autoPlay: true,
      autoPlayInterval: Duration(seconds: 5),
      pauseAutoPlayOnTouch: Duration(seconds: 5),
      enlargeCenterPage: false,
      enableInfiniteScroll: widget.imageUrls.length > 1, // disable scroll when only one image available
      items: mapFromUrls(
        widget.imageUrls, (index, imgUrl) {
          return Container(
            width: MediaQuery.of(context).size.width,
            child: CachedNetworkImage(
              imageUrl: imgUrl,
              fit: index == 0 ? BoxFit.contain : BoxFit.cover, // always show full badge
              placeholder: (context, url) => Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Center(
                child: Text(
                  'No image available',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )
              ),
            ),
          );
        },
      )
    );
  }

  List<Widget> mapFromUrls(List list, Function handler) {
    List<Widget> result = [];

    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }

    return result;
  }
}