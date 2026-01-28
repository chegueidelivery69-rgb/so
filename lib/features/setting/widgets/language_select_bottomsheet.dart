import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motoboy/common_widgets/button_widget.dart';
import 'package:motoboy/localization/localization_controller.dart';
import 'package:motoboy/util/app_constants.dart';
import 'package:motoboy/util/dimensions.dart';
import 'package:motoboy/util/images.dart';
import 'package:motoboy/util/styles.dart';

class LanguageSelectBottomSheet extends StatelessWidget {
  const LanguageSelectBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocalizationController>(builder: (localizationController){
      return PopScope(onPopInvokedWithResult: (didPop, val){
        localizationController.setInitialIndex();
      },
        child: SafeArea(
          top: false,
          child: SingleChildScrollView(
            child: Container(width: double.infinity,padding: const EdgeInsets.all(Dimensions.paddingSizeExtraLarge),
              child: Column(children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  const SizedBox(),

                  Padding(
                    padding: const EdgeInsets.only(left: Dimensions.paddingSizeLarge),
                    child: Image.asset(Images.smallIcon,height: 10,width: 40 ),
                  ),

                  InkWell(
                    onTap: ()=> Get.back(),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).hintColor.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),

                      child: Image.asset(Images.crossIcon,height: 10,width: 10),
                    ),
                  ),
                ]),
                const SizedBox(height: Dimensions.paddingSizeExtraSmall),

                Text('idioma_atual'.tr,style: textBold.copyWith(fontSize: Dimensions.fontSizeLarge),),

                const SizedBox(height: Dimensions.paddingSizeSmall,),
                Text('portugues_brasil'.tr,style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault)),

                const SizedBox(height: Dimensions.paddingSizeLarge),
                
                Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withValues(alpha:0.05),
                      borderRadius: BorderRadius.circular(Dimensions.radiusLarge),
                      border: Border.all(width: 0.5,color: Theme.of(context).primaryColor.withValues(alpha: 0.2))
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(children: [
                      Image.asset(AppConstants.languages[0].imageUrl,height: 26,width: 26,),
                      const SizedBox(width:Dimensions.paddingSizeExtraSmall),

                      Text(
                        '${AppConstants.languages[0].countryCode} (${AppConstants.languages[0].languageName})',
                        style: textSemiBold.copyWith(fontSize: Dimensions.fontSizeDefault),
                      ),
                    ]),
                  ),
                ),
                const SizedBox(height: Dimensions.paddingSizeDefault),

                ButtonWidget(
                  buttonText: 'ok'.tr,
                  backgroundColor: Theme.of(context).primaryColor,
                  onPressed: (){
                    Get.back();
                  },
                )
              ]),
            ),
          ),
        ),
      );
    });
  }
}
