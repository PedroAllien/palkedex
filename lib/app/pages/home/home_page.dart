import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palkedex/app/data/blocs/pal_bloc.dart';
import 'package:palkedex/app/data/blocs/pal_event.dart';
import 'package:palkedex/app/data/blocs/pal_state.dart';
import 'package:palkedex/app/data/models/pal_model.dart';
import 'package:palkedex/app/data/repositories/pal_repository.dart';
import 'package:palkedex/app/helper/helper.dart';
import 'package:palkedex/app/helper/strings.dart';
import 'package:palkedex/app/pages/widgets/custom_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final PalBloc _palBloc;

  @override 
  void initState() {
    super.initState();
    _palBloc = PalBloc(repository: PalRepository());
    _getPals();
  }

  _getPals() {
    _palBloc.add(
      GetPals(
        searchName: null,
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 70, 70, 70),
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 200,
                child: Image.network(Strings.logoPal),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                Strings.encrontrePalAqui,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
          BlocBuilder<PalBloc, PalState>(
            bloc: _palBloc,
            builder: (context, state) {
              if (state is PalLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                );
              } else if (state is PalLoadedState) {
                return Expanded(
                  child: CustomCardGrid(
                    pals: state.pals,
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ],
      ),
    );
  }
}

class CustomCardGrid extends StatelessWidget {
  final List<PalModel> pals;
  const CustomCardGrid({Key? key, required this.pals}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Calculate the number of columns based on screen width
    double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = (screenWidth / 180).floor(); // Adjust 180 as needed

    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 4.0,
      ),
      itemCount: pals.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(_buildPageRoute(pals[index]));
          },
          child: CustomCard(
            name: pals[index].name,
            types: pals[index].types[0],
            imageWiki: pals[index].imageWiki,
          ),
        );
      },
    );
  }

  PageRouteBuilder _buildPageRoute(PalModel pal) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return DetailPage(pal: pal);
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.easeInOutQuart;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);
        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }
}

class DetailPage extends StatelessWidget {
  final PalModel pal;

  const DetailPage({Key? key, required this.pal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 70, 70, 70),
      appBar: AppBar(
        titleSpacing: 1.0,
        backgroundColor: Helper.getTypeColor(pal.types[0]),
        leading: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios_rounded),
                color: Colors.white,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      'Element(s): ',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 10),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: pal.types.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            SizedBox(
                              width: 35,
                              height: 35,
                              child: Image.network(
                                Helper.getTypeImage(pal.types[index]),
                                fit: BoxFit.fill,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              Helper.capitalize(pal.types[index]),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        leadingWidth: 1450,
        toolbarHeight: 260,
        actions: [
          Hero(
            tag: 'hero_${pal.name}',
            child: Image.network(
              pal.imageWiki,
              fit: BoxFit.scaleDown,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                pal.name.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                  letterSpacing: 2.0,
                ),
              ),
              const Divider(
                color: Colors.white,
                height: 20,
              ),
              Text(
                pal.description,
                style: const TextStyle(
                  color: Colors.white,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              const Divider(
                color: Colors.white,
                height: 20,
              ),
              const Text(
                'Active Skills',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  letterSpacing: 2.0,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: pal.skills.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Helper.getTypeColor(
                          pal.skills[index].type.toLowerCase()),
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 35,
                              height: 35,
                              child: Image.network(
                                Helper.getTypeImage(
                                    pal.skills[index].type.toLowerCase()),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              pal.skills[index].name.toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                letterSpacing: 1.0,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Level: ${pal.skills[index].level}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    letterSpacing: 1.0,
                                  ),
                                ),
                                Text(
                                  'Power: ${pal.skills[index].power}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    letterSpacing: 1.0,
                                  ),
                                ),
                                Text(
                                  'Cooldown: ${pal.skills[index].cooldown}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    letterSpacing: 1.0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
