import 'package:budget/database/tables.dart';
import 'package:budget/functions.dart';
import 'package:budget/main.dart';
import 'package:budget/pages/addCategoryPage.dart';
import 'package:budget/pages/creditDebtTransactionsPage.dart';
import 'package:budget/pages/editCategoriesPage.dart';
import 'package:budget/pages/editHomePage.dart';
import 'package:budget/pages/objectivesListPage.dart';
import 'package:budget/pages/settingsPage.dart';
import 'package:budget/pages/walletDetailsPage.dart';
import 'package:budget/struct/settings.dart';
import 'package:budget/widgets/navigationFramework.dart';
import 'package:budget/widgets/openBottomSheet.dart';
import 'package:budget/widgets/framework/popupFramework.dart';
import 'package:budget/widgets/openPopup.dart';
import 'package:budget/widgets/outlinedButtonStacked.dart';
import 'package:budget/widgets/textWidgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'listItem.dart';


String getChangelogString() {
  return """
    < 1.0.3
    Exclude transaction from counting towards reports and totals (in more options)
    Percentage decimal precision setting (in Settings > More Options > Formatting)
    Graph axis label supports locale and short form for > 1,000
    Fixed text focus resume for inactive app
    If accounts all have same currency, currency label is removed in select chips
    Unfocus and remove focus node from cache when navigating
    Fixed confetti canvas size for completed loans/goals
    Removed selectable accent colors that don't change the app theme
   
end""";
}

// If they were not already seen by a user, they are shown at the top of the changelog
Map<String, List<MajorChanges>> getMajorChanges() {
  return {
    "< 4.4.1": [
      MajorChanges(
        "major-change-1".tr(),
        Icons.arrow_drop_up_rounded,
        info: [
          "major-change-1-1".tr(),
        ],
      ),
      MajorChanges(
        "major-change-2".tr(),
        Icons.category_rounded,
        info: [
          "major-change-2-1".tr(),
        ],
      ),
      MajorChanges(
        "major-change-3".tr(),
        Icons.savings_rounded,
        info: [
          "major-change-3-1".tr(),
          "major-change-3-2".tr(),
        ],
        onTap: (context) {
          pushRoute(context, ObjectivesListPage(backButton: true));
        },
      ),
      MajorChanges(
        "major-change-4".tr(),
        Icons.home_rounded,
        info: [
          "major-change-4-1".tr(),
          "major-change-4-2".tr(),
        ],
        onTap: (context) {
          pushRoute(context, EditHomePage());
        },
      ),
      MajorChanges(
        "major-change-5".tr(),
        Icons.emoji_emotions_rounded,
        info: [
          "major-change-5-1".tr(),
        ],
        onTap: (context) {
          pushRoute(context, EditCategoriesPage());
        },
      ),
      // MajorChanges(
      //   "major-change-6".tr(),
      //   Icons.bug_report_rounded,
      //   info: [
      //     "major-change-6-1".tr(),
      //   ],
      // ),
    ],
    "< 4.4.6": [
      MajorChanges(
        "major-change-7".tr(),
        Icons.timelapse_rounded,
        info: [
          "major-change-7-1".tr(),
        ],
        onTap: (context) {
          pushRoute(context, WalletDetailsPage(wallet: null));
        },
      ),
      MajorChanges(
        "major-change-8".tr(),
        Icons.price_change_rounded,
      ),
    ],
    "< 4.5.1": [
      MajorChanges(
        "major-change-9".tr(),
        Icons.file_open_rounded,
        info: [
          "major-change-9-1".tr(),
        ],
        onTap: (context) {
          pushRoute(context, SettingsPageFramework());
        },
      ),
      MajorChanges(
        "major-change-10".tr(),
        Icons.edit_rounded,
        info: [
          "major-change-10-1".tr(),
        ],
        onTap: (context) {
          pushRoute(context, EditHomePage());
        },
      ),
    ],
    "< 4.6.6": [
      MajorChanges(
        "major-change-11".tr(),
        Icons.category_rounded,
        info: [
          "major-change-11-1".tr(),
        ],
        onTap: (context) {
          pushRoute(
            context,
            AddCategoryPage(
              routesToPopAfterDelete: RoutesToPopAfterDelete.None,
            ),
          );
        },
      ),
      MajorChanges(
        "major-change-12".tr(),
        Icons.list_rounded,
        info: [
          "major-change-12-1".tr(),
        ],
        onTap: (context) {
          pushRoute(context, EditHomePage());
        },
      ),
      MajorChanges(
        "major-change-6".tr(),
        Icons.bug_report_rounded,
        info: [
          "major-change-6-1".tr(),
        ],
      ),
    ],
    "< 4.7.9": [
      MajorChanges(
        "major-change-14".tr(),
        Icons.attach_file_rounded,
        info: [
          "major-change-14-1".tr(),
        ],
      ),
    ],
    "< 4.8.8": [
      MajorChanges(
        "major-change-15".tr(),
        Icons.add_box_rounded,
        info: [
          "major-change-15-1".tr(),
        ],
        onTap: (context) {
          openBottomSheet(
            context,
            PopupFramework(
              child: AddMoreThingsPopup(),
            ),
          );
        },
      ),
    ],
    "< 4.8.9": [
      MajorChanges(
        "major-change-16".tr(),
        Icons.receipt_long_rounded,
        info: [
          "major-change-16-1".tr(),
        ],
        onTap: (context) {
          pushRoute(context, WalletDetailsPage(wallet: null));
        },
      ),
    ],
    "< 5.0.3": [
      MajorChanges(
        "major-change-17".tr(),
        Icons.av_timer_rounded,
        info: [
          "major-change-17-1".tr(),
        ],
        onTap: (context) {
          pushRoute(
            context,
            CreditDebtTransactions(
              isCredit: null,
            ),
          );
        },
      ),
    ],
  };
}

