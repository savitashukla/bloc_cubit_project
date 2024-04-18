import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cubit_project/res/ImageRes.dart';
import 'package:cubit_project/utils/help_method.dart';
import 'package:cubit_project/utils/weight/help_weight.dart';
import 'package:cubit_project/view/cricket/game_cricket_list.dart';
import 'package:cubit_project/view/game_zop/game_zop_list.dart';
import 'package:cubit_project/view/tamasha/game_tamasha_list.dart';
import 'package:cubit_project/view_model/cubit/game/game_cubit.dart';
import 'package:cubit_project/view_model/cubit/game/game_equatable.dart';
import 'package:shimmer/shimmer.dart';

class Game extends StatefulWidget {
  const Game({Key? key}) : super(key: key);

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  GameCubit? gameCubit;

  @override
  void initState() {
    // TODO: implement initState

    gameCubit = context.watch<GameCubit>();

    gameCubit!.getHomePage();
    super.initState();
  }

  Future<bool> onWillPop() async {
    SystemNavigator.pop();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: BlocListener<GameCubit, GameEquatable>(
            listener: (context, state) {
              // Navigate to next screen
              Navigator.of(context).pushNamed('OrderCompletedScreen');
            },



          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: [
                  const SizedBox(
                    height: 26,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TamashaGameList(
                                      "645e040cf8c57fe56f9d6c24")),
                              //   "645e040cf8c57fe56f9d6c24")), // live key
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(left: 0),
                            height: 374.812,
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(15)),
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: AssetImage(ImageRes().skill_ludo)),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Color(0xff46558c),
                                      offset: Offset(4, 4),
                                      blurRadius: 4,
                                      spreadRadius: 0)
                                ]),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Expanded(
                          child: SizedBox(
                        height: 374.812,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 0),
                          child: Column(
                            children: [
                              Expanded(
                                  child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => GameZopList(
                                           // "6463376569a913b6cc94b49c")),
                                      "6470aa1239e0075fd456fe97")),
                                  );

                                  /*    gameCubit!.getLoginTeam11BB(
                                      context, "62de6babd6fc1704f21b0ab4");*/
                                },
                                child: Container(
                                    width: 183,
                                    height: 184.383,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image:
                                              AssetImage(ImageRes().poolLogo),
                                          fit: BoxFit.fill,
                                        ),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(15)),
                                        boxShadow: const [
                                          BoxShadow(
                                              color: Color(0xff46558c),
                                              offset: Offset(4, 4),
                                              blurRadius: 4,
                                              spreadRadius: 0)
                                        ])),
                              )),
                              const SizedBox(
                                height: 16,
                              ),
                              Expanded(
                                  child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CricketGameList(
                                       //     "638edddfd9ee8fbe313c876e")),
                                      "639b3459187f2cd3e24efde9")),
                                  );
                                },
                                child: Container(
                                    width: 183,
                                    margin: const EdgeInsets.only(top: 0),
                                    height: 184.383,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(ImageRes().cricket),
                                          fit: BoxFit.fill,
                                        ),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(15)),
                                        boxShadow: const [
                                          BoxShadow(
                                              color: Color(0xff46558c),
                                              offset: Offset(4, 4),
                                              blurRadius: 4,
                                              spreadRadius: 0)
                                        ])),
                              ))
                            ],
                          ),
                        ),
                      ))
                    ],
                  ),
                  const SizedBox(
                    height: 23,
                  ),
                  /*         InkWell(
                    onTap: () {},
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 137.028,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(ImageRes().banner)),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          */ /* border: Border.all(
                                 color: const Color(0xb2f19812),
                                 width: 3
                             )*/ /*
                        )),
                  ),*/

                  gameCubit!.   state.gameModelRes != null
                      ? CarouselSlider(
                          items: gameCubit!.state.gameModelRes!.banners!
                              .map(
                                (item) => InkWell(
                                  onTap: () async {
                                  //  print("click button${item.externalUrl}");

                                    if (item.externalUrl != null &&
                                        !item.externalUrl!.isEmpty) {
                                      HelpMethod.launchURLApp(
                                          "${item.externalUrl}"); //need to comment for new work
                                    }
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 6),
                                    child: Center(
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: CachedNetworkImage(
                                            height: 100,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            fit: BoxFit.fill,
                                            imageUrl: "${item.image!.url}",
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                          )),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                          options: CarouselOptions(
                            height: 120.0,
                            autoPlay: true,
                            disableCenter: true,
                            viewportFraction: .9,
                            aspectRatio: 3,
                            enlargeCenterPage: false,
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enableInfiniteScroll: true,
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 1000),
                            onPageChanged: (index, reason) {
                              //   controller.currentIndexSlider.value = index;
                            },
                          ),
                        )
                      : Shimmer.fromColors(
                          baseColor: Colors.grey.withOpacity(0.2),
                          highlightColor: Colors.grey.withOpacity(0.4),
                          enabled: true,
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            height: MediaQuery.of(context).size.width * 0.3,
                            width: MediaQuery.of(context).size.width,
                          ),
                        ),
                  const SizedBox(
                    height: 20,
                  ),
                  gameCubit!.state.gameModelRes != null
                      ? gameCubit!.state.gameList!.length > 0
                          ? GridView.count(
                              crossAxisCount: 3,
                              crossAxisSpacing: 10.0,
                              mainAxisSpacing: 15,
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              children: List.generate(gameCubit!.state.gameList!.length,
                                  (index) {
                                return getAllGame(context, index);
                              }))
                          : const SizedBox(
                              height: 0,
                            )
                      : HelpWeight().getSimmerWeightGrid(),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          )
        ),
      ),
    ));
  }

  Widget getAllGame(BuildContext context, int index) {
    return InkWell(
      onTap: () {
       // gameCubit!.getLoginTeam11BB(context, "62de6babd6fc1704f21b0ab4");

        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CricketGameList(
                //     "638edddfd9ee8fbe313c876e")),
                  "${gameCubit!.state.gameList![index].id}")),
        );
        // Navigator.pushNamed(context, Routes.gameZopList);
      },
      child: Container(
          width: 132,
          height: 132.998,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                      "${gameCubit!.state.gameList![index].banner!.url}")),
             /* image: index == 0
                  ? DecorationImage(image: AssetImage(ImageRes().poolLogo))
                  : index == 1
                      ? DecorationImage(image: AssetImage(ImageRes().poolLogo))
                      : DecorationImage(image: AssetImage(ImageRes().poolLogo)),*/
              boxShadow: const [
                BoxShadow(
                    color: Color(0xff46558c),
                    offset: Offset(2, 2),
                    blurRadius: 4,
                    spreadRadius: 0)
              ])),
    );
  }
}
