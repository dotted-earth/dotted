import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:touchdown/constants/routes.dart';
import 'package:touchdown/constants/supabase.dart';
import 'package:collection/collection.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  finishOnboarding(context) async {
    try {
      await supabase
          .from("profiles")
          .update(
              {"has_onboarded": false}) // change to TRUE when done with feature
          .eq("id", supabase.auth.currentUser!.id)
          .then((_) async => {
                await Navigator.pushNamedAndRemoveUntil(
                    context, routes.home, (_) => false)
              });
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnboardingPagePresenter(
          onFinish: () {
            finishOnboarding(context);
          },
          pages: [
            OnboardingPageModel(
              title: 'Welcome to Touchdown!',
              description:
                  "Before we can begin, we have to get your travel preferences in order to serve you",
              imageUrl: 'https://i.ibb.co/cJqsPSB/scooter.png',
            ),
            OnboardingPageModel(
              title: 'Recreations',
              description: 'What kind of activities do you like?',
              imageUrl: 'https://cdn-icons-png.freepik.com/512/962/962431.png',
              dataKey: 'recreations',
            ),
            OnboardingPageModel(
              title: 'Diets',
              description: 'What is your general diet?',
              imageUrl:
                  'https://cdn-icons-png.freepik.com/512/3775/3775187.png',
              dataKey: "diets",
            ),
            OnboardingPageModel(
              title: 'Cuisines',
              description: 'What kind of foods do you like?',
              imageUrl:
                  'https://cdn-icons-png.freepik.com/512/11040/11040884.png',
              dataKey: "cuisines",
            ),
            OnboardingPageModel(
              title: 'Food Allergies',
              description: 'Do you have any food allergies?',
              imageUrl:
                  'https://cdn-icons-png.freepik.com/512/5282/5282049.png',
              dataKey: "foodAllergies",
            ),
          ]),
    );
  }
}

class OnboardingPagePresenter extends StatefulWidget {
  final List<OnboardingPageModel> pages;
  final VoidCallback onFinish;

  const OnboardingPagePresenter({
    super.key,
    required this.pages,
    required this.onFinish,
  });

