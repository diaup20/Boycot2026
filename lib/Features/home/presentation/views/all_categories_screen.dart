import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Core/utils/styles.dart';
import '../../../../Core/widgets/custom_circular_progress_indicatorr.dart';
import '../view_model/category_cubit/category_cubit.dart';
import '../view_model/home_cubit/home_cubit.dart';
import 'widgets/custom_category_card.dart';


class AllCategoriesScreen extends StatelessWidget {
  const AllCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('جميع الفئات'), centerTitle: true),
      body: BlocBuilder<CategoryCubit, CategoryState>(
        builder: (ctx, state) {
          if (state is CategoryLoading) {
            return const Center(child: CustomCircularProgressIndicator());
          }
          if (state is CategoryError) {
            return Center(
              child: Text(state.message, style: Styles.textStyle15(context)),
            );
          }
          if (state is CategoryLoaded) {
            final homeCubit = context.read<HomeCubit>();
            final categories = state.categories;

            // جميع الفئات الفرعية التي تريد دمجها مع الرئيسية
            const List<String> subCategoryNames = [
              // الألبان ومشتقاته
              "حليب مجفف اكياس", "الاجبان المثلثة", "حقين", "زبادي",
              "حليب مجفف علب", "البيض",
              // الأرز
              "بسمتي", "مزة", "تايلندي", "بسمتي مزة",
              // الدقيق
              "دقيق أبيض", "دقيق أسمر", "دقيق ذرة",
              // القمح
              "قمح صلب", "قمح لين",
              // السمن النباتي
              "سمن نباتي أصفر", "سمن نباتي أبيض",

              // البقوليات
              "عدس", "فول", "حمص", "فاصوليا", "لوبيا",
              // السكر
              "سكر أبيض", "سكر بني",
              // مشروبات وعصائر
              "عصير برتقال", "عصير تفاح", "مشروبات غازية", "مشروبات طاقة",
              // نشويات وسكريات
              "نشا", "جلوكوز", "مالتوديكسترين",
              // الكترونيات
              "هواتف", "أجهزة لوحية", "حواسيب", "ملحقات إلكترونية",
              // سيارات ومعدات
              "سيارات", "شاحنات", "معدات ثقيلة",
              // التبغ والسجائر
              "سجائر", "معسل", "تبغ",
              // منتجات أطفال
              "حفاظات", "حليب أطفال", "أغذية أطفال",
              // زيوت ومحركات
              "زيت محرك", "زيت فرامل", "زيت ناقل حركة",
              // مكرونة وشعيرية
              "مكرونة", "شعيرية",
              // ماكولات ومطاعم
              "وجبات سريعة", "مطاعم شعبية",
              // قهوة ومشتقاتها
              "قهوة", "نسكافيه", "كابتشينو",
              // العناية بالشعر
              "شامبو", "بلسم", "زيوت شعر",
              // العناية بالبشرة
              "كريمات", "غسول وجه", "مرطبات",
              // المنظفات والمطهرات
              "منظفات أرضيات", "مطهرات", "منظفات صحون",
              // الملابس
              "ملابس رجالية", "ملابس نسائية", "ملابس أطفال",
              // مستحضرات تجميل
              "مكياج", "عطور", "مزيل عرق",
              // مستلزمات صحية
              "كمامات", "مطهرات يد", "شاش طبي",
              // المياه المعدنية
              "مياه معدنية صغيرة", "مياه معدنية كبيرة",
              // البيض
              "بيض أبيض", "بيض أحمر",
              // الصلصة
              "صلصة طماطم", "صلصة حارة",
              // الشاي
              "شاي أخضر", "شاي أسود",
              // زيوت النخيل
              "زيت نخيل خام", "زيت نخيل مكرر",
              // زيوت الطبخ
              "زيت طبخ نباتي", "زيت طبخ حيواني",
              // معلبات التونة
              "تونة خفيفة", "تونة داكنة",
              // منتجات قابلة للدهن
              "جبنة قابلة للدهن", "شوكولاتة قابلة للدهن",
              // الأدوية
              "مسكنات", "مضادات حيوية", "فيتامينات",
              // أجهزة ومعدات طبية
              "جهاز قياس ضغط", "جهاز سكر", "معدات طبية منزلية",
              // الأرز (تكرار للتأكيد)
              "بسمتي", "مزة", "تايلندي", "بسمتي مزة.",
              // الزيوت (تكرار للتأكيد)
              "زيت دوار الشمس", "زيت ذرة", "زيت زيتون", "زيوت النخيل",
              "زيوت الطبخ",
              // الحليب ومشتقاته (تكرار للتأكيد)
              "حليب مجفف اكياس", "الاجبان المثلثة", "حقين", "زبادي",
              "حليب مجفف علب",
            ];

            // استبعد الفئات الفرعية من العرض
            final filteredCats = categories.where((cat) {
              if (subCategoryNames.contains(cat.name)) return false;
              return homeCubit.getProductsByCategory(cat.id).isNotEmpty;
            }).toList();

            if (filteredCats.isEmpty) {
              return  Center(
                child: Text(
                  'لا توجد فئات تحتوي على منتجات',
                   style: Styles.textStyle18(context),
                ),
              );
            }

            return AllCategoriesGrid(categories: filteredCats);
          }
          context.read<CategoryCubit>().loadCategories();
          return const Center(child: CustomCircularProgressIndicator());
        },
      ),
    );
  }
}

class AllCategoriesGrid extends StatelessWidget {
  final List categories;
  const AllCategoriesGrid({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: GridView.builder(
          itemCount: categories.length,
          padding: const EdgeInsets.symmetric(vertical: 16),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 150,
            childAspectRatio: 0.7,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
          ),
          itemBuilder: (ctx, index) {
            final cat = categories[index];
            return CustomCategoryCard(category: cat);
          },
        ),
      ),
    );
  }
}
