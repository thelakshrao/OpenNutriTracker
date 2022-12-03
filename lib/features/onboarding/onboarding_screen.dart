import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:opennutritracker/features/onboarding/domain/entity/user_data_mask_entity.dart';
import 'package:opennutritracker/features/onboarding/domain/entity/user_gender_selection_entity.dart';
import 'package:opennutritracker/features/onboarding/presentation/onboarding_intro_page_body.dart';
import 'package:opennutritracker/features/onboarding/presentation/widgets/onboarding_fourth_page_body.dart';
import 'package:opennutritracker/features/onboarding/presentation/widgets/onboarding_overview_page_body.dart';
import 'package:opennutritracker/features/onboarding/presentation/widgets/onboarding_third_page_body.dart';
import 'package:opennutritracker/features/onboarding/presentation/widgets/highlight_button.dart';
import 'package:opennutritracker/features/onboarding/presentation/widgets/onboarding_first_page_body.dart';
import 'package:opennutritracker/features/onboarding/presentation/widgets/onboarding_second_page_body.dart';
import 'package:opennutritracker/generated/l10n.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _introKey = GlobalKey<IntroductionScreenState>();

  final _userData = UserDataMaskEntity();

  bool _firstPageButtonActive = false;
  bool _secondPageButtonActive = false;
  bool _thirdPageButtonActive = false;
  bool _fourthPageButtonActive = false;
  bool _overviewPageButtonActive = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IntroductionScreen(
            key: _introKey,
            scrollPhysics: const NeverScrollableScrollPhysics(),
            back: const Icon(Icons.arrow_back_outlined),
            showBackButton: true,
            showNextButton: false,
            showDoneButton: false,
            isProgressTap: false,
            dotsFlex: 0,
            dotsDecorator: DotsDecorator(
              size: const Size(10.0, 10.0),
              activeColor: Theme.of(context).colorScheme.primary,
              activeSize: const Size(22.0, 10.0),
              activeShape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
            ),
            pages: getPageViewModels()),
      ),
    );
  }

  List<PageViewModel> getPageViewModels() => <PageViewModel>[
        PageViewModel(
            title: S.of(context).onboardingWelcomeLabel,
            bodyWidget: const OnboardingIntroPageBody(),
            footer: HighlightButton(
              buttonLabel: S.of(context).buttonStartLabel,
              onButtonPressed: () => _scrollNexPage(1),
              buttonActive: true,
            )),
        PageViewModel(
            titleWidget: const SizedBox(), // empty
            bodyWidget: OnboardingFirstPageBody(
              setPageContent: _setFirstPageData,
            ),
            footer: HighlightButton(
              buttonLabel: S.of(context).buttonNextLabel,
              onButtonPressed: () => _scrollNexPage(2),
              buttonActive: _firstPageButtonActive,
            )),
        PageViewModel(
            titleWidget: const SizedBox(), // empty
            bodyWidget: OnboardingSecondPageBody(
              setButtonActive: _setSecondPageButton,
            ),
            footer: HighlightButton(
              buttonLabel: S.of(context).buttonNextLabel,
              onButtonPressed: () => _scrollNexPage(3),
              buttonActive: _secondPageButtonActive,
            )),
        PageViewModel(
            titleWidget: const SizedBox(), // empty
            bodyWidget: OnboardingThirdPageBody(
              setButtonActive: _setThirdPageButton,
            ),
            footer: HighlightButton(
              buttonLabel: S.of(context).buttonNextLabel,
              onButtonPressed: () => _scrollNexPage(4),
              buttonActive: _thirdPageButtonActive,
            )),
        PageViewModel(
            titleWidget: const SizedBox(), // empty
            bodyWidget: OnboardingFourthPageBody(
              setButtonActive: _setFourthPageButton,
            ),
            footer: HighlightButton(
              buttonLabel: S.of(context).buttonNextLabel,
              onButtonPressed: () => _scrollNexPage(5),
              buttonActive: _fourthPageButtonActive,
            )),
        PageViewModel(
            titleWidget: const SizedBox(), // empty
            bodyWidget: OnboardingOverviewPageBody(
              setButtonActive: _setOverviewPageButton,
            ),
            footer: HighlightButton(
              buttonLabel: S.of(context).buttonStartLabel,
              onButtonPressed: () {
                _onOverviewStartButtonPressed();
              },
              buttonActive: _overviewPageButtonActive,
            )),
      ];

  void _scrollNexPage(int page) {
    _introKey.currentState?.animateScroll(page);
  }

  void _setFirstPageData(bool active,
      UserGenderSelectionEntity? selectedGender, DateTime? selectedBirthday) {
    setState(() {
      _userData.gender = selectedGender;
      _userData.birthday = selectedBirthday;

      _firstPageButtonActive = active;
    });
  }

  void _setSecondPageButton(bool active) {
    setState(() {
      _secondPageButtonActive = active;
    });
  }

  void _setThirdPageButton(bool active) {
    setState(() {
      _thirdPageButtonActive = active;
    });
  }

  void _setFourthPageButton(bool active) {
    setState(() {
      _fourthPageButtonActive = active;
    });
  }

  void _setOverviewPageButton(bool active) {
    setState(() {
      _overviewPageButtonActive = active;
    });
  }

  void _onOverviewStartButtonPressed() {
    // TODO
  }
}