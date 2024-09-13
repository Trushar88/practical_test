// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:practical_test/Model/product_model.dart';
import 'package:practical_test/app/config/app_colors.dart';
import 'package:practical_test/app/config/app_strings.dart';

class ReviewScreen extends StatelessWidget {
  Product data;
  ReviewScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: APPCOLOR.BlACKCOLOR,
        foregroundColor: Colors.white,
        title: const Text(
          APPSTRING.review_Screen,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(children: [
            Container(
              height: 200,
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(data.thumbnail ?? ""))),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(data.description ?? ""),
            const SizedBox(
              height: 10,
            ),
            (data.reviews != null && data.reviews!.isNotEmpty)
                ? ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: data.reviews!.length,
                    itemBuilder: (context, index) {
                      return Card(
                        surfaceTintColor: Colors.blue.withOpacity(0.1),
                        //  margin: EdgeInsets.all(8),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${data.reviews![index].reviewerName}",
                                    style: const TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  (data.reviews![index].rating != null)
                                      ? SizedBox(
                                          height: 20,
                                          width: 80,
                                          child: ListView.builder(
                                            physics: const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemCount: 5,
                                            itemBuilder: (context, i) {
                                              return Icon(
                                                Icons.star,
                                                size: 15,
                                                color: i < data.reviews![index].rating! ? Colors.red : Colors.grey,
                                              );
                                            },
                                          ),
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "${data.reviews![index].comment}",
                                style: TextStyle(color: APPCOLOR.GREYCOLOR),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : const SizedBox()
          ]),
        ),
      ),
    );
  }
}
