import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servana/core/app_routes/app_routes.dart';
import 'package:servana/view/components/custom_button/custom_button.dart';
import 'controller/certificate_upload_controller.dart';
import 'widget/custom_certificate_pdf_button.dart';

class CertificateScreen extends StatelessWidget {
  CertificateScreen({super.key});

  final controller = Get.find<CertificateUploadController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2E6F3),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Certificate".tr, style: TextStyle(color: Colors.black)),
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
                  controller.pickNidFile();
                },
                label: "NID".tr,
                title: controller.nidFile.value == null || controller.nidFile.value!.path.isEmpty
                    ? ""
                    : controller.nidFile.value!.path.split("/").last,
              ),

              CustomCertificatePdfButton(
                onTap: () {
                  controller.skillsFile();
                },
                label: "Skills".tr,
                title: controller.skillFile.value == null || controller.skillFile.value!.path.isEmpty
                    ? ""
                    : controller.skillFile.value!.path.split("/").last,
              ),

              CustomCertificatePdfButton(
                onTap: () {
                  controller.otherSFile();
                },
                label: "Other".tr,
                title: controller.otherFile.value == null || controller.otherFile.value!.path.isEmpty
                    ? ""
                    : controller.otherFile.value!.path.split("/").last,
              ),
              Spacer(),
              CustomButton(onTap: (){
                controller.updateContractorData();
              }, title: "Add Certificate".tr,),
              SizedBox(height: 30,),
            ],
          );
        }),
      ),
    );
  }
}
