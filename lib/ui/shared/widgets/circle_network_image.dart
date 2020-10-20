import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CircleNetworkImage extends StatelessWidget {
  final String imageUrl;

  CircleNetworkImage(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final viewPortHeight = MediaQuery.of(context).size.height;
    final topPadding = MediaQuery.of(context).padding.top;
    final avatarDimensions = (viewPortHeight - topPadding) * 0.12;

    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        width: avatarDimensions,
        height: avatarDimensions,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.fill,
            //colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn),
          ),
        ),
      ),
      placeholder: (context, url) => IconButton(
        color: Theme.of(context).accentColor,
        iconSize: avatarDimensions,
        icon: Icon(Icons.image),
        onPressed: () {},
      ),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}
