import 'package:dotted/models/on_boarding_page_model.dart';
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
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  _onFinish() async {
    widget.onFinish.call();
  }

  @override
  Widget build(BuildContext context) {
    final preferences = widget.pages[_currentPage].preferences;
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        color: widget.pages[_currentPage].bgColor,
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
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
              preferences.isNotEmpty
                  ? Expanded(
                      child: Wrap(
                        spacing: 10,
                        children: preferences.map((item) {
                          final activeItem = widget
                              .pages[_currentPage].selectedPreferences
                              .contains(item);
                          return ElevatedButton(
                            onPressed: () {
                              widget.pages[_currentPage]
                                  .onPreferenceSelected(item);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  activeItem ? Colors.purple.shade100 : null,
                            ),
                            child: Text(
                              item.name,
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
