import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todoproject/presentation/widgets/carousel_indicator.dart';

class CarouselPhoto extends StatefulWidget {
  final CarouselController? carouselController;
  final List<String>? images;
  const CarouselPhoto({
    Key? key,
    this.carouselController,
    this.images,
  }) : super(key: key);

  @override
  State<CarouselPhoto> createState() => _CarouselPhotoState();
}

class _CarouselPhotoState extends State<CarouselPhoto> {
  int selectIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CarouselSlider(
          options: CarouselOptions(
            viewportFraction: 1,
            aspectRatio: 343.w / 257.h,
            pageSnapping: true,
            onPageChanged: (index, s) {
              setState(() {
                selectIndex = index;
              });
            },
            enableInfiniteScroll: false,
          ),
          carouselController: widget.carouselController,
          items: [
            if (widget.images != null && widget.images!.isNotEmpty)
              ...widget.images!.map(
                (url) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.h),
                    child: ClipRRect(
                      clipBehavior: Clip.hardEdge,
                      borderRadius: BorderRadius.circular(15.r),
                      child: Image.network(
                        url,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const CircularProgressIndicator.adaptive();
                        },
                      ),
                    ),
                  );
                },
              ).toList()
          ],
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 8.h),
          child: CarouselIndicator(
            carouselIndex: selectIndex,
            length: widget.images?.length,
          ),
        ),
      ],
    );
  }
}
