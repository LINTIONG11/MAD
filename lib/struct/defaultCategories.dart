import 'package:budget/colors.dart';
import 'package:budget/database/tables.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

List<TransactionCategory> defaultCategories() {
  return [
    // Note "0" categoryPk is reserved for wallet/account total correction category
    TransactionCategory(
      categoryPk: "1",
      name: "default-category-dining".tr(),
      colour: toHexString(Colors.blueGrey),
      iconName: "cutlery.png",
      dateCreated: DateTime.now(),
      dateTimeModified: null,
      order: 0,
      income: false,
    ),
    TransactionCategory(
      categoryPk: "2",
      name: "default-category-groceries".tr(),
      colour: toHexString(Colors.green),
      iconName: "groceries.png",
      dateCreated: DateTime.now(),
      dateTimeModified: null,
      order: 1,
      income: false,
    ),
    TransactionCategory(
      categoryPk: "3",
      name: "default-category-shopping".tr(),
      colour: toHexString(Colors.pink),
      iconName: "shopping.png",
      dateCreated: DateTime.now(),
      dateTimeModified: null,
      order: 2,
      income: false,
    ),
    TransactionCategory(
      categoryPk: "4",
      name: "default-category-transit".tr(),
      colour: toHexString(Colors.yellow),
      iconName: "tram.png",
      dateCreated: DateTime.now(),
      dateTimeModified: null,
      order: 3,
      income: false,
    ),
    TransactionCategory(
      categoryPk: "5",
      name: "default-category-entertainment".tr(),
      colour: toHexString(Colors.blue),
      iconName: "popcorn.png",
      dateCreated: DateTime.now(),
      dateTimeModified: null,
      order: 4,
      income: false,
    ),
    TransactionCategory(
      categoryPk: "6",
      name: "default-category-bills-fees".tr(),
      colour: toHexString(Colors.green),
      iconName: "bills.png",
      dateCreated: DateTime.now(),
      dateTimeModified: null,
      order: 5,
      income: false,
    ),

    TransactionCategory(
      categoryPk: "7",
      name: "default-category-gifts".tr(),
      colour: toHexString(Colors.red),
      iconName: "gift.png",
      dateCreated: DateTime.now(),
      dateTimeModified: null,
      order: 6,
      income: false,
    ),
    TransactionCategory(
      categoryPk: "8",
      name: "default-category-beauty".tr(),
      colour: toHexString(Colors.purple),
      iconName: "flower.png",
      dateCreated: DateTime.now(),
      dateTimeModified: null,
      order: 8,
      income: false,
    ),
    TransactionCategory(
      categoryPk: "9",
      name: "default-category-work".tr(),
      colour: toHexString(Colors.brown),
      iconName: "briefcase.png",
      dateCreated: DateTime.now(),
      dateTimeModified: null,
      order: 9,
      income: false,
    ),
    TransactionCategory(
      categoryPk: "10",
      name: "default-category-travel".tr(),
      colour: toHexString(Colors.orange),
      iconName: "plane.png",
      dateCreated: DateTime.now(),
      dateTimeModified: null,
      order: 10,
      income: false,
    ),
    TransactionCategory(
      categoryPk: "11",
      name: "default-category-income".tr(),
      colour: toHexString(Colors.deepPurple.shade300),
      iconName: "coin.png",
      dateCreated: DateTime.now(),
      dateTimeModified: null,
      order: 11,
      income: true,
    ),
  ];
}