  @override
  State<OnboardingPagePresenter> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPagePresenter> {
  // Store the currently visible page
  int _currentPage = 0;
  bool _isLoading = true;

  Map<String, PreferenceCategory> _preferences = {
    'recreations': PreferenceCategory(data: [], isSelected: []),
    'diets': PreferenceCategory(
      isSelected: [],
      data: [],
    ),
    'cuisines': PreferenceCategory(
      isSelected: [],
      data: [],
    ),
    'foodAllergies': PreferenceCategory(
      isSelected: [],
      data: [],
    ),
  };

  // Define a controller for the pageview
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  _fetchData() async {
    final recreations = await supabase.from("recreations").select();
    final diets = await supabase.from("diets").select();
    final cuisines = await supabase.from('cuisines').select();
    final foodAllergies = await supabase.from('food_allergies').select();

    setState(() {
      _preferences = {
        'foodAllergies': PreferenceCategory(
          isSelected: List.filled(foodAllergies.length, false),
          data: foodAllergies,
        ),
        'cuisines': PreferenceCategory(
          isSelected: List.filled(cuisines.length, false),
          data: cuisines,
        ),
        'recreations': PreferenceCategory(
          isSelected: List.filled(recreations.length, false),
          data: recreations,
        ),
        'diets': PreferenceCategory(
          isSelected: List.filled(diets.length, false),
          data: diets,
        )
      };

      _isLoading = false;
    });
  }

  _saveUsersPreferences() async {
    setState(() {
      _isLoading = true;
    });
    final userId = supabase.auth.currentUser!.id;

    final selectedRecreations = _preferences["recreations"]!
        .isSelected
        .mapIndexed((index, element) =>
            element ? _preferences["recreations"]!.data[index] : null)
        .whereNotNull()
        .map((item) => ({
              'user_id': userId,
              'recreation_id': item["id"],
            }))
        .toList();

    print(selectedRecreations);

    // TODO - fix this when supabase fix their client
    // await supabase
    //     .from("user_recreations")
    //     .upsert(
    //       selectedRecreations,
    //       ignoreDuplicates: true,
    //     );

    setState(() {
      _isLoading = false;
    });
  }

  _onFinish() async {
    await _saveUsersPreferences();
    widget.onFinish.call();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
          body: Center(
        child: CircularProgressIndicator(),
      ));
    }
    final key = widget.pages[_currentPage].dataKey;
    final hasDataKey = key != null;

    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        color: widget.pages[_currentPage].bgColor,
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                // Pageview to render each page
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: widget.pages.length,
                  onPageChanged: (idx) {
                    setState(() {
                      _currentPage = idx;
                    });
                  },
                  itemBuilder: (context, idx) {
                    final item = widget.pages[idx];
                    return Column(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(
                              item.imageUrl,
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: Column(children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(item.title,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: item.textColor,
                                        )),
                              ),
                              Container(
                                constraints:
                                    const BoxConstraints(maxWidth: 280),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24.0, vertical: 8.0),
                                child: Text(item.description,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: item.textColor,
                                        )),
                              )
                            ]))
                      ],
                    );
                  },
                ),
              ),
              hasDataKey
                  ? Expanded(
                      child: Wrap(
                        spacing: 10,
                        children:
                            _preferences[key]!.data.mapIndexed((index, item) {
                          return ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _preferences[key]!.isSelected[index] =
                                    !_preferences[key]!.isSelected[index];
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  _preferences[key]!.isSelected[index]
                                      ? Colors.purple[100]
                                      : null,
                            ),
                            child: Text(
                              item['name'],
                            ),
                          );
                        }).toList(),
                      ),
                    )
                  : const SizedBox(),
              // Current page indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.pages
                    .map((item) => AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          width: _currentPage == widget.pages.indexOf(item)
                              ? 30
                              : 8,
                          height: 8,
                          margin: const EdgeInsets.all(2.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0)),
                        ))
                    .toList(),
              ),

              // Bottom buttons
              SizedBox(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _currentPage != 0
                        ? TextButton(
                            style: TextButton.styleFrom(
                                visualDensity: VisualDensity.comfortable,
                                foregroundColor: Colors.black45,
                                textStyle: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            onPressed: () {
                              _pageController.animateToPage(_currentPage - 1,
                                  curve: Curves.easeInOutCubic,
                                  duration: const Duration(milliseconds: 250));
                            },
                            child: const Text("Back"))
                        : const SizedBox(),
                    TextButton(
                      style: TextButton.styleFrom(
                          visualDensity: VisualDensity.comfortable,
                          foregroundColor: Colors.black45,
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          )),
                      onPressed: () {
                        if (_currentPage == widget.pages.length - 1) {
                          _onFinish();
                        } else {
                          _pageController.animateToPage(_currentPage + 1,
                              curve: Curves.easeInOutCubic,
                              duration: const Duration(milliseconds: 250));
                        }
                      },
                      child: Row(
                        children: [
                          Text(
                            _currentPage == widget.pages.length - 1
                                ? "Finish"
                                : "Next",
                          ),
                          const SizedBox(width: 8),
                          Icon(_currentPage == widget.pages.length - 1
                              ? Icons.done
                              : Icons.arrow_forward),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class OnboardingPageModel {
  final String title;
  final String description;
  final String imageUrl;
  final Color bgColor;
  final Color textColor;
  final String? dataKey;

  OnboardingPageModel(
      {required this.title,
      required this.description,
      required this.imageUrl,
      this.dataKey,
      this.bgColor = Colors.white,
      this.textColor = Colors.black87});
}

class PreferenceCategory {
  List<bool> isSelected;
  List<Map<String, dynamic>> data;

  PreferenceCategory({
    required this.isSelected,
    required this.data,
  });
}
