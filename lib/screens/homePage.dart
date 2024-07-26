import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learnbloc/models/product_model.dart';
import 'package:learnbloc/qubit/cubit/product_list_cubit.dart';
import 'package:learnbloc/screens/productDetails.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    context.read<ProductListCubit>().getProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: const Color.fromRGBO(255, 255, 255, 1),
          backgroundColor: Colors.white,
          primary: false,
          title: const Text(
            'Products',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: BlocConsumer<ProductListCubit, ProductListState>(
          listener: (context, state) {
            print(state);
          },
          builder: (context, state) {
            if (state is ProductListLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              );
            } else if (state is ProductListModelError) {
              return const Center(
                child: Text('Something Error'),
              );
            } else if (state is ProductListLoaded) {
              final prosuctList = state.productModel;
              return _gridProduct(prosuctList);
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}

Widget _gridProduct(ProductModel productmodel) {
  return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: 10,
        childAspectRatio: 2 / 2.5,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
      ),
      itemBuilder: (contex, index) {
        final data = productmodel.products![index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
                contex,
                MaterialPageRoute(
                    builder: (contex) => Productdetails(
                          products: productmodel.products![index],
                        )));
          },
          child: Container(
            height: 120,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                // border: Border.all(
                //   color: Colors.grey,
                // ),
                borderRadius: BorderRadius.circular(15)),
            child: Column(
              children: [
                //for image
                Container(
                  height: 110,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.transparent,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(data.thumbnail.toString()))),
                ),
                Text(
                  data.title.toString(),
                  maxLines: 1,
                ),
                Text(
                  '\$${data.price}',
                  style: const TextStyle(color: Colors.red),
                )
              ],
            ),
          ),
        );
      });
}
