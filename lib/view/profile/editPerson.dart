import 'package:flutter/material.dart';
import 'package:lametna/view/chat/appBar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

var EditProfile = [
  {"name": "تعديل خلفيات الاسم"},
  {"name": "اللغة"},
  {"name": "قائمة الحظر"},
];
var Info = [
  {"name": "الشروط والاحكام"},
  {"name": "سياسة الخصوصية"},
  {"name": "سياسة الاسترجاع"},
  {"name": "حقوق الملكية الفكرية"},
  {"name": "معلومات عنا"},
  {"name": "اتصل بنا"},
];

class EditPerson extends StatelessWidget {
  const EditPerson({Key ?key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F1F1),
      appBar: appbarBuilder("تعديل الملف الشخصي", true),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "الإعدادات الشخصية",
                      style: TextStyle(
                        color: const Color(0XffA2ACAC),
                        fontSize: 10.sp,
                        fontFamily: "Portada",
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ],
                ),
              ),
              Container(
                height: 100.h,
                color: Colors.white,
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: GestureDetector(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.h),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 25.0.w, vertical: 3.h),
                            child: Container(
                              width: 68.w,
                              height: 69.h,
                              decoration: BoxDecoration(
                                // color: const Color(0xff7c94b6),
                                image: const DecorationImage(
                                  image: NetworkImage(
                                      "https://www.wilsoncenter.org/sites/default/files/styles/large/public/media/images/person/james-person-1.jpg"),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(400.0.r)),
                              ),
                            ),
                          ),
                          Text(
                            "احمد حسن",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Portada",
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.black,
                              size: 30.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 32.h,
              ),
              Container(
                color: Colors.white,
                child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Directionality(
                        textDirection: TextDirection.rtl,
                        child: GestureDetector(
                          onTap: () {
                            if (index == 0) {
                              Get.toNamed('/editBackground', arguments: {});
                            } else if (index == 1) {}
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 18.h),
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 60.0.w, vertical: 3.h),
                                  child: Text(
                                    EditProfile[index]["name"] as String,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Portada",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(
                          color: Color(0xffF1F1F1),
                          thickness: 1,
                        ),
                    itemCount: EditProfile.length),
              ),
              SizedBox(
                height: 60.h,
              ),
              Container(
                color: Colors.white,
                child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Directionality(
                        textDirection: TextDirection.rtl,
                        child: GestureDetector(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20.0.w, vertical: 3.h),
                                  child: Text(
                                    Info[index]["name"] as String,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Portada",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(
                          color: Color(0xffF1F1F1),
                          thickness: 1,
                        ),
                    itemCount: Info.length),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
