import 'package:find_worker/utils/app_colors.dart';
import 'package:find_worker/utils/app_icons.dart';
import 'package:find_worker/view/widgets/buttons/custom_button.dart';
import 'package:find_worker/view/widgets/image/custom_image.dart';
import 'package:find_worker/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserServiceDetailsHireNoeBottomModal extends StatefulWidget {
  const UserServiceDetailsHireNoeBottomModal({super.key});

  @override
  State<UserServiceDetailsHireNoeBottomModal> createState() =>
      _UserServiceDetailsHireNoeBottomModalState();
}

class _UserServiceDetailsHireNoeBottomModalState
    extends State<UserServiceDetailsHireNoeBottomModal> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 254,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(20),
      decoration: const ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: Color(0xFF0668E3)),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
      ),
      child: Column(
        children: [
          const CustomText(
            text: 'Approved!',
            fontSize: 18,
            fontWeight: FontWeight.w500,
            bottom: 16,
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image:
                              AssetImage('assets/images/profile_smith.png'))),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                    child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: 'John Doe',
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                        Row(
                          children: [
                            CustomImage(
                              imageSrc: AppIcons.star,
                              size: 12,
                            ),
                            CustomText(
                              text: '(4.5)',
                              fontWeight: FontWeight.w500,
                              left: 4,
                            ),
                          ],
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: 'Service'.tr,
                          color: AppColors.black_60,
                        ),
                        CustomText(
                          text: 'Car Wash'.tr,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ],
                ))
              ],
            ),
          ),
          SizedBox(height: 24,),
          CustomButton(
            onPressed: () {
              Navigator.pop(context);
            },
            titleText: 'Call'.tr,
            buttonWidth: MediaQuery.of(context).size.width,
            buttonBgColor: AppColors.blue_100,
          ),
        ],
      ),
    );
  }
}
