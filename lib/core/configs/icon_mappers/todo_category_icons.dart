import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_note/core/configs/assets/app_vectors.dart';
import 'package:repositories/repositories.dart';

class TodoCategoryIcons {
  static Map<CategoryType, SvgPicture> categoryIcons = {
    CategoryType.feeding: SvgPicture.asset(AppVectors.feeding, width: 36, colorFilter: const ColorFilter.mode(Colors.green, BlendMode.srcIn),),
    CategoryType.inspection: SvgPicture.asset(AppVectors.inspection, width: 36, colorFilter: const ColorFilter.mode(Colors.blue, BlendMode.srcIn),),
    CategoryType.harvest: SvgPicture.asset(AppVectors.harvest, width: 36, colorFilter: const ColorFilter.mode(Colors.deepOrange, BlendMode.srcIn),),
    CategoryType.winterize: SvgPicture.asset(AppVectors.winterize, width: 36, colorFilter: const ColorFilter.mode(Colors.cyan, BlendMode.srcIn),),
    CategoryType.sell: SvgPicture.asset(AppVectors.sell, width: 36, colorFilter: const ColorFilter.mode(Colors.indigo, BlendMode.srcIn),),
    CategoryType.buy: SvgPicture.asset(AppVectors.buy, width: 36, colorFilter: const ColorFilter.mode(Colors.purple, BlendMode.srcIn),),
    CategoryType.queen: SvgPicture.asset(AppVectors.queen, width: 36, colorFilter: const ColorFilter.mode(Colors.pink, BlendMode.srcIn),),
    CategoryType.treatment: SvgPicture.asset(AppVectors.treatment, width: 36, colorFilter: const ColorFilter.mode(Colors.red, BlendMode.srcIn),),
    CategoryType.other: SvgPicture.asset(AppVectors.other, width: 36, colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn),),
  };
}
