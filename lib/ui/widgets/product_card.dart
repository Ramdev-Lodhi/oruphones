import 'package:flutter/material.dart';
import 'package:oruphones/models/product_model.dart';


class ProductCard extends StatefulWidget {
  final ProductModel product;

  final VoidCallback onFavoriteToggle;
  // const ProductCard({Key? key, required this.product}) : super(key: key);
  const ProductCard({Key? key, required this.product, required this.onFavoriteToggle}) : super(key: key);
  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {


  @override
  Widget build(BuildContext context) {
    final product = widget.product;
// print(product.isVerified);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.network(
                  product.defaultImage?.fullImage ?? "",
                  height: 175,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              if (product.isVerified)
                Positioned(
                  top: 8,
                  child: ClipPath(
                    clipper: ArrowTailClipper(),
                    child: Container(
                      padding: EdgeInsets.only(left:2,right: 20,top: 2,bottom: 2),
                      decoration: BoxDecoration(
                        color: Colors.green,
                      ),
                      child: Text(
                        'ORUVerified',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              Positioned(
                bottom: 0,
                left: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 22, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text('PRICE NEGOTIABLE',
                      style: TextStyle(color: Colors.white, fontSize: 12)),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: widget.onFavoriteToggle,
                  child: Icon(
                    product.isLiked ? Icons.favorite : Icons.favorite_border,
                    color: product.isLiked ? Colors.red : Colors.grey,
                    size: 26,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              color: Colors.grey[200],
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.listedBy,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                        overflow: TextOverflow.ellipsis),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Text(product.deviceStorage,
                            style: TextStyle(color: Colors.grey, fontSize: 16)),
                        SizedBox(width: 6),
                        Text(product.deviceCondition,
                            style: TextStyle(fontSize: 10, color: Colors.grey)),
                      ],
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Text('₹ 30000',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        SizedBox(width: 6),
                        Text('₹ 40000',
                            style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                fontSize: 10,
                                color: Colors.red)),
                      ],
                    ),
                    SizedBox(height: 4),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)),
            ),
            child: Row(
              children: [
                Icon(Icons.location_on, size: 16, color: Colors.grey[700]),
                SizedBox(width: 4),
                Expanded(
                  child: Text(
                    '${product.listingLocation}, ${product.listingState}',
                    style: TextStyle(color: Colors.black, fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ArrowTailClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(0, 0);
    path.lineTo(size.width - 20, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width - 20, size.height / 2);
    path.lineTo(size.width, size.height);
    path.lineTo(20, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
