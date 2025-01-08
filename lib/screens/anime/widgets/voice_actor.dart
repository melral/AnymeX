import 'dart:math' show Random;
import 'package:anymex/models/Anilist/anilist_media_full.dart';
import 'package:anymex/widgets/animation/slide_scale.dart';
import 'package:anymex/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CharactersCarousel extends StatelessWidget {
  final List<Character> characters;
  final bool isManga;
  const CharactersCarousel(
      {super.key, required this.characters, this.isManga = false});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 600;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text("Characters",
              style: TextStyle(
                  fontFamily: "Poppins-SemiBold",
                  fontSize: 18,
                  color: Theme.of(context).colorScheme.primary)),
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: isDesktop ? 280 : 220,
          child: ListView.builder(
            itemCount: characters.length,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 20),
            itemBuilder: (BuildContext context, int index) {
              final itemData = characters[index];
              final tag = generateTag('${itemData.name}-$index');

              return SlideAndScaleAnimation(
                initialScale: 0.0,
                finalScale: 1.0,
                initialOffset: const Offset(1.0, 0.0),
                duration: const Duration(milliseconds: 200),
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  constraints: BoxConstraints(
                      maxWidth: isDesktop ? 150 : 110,
                      maxHeight: isDesktop ? 200 : 155),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Hero(
                            tag: tag,
                            child: NetworkSizedImage(
                                imageUrl: itemData.image ??
                                    'https://s4.anilist.co/file/anilistcdn/character/large/default.jpg',
                                radius: 16,
                                height: isDesktop ? 200 : 150,
                                width: double.infinity),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(10, 4, 5, 2),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  bottomRight: Radius.circular(12),
                                ),
                                color: Theme.of(context)
                                    .colorScheme
                                    .surfaceContainer,
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Iconsax.heart5,
                                    size: 16,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                  const SizedBox(width: 3),
                                  Text(
                                    itemData.favourites.toString(),
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: "Poppins-Bold",
                                        fontStyle: FontStyle.italic,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .inverseSurface
                                            .withOpacity(0.9)),
                                  ),
                                  const SizedBox(width: 3),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        itemData.name ?? '??',
                        maxLines: 2,
                        style: TextStyle(
                            fontSize: isDesktop ? 14 : 12,
                            fontFamily: "Poppins-SemiBold"),
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        if (!isManga) ...[
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text("Voice Actors",
                style: TextStyle(
                    fontFamily: "Poppins-SemiBold",
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.primary)),
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: isDesktop ? 280 : 220,
            child: ListView.builder(
              itemCount: characters.length,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 20),
              itemBuilder: (BuildContext context, int index) {
                final character = characters[index];
                final characterName = character.name;
                final itemData = (character.voiceActors.isNotEmpty)
                    ? character.voiceActors[0]
                    : null;
                final tag =
                    generateTag('${itemData?.name ?? 'No Voice Actor'}-$index');

                return SlideAndScaleAnimation(
                  initialScale: 0.0,
                  finalScale: 1.0,
                  initialOffset: const Offset(1.0, 0.0),
                  duration: const Duration(milliseconds: 200),
                  child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    constraints: BoxConstraints(
                        maxWidth: isDesktop ? 150 : 110,
                        maxHeight: isDesktop ? 200 : 155),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Hero(
                              tag: tag,
                              child: NetworkSizedImage(
                                imageUrl: itemData?.image ??
                                    'https://s4.anilist.co/file/anilistcdn/character/large/default.jpg',
                                radius: 16,
                                height: isDesktop ? 200 : 150,
                                width: double.infinity,
                              ),
                            ),
                            if (itemData != null)
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 4, 5, 2),
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      bottomRight: Radius.circular(12),
                                    ),
                                    color: Theme.of(context)
                                        .colorScheme
                                        .surfaceContainer,
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Iconsax.microphone5,
                                        size: 16,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                      const SizedBox(width: 3),
                                      Text(
                                        characterName ?? '??',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: "Poppins-Bold",
                                            fontStyle: FontStyle.italic,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .inverseSurface
                                                .withOpacity(0.9)),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.right,
                                      ),
                                      const SizedBox(width: 3),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          itemData?.name ?? 'No Voice Actor',
                          maxLines: 2,
                          style: TextStyle(
                              fontSize: isDesktop ? 14 : 12,
                              fontFamily: "Poppins-SemiBold"),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ]
      ],
    );
  }
}

String generateTag(String url) {
  final randomNum = Random().nextInt(10000);
  return '$url-$randomNum';
}
