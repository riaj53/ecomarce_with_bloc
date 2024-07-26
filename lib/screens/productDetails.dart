import 'package:flutter/material.dart';
import 'package:learnbloc/models/product_model.dart';
import 'package:lecle_flutter_carousel_pro/lecle_flutter_carousel_pro.dart';

class Productdetails extends StatefulWidget {
  final Products products;
  const Productdetails({
    super.key,
    required this.products,
  });

  @override
  State<Productdetails> createState() => _ProductdetailsState();
}

class _ProductdetailsState extends State<Productdetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            )),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 160, // Ensure a fixed height for the Carousel
            child: Carousel(
              showIndicator: false,
              images: widget.products.images!.map((e) {
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(e),
                      fit: BoxFit.contain,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name:  ${widget.products.title.toString()}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Brand:  ${widget.products.brand.toString()}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Price:  \$${widget.products.price.toString()}',
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, color: Colors.red),
                ),
                Text(
                  'Discount Price: \$${widget.products.discountPercentage.toString()}',
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.green),
                ),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: 'Description: ',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: widget.products.description.toString(),
                      style: TextStyle(color: Colors.blueGrey[600]))
                ]))
              ],
            ),
          ),

          // Reviews
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Reviews:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),

          if (widget.products.reviews != null &&
              widget.products.reviews!.isNotEmpty)
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: widget.products.reviews!.length,
              itemBuilder: (context, index) {
                final review = widget.products.reviews![index];
                return Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10)),
                  margin: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 4.0),
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Align text to the left
                    children: [
                      Text(
                        review.reviewerName.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      // Text(review.date.toString()),
                      //Text(review.reviewerEmail.toString()),
                      Text(
                        review.comment.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.normal, color: Colors.green),
                      ),
                    ],
                  ),
                );
              },
            )
          else
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('No reviews available.'),
            ),
        ],
      ),
      bottomSheet: Container(
        height: 50,
        decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_cart),
            Text(
              'Add to Cart',
              style: TextStyle(color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
