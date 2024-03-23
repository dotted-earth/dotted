import 'package:collection/collection.dart';
import 'package:dotted/constants/supabase.dart';
import 'package:dotted/features/user/models/on_boarding_page_model.dart';
import 'package:dotted/features/user/models/user_preference_category_model.dart';
import 'package:flutter/material.dart';

class OnBoardingPagePresenter extends StatefulWidget {
  final List<OnBoardingPageModel> pages;
  final VoidCallback onFinish;

  const OnBoardingPagePresenter({
    super.key,
    required this.pages,
    required this.onFinish,
  });

  @override
  State<OnBoardingPagePresenter> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnBoardingPagePresenter> {
  // Store the currently visible page
  int _currentPage = 0;
  bool _isLoading = true;

  Map<String, UserPreferenceCategoryModel> _preferences = {
    'recreations': UserPreferenceCategoryModel(data: [], isSelected: []),
    'diets': UserPreferenceCategoryModel(
      isSelected: [],
      data: [],
    ),
    'cuisines': UserPreferenceCategoryModel(
      isSelected: [],
      data: [],
    ),
    'foodAllergies': UserPreferenceCategoryModel(
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
        'foodAllergies': UserPreferenceCategoryModel(
          isSelected: List.filled(foodAllergies.length, false),
          data: foodAllergies,
        ),
        'cuisines': UserPreferenceCategoryModel(
          isSelected: List.filled(cuisines.length, false),
          data: cuisines,
        ),
        'recreations': UserPreferenceCategoryModel(
          isSelected: List.filled(recreations.length, false),
          data: recreations,
        ),
        'diets': UserPreferenceCategoryModel(
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

    final selectedDiets = _preferences["diets"]!
        .isSelected
        .mapIndexed((index, element) =>
            element ? _preferences["diets"]!.data[index] : null)
        .whereNotNull()
        .map((item) => ({
              'user_id': userId,
              'diet_id': item["id"],
            }))
        .toList();

    final selectedCuisines = _preferences["cuisines"]!
        .isSelected
        .mapIndexed((index, element) =>
            element ? _preferences["cuisines"]!.data[index] : null)
        .whereNotNull()
        .map((item) => ({
              'user_id': userId,
              'cuisine_id': item["id"],
            }))
        .toList();

    final selectedFoodAllergies = _preferences["foodAllergies"]!
        .isSelected
        .mapIndexed((index, element) =>
            element ? _preferences["foodAllergies"]!.data[index] : null)
        .whereNotNull()
        .map((item) => ({
              'user_id': userId,
              'food_allergy_id': item["id"],
            }))
        .toList();

    try {
      var futures = List.of([
        supabase.from("user_recreations").upsert(selectedRecreations),
        supabase.from("user_diets").upsert(selectedDiets),
        supabase.from("user_cuisines").upsert(selectedCuisines),
        supabase.from("user_food_allergies").upsert(selectedFoodAllergies)
      ]);

      await Future.wait(futures).then((data) => {
            setState(() {
              _isLoading = false;
            })
          });
    } catch (err) {
      print(err);
      setState(() {
        _isLoading = false;
      });
    }
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
