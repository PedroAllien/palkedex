import 'package:flutter/material.dart';
import 'package:palkedex/app/helper/helper.dart';

class CustomCard extends StatelessWidget {
  final String name;
  final String types;
  final String imageWiki;

  const CustomCard({
    Key? key,
    required this.name,
    required this.types,
    required this.imageWiki,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.bottomRight,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            color: Helper.getTypeColor(types),
            border: Border.all(
              color: Colors.white,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Hero(
            tag: 'hero_$name',
            child: Image.network(
              height: 130, 
              imageWiki,
            ),
          ),
        ),
        const SizedBox(height: 5,),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 30,),
            Text(
              name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