bool showChangelog(
  BuildContext context, {
  bool forceShow = false,
  bool majorChangesOnly = false,
  Widget? extraWidget,
}) {
  String version = packageInfoGlobal.version;

  List<Widget>? changelogPoints = getChangelogPointsWidgets(
    context,
    forceShow: forceShow,
    majorChangesOnly:
        Localizations.localeOf(context).toString().toLowerCase() != "en"
            ? true
            : majorChangesOnly,
  );

  updateSettings(
    "lastLoginVersion",
    version,
    pagesNeedingRefresh: [],
    updateGlobalState: false,
  );

  //Don't show changelog on first login and only show if english, unless forced
  if (changelogPoints != null &&
      changelogPoints.length > 0 &&
      (forceShow ||
          (appStateSettings["numLogins"] > 1
          //   &&  Localizations.localeOf(context).toString().toLowerCase() == "en"
          ))) {
    openBottomSheet(
      context,
      PopupFramework(
        title: "changelog".tr(),
        subtitle: getVersionString(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [(extraWidget ?? SizedBox.shrink()), ...changelogPoints],
        ),
        showCloseButton: true,
      ),
      showScrollbar: true,
    );
    return true;
  }
  return false;
}

List<Widget>? getChangelogPointsWidgets(BuildContext context,
    {bool forceShow = false, bool majorChangesOnly = false}) {
  String changelog = getChangelogString();
  Map<String, List<MajorChanges>> majorChanges = getMajorChanges();
  String version = packageInfoGlobal.version;
  int versionInt = parseVersionInt(version);
  int lastLoginVersionInt =
      parseVersionInt(appStateSettings["lastLoginVersion"]);

  if (forceShow || lastLoginVersionInt != versionInt) {
    List<Widget> changelogPoints = [];
    List<Widget> majorChangelogPointsAtTop = [];

    int versionBookmark = versionInt;
    for (String string in changelog.split("\n")) {
      string = string.replaceFirst("    ", ""); // remove the indent
      if (getPlatform() != PlatformOS.isIOS) {
        string = string.replaceAll("(A)", "Android");
        string = string.replaceAll("(i)", "iOS");
      }
      // Skip android changes on iOS
      if (getPlatform() == PlatformOS.isIOS && string.contains(("(A)"))) {
        continue;
      }
      if (string.startsWith("< ")) {
        if (forceShow) {
          changelogPoints.addAll(getAllMajorChangeWidgetsForVersion(
                  context, string, majorChanges) ??
              []);
        }

        versionBookmark = parseVersionInt(string.replaceAll("< ", ""));
        if (forceShow == false && versionBookmark <= lastLoginVersionInt) {
          continue;
        }

        majorChangelogPointsAtTop.addAll(
            getAllMajorChangeWidgetsForVersion(context, string, majorChanges) ??
                []);

        if (majorChangesOnly == true) {
          continue;
        }

        changelogPoints.add(Padding(
          padding: const EdgeInsets.only(bottom: 5, top: 3),
          child: TextFont(
            text: string.replaceAll("< ", ""),
            fontSize: 25,
            maxLines: 10,
            fontWeight: FontWeight.bold,
          ),
        ));
        continue;
      }

      if (majorChangesOnly == true) {
        continue;
      }

      if (forceShow == false && versionBookmark <= lastLoginVersionInt) {
        continue;
      }

      if (string.trim() == "") {
        // this is an empty line
        changelogPoints.add(SizedBox(
          height: 8,
        ));
      } else if (string.trim() != "end") {
        changelogPoints.add(Padding(
          padding: const EdgeInsets.only(bottom: 5.5),
          child: TextFont(
            text: string,
            fontSize: 16.5,
            maxLines: 5,
          ),
        ));
      }
    }
    if (changelogPoints.length > 0)
      changelogPoints.add(
        SizedBox(height: 10),
      );

    if (!forceShow) changelogPoints.insertAll(0, majorChangelogPointsAtTop);
    return changelogPoints;
  }
  return null;
}

int parseVersionInt(String versionString) {
  try {
    int parsedVersion = int.parse(versionString.replaceAll(".", ""));
    return parsedVersion;
  } catch (e) {
    print("Error parsing version number, defaulting to version 0.");
  }
  return 0;
}

String getVersionString() {
  String version = packageInfoGlobal.version;
  String buildNumber = packageInfoGlobal.buildNumber;
  return "v" +
      version +
      "+" +
      buildNumber +
      ", db-v" +
      schemaVersionGlobal.toString();
}

class MajorChanges {
  MajorChanges(this.title, this.icon, {this.info, this.onTap});

  String title;
  IconData icon;
  List<String>? info;
  Function(BuildContext context)? onTap;
}

List<Widget>? getAllMajorChangeWidgetsForVersion(BuildContext context,
    String version, Map<String, List<MajorChanges>> majorChanges) {
  if (majorChanges[version] == null) return null;
  return [
    SizedBox(height: 5),
    for (MajorChanges majorChange in (majorChanges[version] ?? []))
      Padding(
        padding: const EdgeInsets.only(
          bottom: 5,
          top: 5,
        ),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButtonStacked(
                filled: false,
                alignLeft: true,
                alignBeside: true,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                text: majorChange.title.tr(),
                iconData: majorChange.icon,
                onTap: majorChange.onTap == null
                    ? null
                    : () => majorChange.onTap!(context),
                afterWidget: majorChange.info == null
                    ? null
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (String info in majorChange.info ?? [])
                            ListItem(
                              info.tr(),
                            ),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    SizedBox(height: 10),
  ];
}
