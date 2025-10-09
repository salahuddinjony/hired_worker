import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/utils/app_colors/app_colors.dart';
import 'package:servana/view/screens/contractor_part/complete_your_profile/controller/add_material_controller.dart';
import 'package:servana/view/screens/contractor_part/profile/controller/profile_controller.dart';
import '../../../../components/custom_royel_appbar/custom_royel_appbar.dart';

class MaterialsScreen extends StatefulWidget {
  const MaterialsScreen({super.key});

  @override
  MaterialsScreenState createState() => MaterialsScreenState();
}

class MaterialsScreenState extends State<MaterialsScreen> {
  final ProfileController profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Materials"),
      body: Obx(() {
        final materialList = profileController.contractorModel.value.data?.contractor?.materials ?? [];

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              // List
              if (materialList.isNotEmpty)
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: materialList.length,
                    itemBuilder: (context, index) {
                      final item = materialList[index];
                      final name = item.name ?? "";
                      final unit = item.unit?.toString() ?? "";
                      final price = item.price?.toString() ?? "0";
                      final id = item.id?.toString() ?? "";

                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 6.h,
                        ),
                        margin: EdgeInsets.only(bottom: 8.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.r),
                          border: Border.all(color: Colors.black12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    name,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 2.h),
                                  if (unit.isNotEmpty)
                                    Text(
                                      unit,
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  SizedBox(height: 4.h),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 6.w,
                                      vertical: 2.h,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4.r),
                                      color: AppColors.primary.withValues(alpha: .3),
                                    ),
                                    child: Text(
                                      "\$$price",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                IconButton(
                                  tooltip: "Edit",
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    // Print material with id when update button is pressed
                                    debugPrint('Material with id: $id');
                                    _showMaterialDialog(item: item, index: index);
                                  },
                                ),
                                IconButton(
                                  tooltip: "Delete",
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    _showDeleteConfirmation(index, id);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                )
              else
                Padding(
                  padding: EdgeInsets.all(20.h),
                  child: Text(
                    "No materials found. Please add some.",
                    style: TextStyle(fontSize: 14.sp, color: Colors.black54),
                  ),
                ),

              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.zero,
                    padding: EdgeInsets.symmetric(
                      vertical: 6.h,
                      horizontal: 18.w,
                    ),
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                  ),
                  onPressed: () {
                    // Print when add button is pressed
                    debugPrint('Add material button pressed');
                    _showMaterialDialog();
                  },
                  child: Text(
                    "+ Add",
                    style: TextStyle(color: AppColors.white, fontSize: 14.sp),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  void _showMaterialDialog({dynamic item, int? index}) {
    final isEdit = item != null;
    final TextEditingController nameController = TextEditingController(
      text: isEdit ? (item.name ?? "") : "",
    );
    final TextEditingController unitController = TextEditingController(
      text: isEdit ? (item.unit?.toString() ?? "") : "",
    );
    final TextEditingController priceController = TextEditingController(
      text: isEdit ? (item.price?.toString() ?? "") : "",
    );

    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      isEdit ? "Edit Materials" : "Add Materials",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.cancel, color: Colors.red),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                SizedBox(height: 15.h),

                Text(
                  'Materials Name',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 15.sp,
                  ),
                ),

                SizedBox(height: 4.h),

                // Name
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: "Write here",
                    border: const OutlineInputBorder(),
                    hintStyle: TextStyle(fontSize: 15.sp),
                  ),
                ),
                SizedBox(height: 12.h),

                Text(
                  'Materials Unit (Optional)',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 15.sp,
                  ),
                ),

                SizedBox(height: 4.h),

                // Unit
                TextField(
                  controller: unitController,
                  decoration: InputDecoration(
                    hintText: "Ex: Square feet, ML, Piece",
                    hintStyle: TextStyle(fontSize: 15.sp),
                    border: const OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 12.h),

                Text(
                  'Price \$',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 15.sp,
                  ),
                ),

                SizedBox(height: 4.h),
                // Price
                TextField(
                  controller: priceController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: InputDecoration(
                    hintText: "Enter price here",
                    hintStyle: TextStyle(fontSize: 15.sp),
                    border: const OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20.h),

                // Save / Update
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text(
                      isEdit ? "Update" : "Save",
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 14.sp,
                      ),
                    ),
                    onPressed: () {
                      final name = nameController.text.trim();
                      final unit = unitController.text.trim();
                      final price = priceController.text.trim();

                      if (name.isEmpty || price.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Name and Price are required."),
                          ),
                        );
                        return;
                      }

                      if (isEdit) {
                        // Here you would typically call your API to update the material
                        debugPrint('Update material with id: ${item.id}');
                        debugPrint('Updated material - Name: $name, Unit: $unit, Price: $price');
                        Get.find<MaterialController>().updateMaterial(name, unit, double.parse(price), item.id);

                      } else {
                        // Here you would typically call your API to add new material
                        debugPrint('Add new material - Name: $name, Unit: $unit, Price: $price');
                        Get.find<MaterialController>().addMaterial(name, unit, double.parse(price));
                      }
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showDeleteConfirmation(int index, String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Delete Material"),
        content: Text("Are you sure you want to delete this material?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              // Here you would typically call your API to delete the material
              debugPrint('Deleted material with id: $id');
              Get.find<MaterialController>().deleteMaterial(id);
              Navigator.pop(context);
            },
            child: Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}