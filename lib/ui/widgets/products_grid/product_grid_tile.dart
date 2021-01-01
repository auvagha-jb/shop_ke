import 'package:flutter/material.dart';
import 'package:shop_ke/core/models/data_models/product.dart';

class ProductGridTile extends StatelessWidget {
  final int index;
  final Product product;

  ProductGridTile({@required this.index, @required this.product});

  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),

        elevation: 4,
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.network(
                    'http://dummyimage.com/250x250.jpg/2e7d32/ffffff',
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                Positioned(
                  bottom: 20,
                  right: 10,
                  child: Container(
                    width: 300,
                    color: Colors.black54,
                    padding: EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 20,
                    ),
                    child: Text(
                      product.productName,
                      style: TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),


              ],
            ),



            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(children: <Widget>[
                    Icon(Icons.money),
                    SizedBox(width: 6),
                    Text('KES ${product.price}'),

//                    Row(children: <Widget>[
//                      Icon(Icons.schedule),
//                      SizedBox(width: 6),
//                      Text('min'),
//                    ]),

                    SizedBox(width: 6),

                    Row(children: <Widget>[
                      Text('Learn More', style: TextStyle(color: Theme.of(context).primaryColor),),
                      SizedBox(width: 2),
                      Icon(Icons.chevron_right),
                    ]),
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
