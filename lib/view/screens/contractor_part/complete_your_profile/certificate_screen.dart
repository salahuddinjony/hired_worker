import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:servana/core/app_routes/app_routes.dart';
import 'package:servana/view/components/custom_button/custom_button.dart';
import 'controller/complete_profile_controller.dart';
import 'widget/custom_certificate_pdf_button.dart';

class CertificateScreen extends StatelessWidget {
  CertificateScreen({super.key});

  final completeProfileController = Get.find<CompleteProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2E6F3),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Certificate", style: TextStyle(color: Colors.black)),
        leading: BackButton(color: Colors.black),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Obx(() {
          return Column(
            children: [
              CustomCertificatePdfButton(
                onTap: () {
                  completeProfileController.pickNidFile();
                },
                label: "NID",
                title: completeProfileController.nidFile.value == null || completeProfileController.nidFile.value!.path.isEmpty
                        ? ""
                        : completeProfileController.nidFile.value!.path.split("/").last,
              ),
              CustomCertificatePdfButton(
                onTap: () {
                  completeProfileController.skillsFile();
                },
                label: "Skills",
                title: completeProfileController.nidFile.value == null || completeProfileController.nidFile.value!.path.isEmpty
                    ? ""
                    : completeProfileController.nidFile.value!.path.split("/").last,
              ),
              CustomCertificatePdfButton(
                onTap: () {
                  completeProfileController.otherSFile();
                },
                label: "Other",
                title: completeProfileController.nidFile.value == null || completeProfileController.nidFile.value!.path.isEmpty
                    ? ""
                    : completeProfileController.nidFile.value!.path.split("/").last,
              ),
              Spacer(),
              CustomButton(onTap: (){
                Get.toNamed(AppRoutes.skillsAddScreen);
              }, title: "Add Certificate",),
              SizedBox(height: 30,),
            ],
          );
        }),
      ),
    );
  }
}
