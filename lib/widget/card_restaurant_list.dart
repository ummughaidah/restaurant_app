import 'package:flutter/material.dart';

class CardRestaurantList extends StatelessWidget {
  final String picture;
  final String title;
  final String address;
  final double rating;
  final Function() onTap;

  const CardRestaurantList(
      {super.key,
      required this.picture,
      required this.title,
      required this.address,
      required this.rating,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        spacing: 8,
        children: [
          Image.network(
            picture,
            errorBuilder: (_, __, ___) {
              return const Icon(Icons.error_outline);
            },
            width: 150,
            height: 70,
            fit: BoxFit.cover,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 5,
            children: [
              Text(
                title,
                style: TextTheme.of(context).titleMedium,
              ),
              Row(
                spacing: 4,
                children: [
                  Icon(
                    Icons.location_on,
                    size: 14,
                  ),
                  Text(
                    address,
                    style: TextTheme.of(context).titleSmall,
                  ),
                ],
              ),
              Row(
                spacing: 4,
                children: [
                  Icon(
                    Icons.star,
                    size: 14,
                    color: Colors.amberAccent,
                  ),
                  Text(
                    rating.toString(),
                    style: TextTheme.of(context).titleSmall,
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
