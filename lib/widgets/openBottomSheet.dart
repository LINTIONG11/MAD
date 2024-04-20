import 'package:budget/functions.dart';
import 'package:budget/struct/settings.dart';
import 'package:budget/widgets/navigationSidebar.dart';
import 'package:budget/widgets/textInput.dart';
import 'package:flutter/material.dart';
import 'package:budget/colors.dart';
import 'package:flutter/services.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import 'package:budget/widgets/scrollbarWrap.dart';

bool getIsFullScreen(context) {
  return getWidthNavigationSidebar(context) > 0;
  double maxWidth = 700;
  return MediaQuery.sizeOf(context).width > maxWidth;
}

double getWidthBottomSheet(context) {
  double maxWidth = 900;
  return MediaQuery.sizeOf(context).width - getWidthNavigationSidebar(context) >
          maxWidth
      ? maxWidth - getWidthNavigationSidebar(context)
      : MediaQuery.sizeOf(context).width - getWidthNavigationSidebar(context);
}

double getHorizontalPaddingConstrained(context, {bool enabled = true}) {
  if (enabled == false) return 0;
  if (MediaQuery.sizeOf(context).width >= 550 &&
      MediaQuery.sizeOf(context).width <= 1000 &&
      getIsFullScreen(context) == false) {
    double returnedPadding = 0;
    returnedPadding = MediaQuery.sizeOf(context).width / 3 - 140;
    return returnedPadding < 0 ? 0 : returnedPadding;
  } else if (MediaQuery.sizeOf(context).width <= 1000 &&
      getIsFullScreen(context) &&
      appStateSettings["expandedNavigationSidebar"] == true) {
    double returnedPadding = 0;
    returnedPadding = MediaQuery.sizeOf(context).width / 5 - 125;
    return returnedPadding < 0 ? 0 : returnedPadding;
  }
  // When the navigation bar is closed
  else if (MediaQuery.sizeOf(context).width <= 1000 &&
      getIsFullScreen(context) &&
      appStateSettings["expandedNavigationSidebar"] == false) {
    double returnedPadding = 0;
    returnedPadding = MediaQuery.sizeOf(context).width / 3.5 - 125;
    return returnedPadding < 0 ? 0 : returnedPadding;
  } else if (getIsFullScreen(context) &&
      appStateSettings["expandedNavigationSidebar"] == false) {
    double returnedPadding = 0;
    returnedPadding = (MediaQuery.sizeOf(context).width - 500) / 3;
    return returnedPadding < 0 ? 0 : returnedPadding;
  }

  return (MediaQuery.sizeOf(context).width - getWidthBottomSheet(context)) / 3;
}

SheetController? bottomSheetControllerGlobalCustomAssigned;

late SheetController bottomSheetControllerGlobal;
// Set snap to false if there is a keyboard
Future openBottomSheet(
  context,
  child, {
  bool maxHeight = true,
  bool snap = true,
  bool resizeForKeyboard = true,
  bool showScrollbar = false,
  bool fullSnap = false,
  bool isDismissable = true,
  bool useCustomController = false,
  bool reAssignBottomSheetControllerGlobal = true,
}) async {
  //minimize keyboard when open
  minimizeKeyboard(context);
  if (reAssignBottomSheetControllerGlobal)
    bottomSheetControllerGlobal = new SheetController();
  if (useCustomController == true)
    bottomSheetControllerGlobalCustomAssigned = new SheetController();
  return await showSlidingBottomSheet(
    context,
    resizeToAvoidBottomInset: resizeForKeyboard,
    // getOSInsideWeb() == "iOS" ? false : resizeForKeyboard,
    bottomPaddingColor: appStateSettings["materialYou"]
        ? dynamicPastel(
            context, Theme.of(context).colorScheme.secondaryContainer,
            amountDark: 0.3, amountLight: 0.6)
        : getColor(context, "lightDarkAccent"),
    builder: (context) {
      double deviceAspectRatio =
          MediaQuery.sizeOf(context).height / MediaQuery.sizeOf(context).width;

      return SlidingSheetDialog(
        isDismissable: isDismissable,
        maxWidth: getWidthBottomSheet(context),
        scrollSpec: ScrollSpec(
          overscroll: false,
          overscrollColor: Colors.transparent,
          showScrollbar: showScrollbar,
          scrollbar: ((child) => ScrollbarWrap(child: child)),
        ),
        controller: useCustomController
            ? bottomSheetControllerGlobalCustomAssigned
            : bottomSheetControllerGlobal,
        elevation: 0,
        isBackdropInteractable: true,
        dismissOnBackdropTap: true,
        cornerRadiusOnFullscreen: 0,
        avoidStatusBar: true,
        extendBody: true,
        headerBuilder: (context, state) {
          return SizedBox(height: 10);
        },
        snapSpec: SnapSpec(
          snap: snap,
          snappings: fullSnap == false &&
                  getIsFullScreen(context) == false &&
                  deviceAspectRatio > 2
              ? [0.6, 1]
              : [0.95, 1],
          positioning: SnapPositioning.relativeToAvailableSpace,
        ),
        listener: (SheetState state) {
          if (state.maxExtent == 1 &&
              state.isExpanded &&
              state.isAtTop &&
              state.currentScrollOffset == 0 &&
              state.progress == 1 &&
              ScrollConfiguration.of(context)
                      .getScrollPhysics(context)
                      .toString() !=
                  "BouncingScrollPhysics" &&
              getPlatform() != PlatformOS.isIOS) {
            HapticFeedback.heavyImpact();
          }
        },
        color: appStateSettings["materialYou"]
            ? dynamicPastel(
                context, Theme.of(context).colorScheme.secondaryContainer,
                amountDark: 0.3, amountLight: 0.6)
            : getColor(context, "lightDarkAccent"),
        cornerRadius: getPlatform() == PlatformOS.isIOS ? 10 : 20,
        duration: Duration(milliseconds: 300),
        builder: (context, state) {
          return Material(
            child: SingleChildScrollView(
              child: child,
            ),
          );
        },
      );
    },
  );
}
