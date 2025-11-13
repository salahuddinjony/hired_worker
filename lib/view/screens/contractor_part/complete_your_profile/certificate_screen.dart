import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servana/view/components/custom_button/custom_button.dart';
import '../../../components/custom_loader/custom_loader.dart';
import 'controller/certificate_upload_controller.dart';
import 'widget/custom_certificate_pdf_button.dart';

class CertificateScreen extends StatelessWidget {
  CertificateScreen({super.key});

  final controller = Get.find<CertificateUploadController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2E6F3),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Certificate".tr,
          style: const TextStyle(color: Colors.black),
        ),
        leading: const BackButton(color: Colors.black),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Obx(() {
          return Column(
            children: [
              CustomCertificatePdfButton(
                onTap: () {
                  controller.pickCertificate();
                },
                label: "Certificate".tr,
                title:
                    controller.certificate.value == null ||
                            controller.certificate.value!.path.isEmpty
                        ? ""
                        : controller.certificate.value!.path.split("/").last,
              ),

              CustomCertificatePdfButton(
                onTap: () {
                  controller.pickSkillFile();
                },
                label: "Skills".tr,
                title:
                    controller.skillFile.value == null ||
                            controller.skillFile.value!.path.isEmpty
                        ? ""
                        : controller.skillFile.value!.path.split("/").last,
              ),

              CustomCertificatePdfButton(
                onTap: () {
                  controller.pickOtherFile();
                },
                label: "Other".tr,
                title:
                    controller.otherFile.value == null ||
                            controller.otherFile.value!.path.isEmpty
                        ? ""
                        : controller.otherFile.value!.path.split("/").last,
              ),
              const Spacer(),
              Obx(() {
                return controller.status.value.isLoading
                    ? const CustomLoader()
                    : CustomButton(
                      onTap: () {
                        controller.uploadAllFiles();
                      },
                      title: "Add Certificate".tr,
                    );
              }),
              const SizedBox(height: 30),
            ],
          );
        }),
      ),
    );
  }
}
