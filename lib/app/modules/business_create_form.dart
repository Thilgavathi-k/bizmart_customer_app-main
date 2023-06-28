import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:bizmart/app/models/business_details_get_api/all_plans_get_api.dart';
import 'package:bizmart/app/models/business_details_get_api/payment_methods_get_api.dart';

import 'package:bizmart/app/modules/payment_now_page.dart';


import 'package:bizmart/app/models/busines_details_save_api/address_save_api.dart';
import 'package:bizmart/app/models/busines_details_save_api/business_details_save.dart';
import 'package:bizmart/app/models/busines_details_save_api/business_service_api.dart';
import 'package:bizmart/app/models/busines_details_save_api/gst_details_sace_api.dart';
import 'package:bizmart/app/models/busines_details_save_api/kyc_details_svae_api.dart';
import 'package:bizmart/app/models/busines_details_save_api/promote_now_save_api.dart';
import 'package:bizmart/app/models/busines_details_save_api/social_media_link_save_api.dart';
import 'package:bizmart/app/models/business_details_get_api/all_categories_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:video_player/video_player.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';


//import 'Contact.dart';
class BusinessDetailsData extends StatefulWidget {
  final List cat_list;
  final String sid;

  const BusinessDetailsData({Key key, this.cat_list, this.sid,}) : super(key: key);

  @override
  State<BusinessDetailsData> createState() => _BusinessDetailsDataState();
}

class _BusinessDetailsDataState extends State<BusinessDetailsData> {

  VideoPlayerController _videoPlayerController;
  VideoPlayerController PlayerController;
  bool select = false;
  bool selectone = false;
  bool selecttwo = false;
  bool selectseven = false;
  bool selectthree = false;
  bool selectfour = false;
  bool selectfive = false;
  bool isLoaders = false;
  var currentIndex = 1;
  var cat_id;
  String cert;
  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  String address = "";
  String fileName;
  File file;
  String promote;
  String benefits;
  dynamic decodedImage;
  dynamic imageSize;
  bool pan_image = false;
  bool driving_license = false;
  bool passport = false;
  bool llp_number = false;
  bool company_licence = false;
  bool liquor_license = false;
  bool trade_license = false;
  var onChange;
  bool other_document = false;
  bool fssai = false;
  bool _passport = false;
  String dropdownValue;

  String dropdownCate = '';
  var select_id;
  var callAPi;
  var allPlans;

  //String countryValue;
  //String stateValue;
  // String cityValue;
  @override
  File ProjectImage;

  File ServiceImageupload;
  File imageFile;
  File imageGile;
  TextEditingController _datecontroller = new TextEditingController();
  String _chosenvalue;
  String _chosenvalue1;
  String choose;
  String choosecity;
  String choosenational;
  String chooseexperience;
  String choosecareer;
  String chooseindustry;
  String choosefunctional;
  String chooseskill;
  String Skill;
  String chooselangu;
  String chooselangulevel;
  String langulevel;
  String langu;
  String value = "Select State";
  String value1 = "Marital Status";
  String state = "State";
  String city;
  String national;
  String experience;
  String Career;
  String industry;
  String functional;
  bool valuefirst = false;
  bool valuesecond = false;
  bool _value = false;
  int val = -1;
  var selected;
  bool isLoaderone = false;
  bool isLoadertwo = false;
  bool isLoaderthree = false;
  bool isLoaderfour = false;
  bool isLoaderfive = false;
  bool isLoadersix = false;

  //+++++++++++++++++++++++++TEXTEDITING CONTROLLER FOR ADDRESSS+++++++++++++++++++++++++++++++++++++++++
  TextEditingController company_name = TextEditingController();
  TextEditingController addresss = TextEditingController();
  TextEditingController district = TextEditingController();
  TextEditingController city_name = TextEditingController();
  TextEditingController pincode = TextEditingController();
  TextEditingController landmark = TextEditingController();
  TextEditingController mobile_number = TextEditingController();

  //++++++++++++++++++++++++TEXTEDITING CONTROLLER FOR BUSINESS DETAILS++++++++++++++++++++++++++++++++++
  TextEditingController establish = TextEditingController();
  TextEditingController payment_method = TextEditingController();
  TextEditingController website = TextEditingController();
  TextEditingController add_awards = TextEditingController();

  //++++++++++++++++++++++++TEXTEDITING CONTROLLER FOR Service DETAILS++++++++++++++++++++++++++++++++++

  TextEditingController service_name = TextEditingController();
  TextEditingController service_price = TextEditingController();
  TextEditingController discount_service_price = TextEditingController();
  TextEditingController service_unit = TextEditingController();
  TextEditingController service_desc = TextEditingController();
  TextEditingController service_duration = TextEditingController();
  TextEditingController service_cat = TextEditingController();
  TextEditingController eservice_name = TextEditingController();
  TextEditingController eservice_price = TextEditingController();
  TextEditingController ediscount_service_price = TextEditingController();
  TextEditingController eservice_unit = TextEditingController();
  TextEditingController eservice_desc = TextEditingController();
  TextEditingController eservice_duration = TextEditingController();
  TextEditingController eservice_cat = TextEditingController();

  //+++++++++++++++++++++++++++++++++++IMAGE FILE FOR BUSINESS DETAILS+++++++++++++++++++++++++++++++++++++
  File Imageupload;
  File videoupload;
  PlatformFile file1;
  String plan;

  //++++++++++++++++++++++++++++++++++TEXTEDITING CONTROLLER FORSOCIALMEDIA LINK+++++++++++++++++++++++++++++++++++++++++++++++++++++
  TextEditingController facebook = TextEditingController();
  TextEditingController instagram = TextEditingController();
  TextEditingController twitter = TextEditingController();
  TextEditingController youtube = TextEditingController();
  TextEditingController linkedin = TextEditingController();
  TextEditingController yahoo = TextEditingController();

  //++++++++++++++++++++++++++++++++++TEXTEDITING CONTROLLER FORSOCIALMEDIA LINK+++++++++++++++++++++++++++++++++++++++++++++++++++++
  TextEditingController register_gstn = TextEditingController();
  TextEditingController register_under_gst = TextEditingController();
  TextEditingController register_pincode = TextEditingController();
  TextEditingController gstno = TextEditingController();
  TextEditingController pan_umber = TextEditingController();


  String Images;
  final ImagePicker imagePicker = ImagePicker();

  List<XFile> imageFileList = [];
  String companyName;
  String addressDetails;
  String districtName;
  String cityName;
  String landmarkName;
  String pinCode;
  String mobileNumber;
  String est;
  String payment;
  String web;
  String awards;
  String cert_file;
  String img;
  String video;
  bool select_drop = false;
  String pan_img;
  String drive_img;
  String llp_img;
  String fssai_img;
  String passport_img;
  String compantylic_img;
  String liq_img;
  String trade_img;
  String other_docu_img;
  String promote_data;
  String benefits_data;
  String unit_price;
  String plan_price;
  String plan_duration;
  int nums;
  int ctxx;
  int selt;
  String imagess;
  bool showPassword = true;
  bool showConfirmPassword = true;

  String id;
  int tap;
  bool isLoader = false;
  String s_name;
  String payment_key;
  List dataList = [
    {'id': 5, 'title': 'leakage'},
    {'id': 6, 'title': 'quality issue'},
    {'id': 6, 'title': 'less quantity'}
  ];
  String selectedValue;
  List _testList = [
    {'no': 1, 'keyword': 'blue'},
    {'no': 2, 'keyword': 'black'},
    {'no': 3, 'keyword': 'red'}
  ];
  List<DropdownMenuItem> _dropdownTestItems ;
  var _selectedTest;
  var _selectedCatId;
  var categories;
  var endDate;

  var cat_length;
  Razorpay _razorpay;
  String razar_key;
  var plan_status;

  List<DropdownMenuItem> items = [];

  //validationvariable

  bool serviceName = false;
  bool servicePrice = false;
  bool serviceImg = false;
  bool selectCat = false;
  bool mobileNumberValid = false;
  bool companyNameValid = false;
  bool companyAddress = false;
  bool companyPancard = false;
  bool companyDistrict = false;
  bool companyCity = false;
  bool companyPincode = false;
  bool companyLandmark = false;
  bool companyMoibileNumber = false;


  @override
  void initState() {
    super.initState();

    _videoPlayerController = VideoPlayerController.asset('assets/Butterfly-209.mp4');
    print(
        "+++++++++++++++++++++++++++++++++++++++VIDEO PLAYER+++++++++++++++++++++++++++++++");
    print(widget.cat_list);
    print("__________________________END_____________________________");
    print(PlayerController);
    print(video);
    print("++++++++++++++++++++++++++++++++++++++++++++++++");
    _videoPlayerController.addListener(() {
      setState(() {

      });
    });
    setState(() {
      callAPi = AllCategories().AllCategoriesData();
      allPlans = AllPlans().AllPlansData();

    });
    _videoPlayerController.setLooping(false);
    _videoPlayerController.initialize().then((_) => setState(() {}));
    _videoPlayerController.pause();
    // AllPlans().AllPlansData();

    PaymentList().PaymentListData().then((val) {
      setState(() {
        print(
            "++++++++++++++++++++++++++++++PROMOTE DATA++++++++++++++++++++++++++++++++++++++");
        //var pay = val['data'];
        payment_key = val['data'][0]['route'].toString();
        print("+++++++++++++++++++++PAY MENT START+++++++++++++++++++++++++++");
        print(payment_key);
        print("+++++++++++++++++++++PAY MENT END+++++++++++++++++++++++++++");
      });
    }
    );
    AllCategories().AllCategoriesData().then((val) {
      //int i;
      setState(() {
        print(
            "__________________________ALL CATEGORY START____________________");
        categories = val['data'];
        cat_length = val['data'].length;
        print(categories);
        print(categories.length);
        print(cat_length);


      });
    }
    );


    setState(() {
      _dropdownTestItems = buildDropdownTestItems(widget.cat_list);
      print("DRODOWN LIST");
      print(widget.cat_list);
      print(_dropdownTestItems);
    });
  }

  List<DropdownMenuItem> buildDropdownTestItems(List data_lists) {
    for (var i = 0; i < data_lists.length; i++) {
      items.add(
        DropdownMenuItem(
          value: data_lists[i]['id'],
          child: Text(data_lists[i]['name']['en'].toString()),
        ),
      );

    }

    return items;
  }

  onChangeDropdownTests(selectedTest) {
    print('on changes sdsdsd');
    print(selectedTest);
    setState(() {
      select_drop = true;
      selectCat = false;
      // tap = 1;
      _selectedTest = selectedTest;
      _selectedCatId = selectedTest;
      cat_id = selectedTest;
      print(cat_id);
      print(selectedTest);

    });
  }



  void dispose() {
    _razorpay.clear();
    _videoPlayerController.dispose();
    PlayerController.dispose();
    super.dispose();
  }
  void selectImages() async {
    final List<XFile> selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages.isNotEmpty) {
      imageFileList.addAll(selectedImages);
    }
    setState(() {
    });
  }
  void openFile(PlatformFile file) {OpenFile.open(file.path);}

  @override
  String mobile;
  String email;
  File Pan;
  File driving;
  File passport_file;
  File llp;
  File company;
  File Fssai;
  File liquir;
  File trade;
  File documnet;
  int num ;
  String plan_id;
  String plan_desc;
  SelctOne(bool val)
  {
    if(val == false)
    {
      return InkWell(
        onTap: ()
        {
          select = true;
          setState(() {
            print("selct");
            print(select);
            select = true;
            currentIndex = 2;
            print(select);
            SelctOne(select);
          });
        },
        child: Container(
          height: 40,
          width: 45,
          decoration: BoxDecoration(
            border: Border.all(
              color: Get.theme.colorScheme.secondary,

            ),
            borderRadius: BorderRadius.circular(100),

          ),
          child: Center(child: Image.asset('assets/img/step.png',height: 30,width: 30,)
            // Text("1",style: TextStyle(color:Get.theme.colorScheme.secondary,),)
          ),

        ),
      );

    }
    else
    {
      return  InkWell(
        onTap: ()
        {
          setState(() {
            currentIndex = 2;

          });
        },
        child: Container(
          height: 40,
          width: 45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Get.theme.colorScheme.secondary,
          ),
          child: Center(
              child: Icon(Icons.check,color: Colors.white,)
          ),

        ),
      );
    }

  }
  SelctTwo(bool val)
  {
    if(val == false)
    {
      return InkWell(
        onTap: ()
        {
          selectone = true;
          setState(() {
            print("selct");
            print(select);
            selectone = true;
            currentIndex =3;
            print(select);
            SelctOne(select);
          });
        },
        child: Container(
          height: 40,
          width: 45,
          decoration: BoxDecoration(
            border: Border.all(
              color: Get.theme.colorScheme.secondary,

            ),
            borderRadius: BorderRadius.circular(100),

          ),
          child: Center(child:Image.asset('assets/img/business Details.png',height: 30,width: 30,)),

        ),
      );

    }
    else
    {
      return  InkWell(
        onTap: ()
        {
          setState(() {
            currentIndex = 3;

          });
        },
        child: Container(
          height: 40,
          width: 45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Get.theme.colorScheme.secondary,
          ),
          child: Center(child: Icon(Icons.check,color: Colors.white,)),

        ),
      );
    }

  }
  SelctThree(bool val)
  {
    if(val == false)
    {
      return InkWell(
        onTap: ()
        {
          selecttwo = true;
          setState(() {
            print("selct");
            print(select);
            currentIndex = 4;
            selecttwo = true;
            print(select);
            SelctOne(select);
          });
        },
        child: Container(
          height: 40,
          width: 45,
          //  padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(
              color: Get.theme.colorScheme.secondary,

            ),
            borderRadius: BorderRadius.circular(100),

          ),
          child: Center(child:Image.asset('assets/img/Social media link.png',height: 30,width: 30,)),

        ),
      );

    }
    else
    {
      return  InkWell(
        onTap: ()
        {
          setState(() {
            currentIndex = 4;

          });
        },
        child: Container(
          height: 40,
          width: 45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Get.theme.colorScheme.secondary,
          ),
          child: Center(child: Icon(Icons.check,color: Colors.white,)),

        ),
      );
    }

  }
  SelctFour(bool val)
  {
    if(val == false)
    {
      return InkWell(
        onTap: ()
        {
          selectthree = true;
          setState(() {
            print("selct");
            print(select);
            selectthree = true;
            currentIndex =5;
            print(select);
            SelctOne(select);
          });
        },
        child: Container(
          height: 40,
          width: 45,
          decoration: BoxDecoration(
            border: Border.all(
              color: Get.theme.colorScheme.secondary,

            ),
            borderRadius: BorderRadius.circular(100),

          ),
          child: Center(child:Image.asset('assets/img/GST.png',height: 30,width: 30,)),

        ),
      );

    }
    else
    {
      return  InkWell(
        onTap: ()
        {
          setState(() {
            currentIndex = 5;

          });
        },
        child: Container(
          height: 40,
          width: 45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Get.theme.colorScheme.secondary,
          ),
          child: Center(child: Icon(Icons.check,color: Colors.white,)),

        ),
      );
    }

  }
  SelctFive(bool val)

  {
    if(val == false)
    {
      return InkWell(
        onTap: ()
        {
          selectfour = true;
          setState(() {
            print("selct");
            print(select);
            selectfour = true;
            currentIndex = 6;
            print(select);
            SelctOne(select);
          });
        },
        child: Container(
          height: 40,
          width: 45,
          decoration: BoxDecoration(
            border: Border.all(
              color: Get.theme.colorScheme.secondary,

            ),
            borderRadius: BorderRadius.circular(100),

          ),
          child: Center(child:Image.asset('assets/img/KYC.png',height: 30,width: 30,)),

        ),
      );

    }
    else
    {
      return  InkWell(
        onTap: ()
        {
          setState(() {
            currentIndex = 6;

          });
        },

        child: Container(
          height: 40,
          width: 45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Get.theme.colorScheme.secondary,
          ),
          child: Center(child: Icon(Icons.check,color: Colors.white,)),

        ),
      );
    }

  }
  SelctSix(bool val)
  {
    if(val == false)
    {
      return InkWell(
        onTap: ()
        {
          selectfive = true;
          setState(() {
            print("selct");
            print(select);
            selectfive = true;
            currentIndex = 7;
            print(select);
            SelctOne(select);
          });
        },
        child: Container(
          height: 40,
          width: 45,
          decoration: BoxDecoration(
            border: Border.all(
              color: Get.theme.colorScheme.secondary,

            ),
            borderRadius: BorderRadius.circular(100),

          ),
          child: Center(child:Image.asset('assets/img/report.png',height: 30,width: 30,)),

        ),
      );

    }
    else
    {
      return  InkWell(
        onTap: ()
        {
          setState(() {
            currentIndex = 7;

          });
        },

        child: Container(
          height: 40,
          width: 45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Get.theme.colorScheme.secondary,
          ),
          child: Center(child: Icon(Icons.check,color: Colors.white,)),

        ),
      );
    }

  }
  SelctSeven(bool val)
  {
    if(val == false)
    {
      return InkWell(
        onTap: ()
        {
          selectseven = true;
          setState(() {
            print("selct");
            print(select);
            selectseven = true;
            currentIndex = 1;
            print(select);
            SelctSeven(select);
          });
        },
        child: Container(
          height: 40,
          width: 45,
          decoration: BoxDecoration(
            border: Border.all(
              color: Get.theme.colorScheme.secondary,

            ),
            borderRadius: BorderRadius.circular(100),

          ),
          child: Center(child:Image.asset('assets/img/report.png',height: 30,width: 30,)),

        ),
      );

    }
    else
    {
      return  InkWell(
        onTap: ()
        {
          setState(() {
            currentIndex = 1;

          });
        },

        child: Container(
          height: 40,
          width: 45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Get.theme.colorScheme.secondary,
          ),
          child: Center(child: Icon(Icons.check,color: Colors.white,)),

        ),
      );
    }

  }
  //++++++++++++++++++++++++++++++++++Image and video+++++++++++++++++++++++++++++++++++++++++
  void Service_image()

  {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          elevation: 16,
          child: Padding(
            padding:  EdgeInsets.all(8.0),
            child: Container(
              height: 200,
              child: Column(
                children: [
                  Padding(
                    padding:  EdgeInsets.all(0.0),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // SizedBox(width: 20,),
                          Text('Get Image', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),),
                          IconButton(
                            icon: Icon(Icons.close, color: Colors.grey,),
                            onPressed: (){
                              Navigator.pop(context);
                            },

                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(thickness: 1,),
                  Container(
                      height: 40,
                      width: 360,

                      child:  InkWell(
                          onTap:_getFromGallery2,

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [


                              Text('Gallery',style: TextStyle(color: Colors.black, fontSize: 14)),

                              Icon(FontAwesomeIcons. image, color:Colors.grey),

                            ],
                          )

                      )

                  ),
                  Divider(
                    thickness: 4, // thickness of the line
                    indent: 10, // empty space to the leading edge of divider.
                    endIndent: 10, // empty space to the trailing edge of the divider.
                    color: Colors.grey[200], // The color to use when painting the line.
                    height: 20, // The divider's height extent.
                  ),
                  Container(
                    //height: 40,
                      width: 360,
                      child: InkWell(
                          onTap: _getFromCamera2,
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Text('Camera',style: TextStyle(color: Colors.black, fontSize: 14)),

                              Icon(FontAwesomeIcons.camera, color:Colors.grey,),

                            ],
                          )

                      )

                  ),




                ],
              ),

            ),
          ),
        );
      },
    );
  }
  void ForProfile()

  {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          elevation: 16,
          child: Padding(
            padding:  EdgeInsets.all(8.0),
            child: Container(
              height: 200,
              child: Column(
                children: [
                  Padding(
                    padding:  EdgeInsets.all(0.0),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // SizedBox(width: 20,),
                          Text('Get Image', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),),
                          IconButton(
                            icon: Icon(Icons.close, color: Colors.grey,),
                            onPressed: (){
                              Navigator.pop(context);
                            },

                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(thickness: 1,),
                  Container(
                      height: 40,
                      width: 360,

                      child:  InkWell(
                          onTap:_getFromGallery,

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [


                              Text('Gallery',style: TextStyle(color: Colors.black, fontSize: 14)),

                              Icon(FontAwesomeIcons. image, color:Colors.grey),

                            ],
                          )

                      )

                  ),
                  Divider(
                    thickness: 4, // thickness of the line
                    indent: 10, // empty space to the leading edge of divider.
                    endIndent: 10, // empty space to the trailing edge of the divider.
                    color: Colors.grey[200], // The color to use when painting the line.
                    height: 20, // The divider's height extent.
                  ),
                  Container(
                    //height: 40,
                      width: 360,
                      child: InkWell(
                          onTap: _getFromCamera,
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Text('Camera',style: TextStyle(color: Colors.black, fontSize: 14)),

                              Icon(FontAwesomeIcons.camera, color:Colors.grey,),

                            ],
                          )

                      )

                  ),




                ],
              ),

            ),
          ),
        );
      },
    );
  }
  void ForVideoUpload()

  {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          elevation: 16,
          child: Padding(
            padding:  EdgeInsets.all(8.0),
            child: Container(
              height: 130,
              child: Column(
                children: [
                  Padding(
                    padding:  EdgeInsets.all(0.0),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // SizedBox(width: 20,),
                          Text('Get Image', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),),
                          IconButton(
                            icon: Icon(Icons.close, color: Colors.grey,),
                            onPressed: (){
                              Navigator.pop(context);
                            },

                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(thickness: 1,),
                  Container(
                      height: 40,
                      width: 360,

                      child:  InkWell(
                          onTap:_getFromGalleryForvideo,

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [


                              Text('Gallery',style: TextStyle(color: Colors.black, fontSize: 14)),

                              Icon(FontAwesomeIcons. image, color:Colors.grey),

                            ],
                          )

                      )

                  ),
                  // Divider(
                  //   thickness: 4, // thickness of the line
                  //   indent: 10, // empty space to the leading edge of divider.
                  //   endIndent: 10, // empty space to the trailing edge of the divider.
                  //   color: Colors.grey[200], // The color to use when painting the line.
                  //   height: 20, // The divider's height extent.
                  // ),
                  // Container(
                  //   //height: 40,
                  //     width: 360,
                  //     child: InkWell(
                  //         onTap: _getFromCameraForvideo,
                  //         child:  Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: [
                  //
                  //             Text('Camera',style: TextStyle(color: Colors.black, fontSize: 14)),
                  //
                  //             Icon(FontAwesomeIcons.camera, color:Colors.grey,),
                  //
                  //           ],
                  //         )
                  //
                  //     )
                  //
                  // ),
                  //



                ],
              ),

            ),
          ),
        );
      },
    );
  }

  //++++++++++++++++++++++++++++++++++For PAN+++++++++++++++++++++++++++++++++++++++++

  void ForPan()
  {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          elevation: 16,
          child: Padding(
            padding:  EdgeInsets.all(8.0),
            child: Container(
              height: 200,
              child: Column(
                children: [
                  Padding(
                    padding:  EdgeInsets.all(0.0),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // SizedBox(width: 20,),
                          Text('Get Image', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),),
                          IconButton(
                            icon: Icon(Icons.close, color: Colors.grey,),
                            onPressed: (){
                              Navigator.pop(context);
                            },

                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(thickness: 1,),
                  Container(
                      height: 40,
                      width: 360,

                      child:  InkWell(
                          onTap:kycimagesFromGallery,

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [


                              Text('Gallery',style: TextStyle(color: Colors.black, fontSize: 14)),

                              Icon(FontAwesomeIcons. image, color:Colors.grey),

                            ],
                          )

                      )

                  ),
                  Divider(
                    thickness: 4, // thickness of the line
                    indent: 10, // empty space to the leading edge of divider.
                    endIndent: 10, // empty space to the trailing edge of the divider.
                    color: Colors.grey[200], // The color to use when painting the line.
                    height: 20, // The divider's height extent.
                  ),
                  Container(
                    //height: 40,
                      width: 360,
                      child: InkWell(
                          onTap: _getFromCamera,
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Text('Camera',style: TextStyle(color: Colors.black, fontSize: 14)),

                              Icon(FontAwesomeIcons.camera, color:Colors.grey,),

                            ],
                          )

                      )

                  ),




                ],
              ),

            ),
          ),
        );
      },
    );
  }

  //++++++++++++++++++++++++++++++++++For Driving+++++++++++++++++++++++++++++++++++++++++

  void ForDriving()

  {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          elevation: 16,
          child: Padding(
            padding:  EdgeInsets.all(8.0),
            child: Container(
              height: 200,
              child: Column(
                children: [
                  Padding(
                    padding:  EdgeInsets.all(0.0),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // SizedBox(width: 20,),
                          Text('Get Image', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),),
                          IconButton(
                            icon: Icon(Icons.close, color: Colors.grey,),
                            onPressed: (){
                              Navigator.pop(context);
                            },

                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(thickness: 1,),
                  Container(
                      height: 40,
                      width: 360,

                      child:  InkWell(
                          onTap:kycimagesFromGallery,

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [


                              Text('Gallery',style: TextStyle(color: Colors.black, fontSize: 14)),

                              Icon(FontAwesomeIcons. image, color:Colors.grey),

                            ],
                          )

                      )

                  ),
                  Divider(
                    thickness: 4, // thickness of the line
                    indent: 10, // empty space to the leading edge of divider.
                    endIndent: 10, // empty space to the trailing edge of the divider.
                    color: Colors.grey[200], // The color to use when painting the line.
                    height: 20, // The divider's height extent.
                  ),
                  Container(
                    //height: 40,
                      width: 360,
                      child: InkWell(
                          onTap: kycimagesFromCamera,
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Text('Camera',style: TextStyle(color: Colors.black, fontSize: 14)),

                              Icon(FontAwesomeIcons.camera, color:Colors.grey,),

                            ],
                          )

                      )

                  ),




                ],
              ),

            ),
          ),
        );
      },
    );
  }
  //++++++++++++++++++++++++++++++++++For Passport+++++++++++++++++++++++++++++++++++++++++

  void ForPassport()
  {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          elevation: 16,
          child: Padding(
            padding:  EdgeInsets.all(8.0),
            child: Container(
              height: 200,
              child: Column(
                children: [
                  Padding(
                    padding:  EdgeInsets.all(0.0),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // SizedBox(width: 20,),
                          Text('Get Image', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),),
                          IconButton(
                            icon: Icon(Icons.close, color: Colors.grey,),
                            onPressed: (){
                              Navigator.pop(context);
                            },

                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(thickness: 1,),
                  Container(
                      height: 40,
                      width: 360,

                      child:  InkWell(
                          onTap:kycimagesFromGallery,

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [


                              Text('Gallery',style: TextStyle(color: Colors.black, fontSize: 14)),

                              Icon(FontAwesomeIcons. image, color:Colors.grey),

                            ],
                          )

                      )

                  ),
                  Divider(
                    thickness: 4, // thickness of the line
                    indent: 10, // empty space to the leading edge of divider.
                    endIndent: 10, // empty space to the trailing edge of the divider.
                    color: Colors.grey[200], // The color to use when painting the line.
                    height: 20, // The divider's height extent.
                  ),
                  Container(
                    //height: 40,
                      width: 360,
                      child: InkWell(
                          onTap: kycimagesFromCamera,
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Text('Camera',style: TextStyle(color: Colors.black, fontSize: 14)),

                              Icon(FontAwesomeIcons.camera, color:Colors.grey,),

                            ],
                          )

                      )

                  ),




                ],
              ),

            ),
          ),
        );
      },
    );
  }
  //++++++++++++++++++++++++++++++++++For Business llp number+++++++++++++++++++++++++++++++++++++++++

  void Business()
  {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          elevation: 16,
          child: Padding(
            padding:  EdgeInsets.all(8.0),
            child: Container(
              height: 200,
              child: Column(
                children: [
                  Padding(
                    padding:  EdgeInsets.all(0.0),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // SizedBox(width: 20,),
                          Text('Get Image', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),),
                          IconButton(
                            icon: Icon(Icons.close, color: Colors.grey,),
                            onPressed: (){
                              Navigator.pop(context);
                            },

                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(thickness: 1,),
                  Container(
                      height: 40,
                      width: 360,

                      child:  InkWell(
                          onTap:kycimagesFromGallery,

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [


                              Text('Gallery',style: TextStyle(color: Colors.black, fontSize: 14)),

                              Icon(FontAwesomeIcons. image, color:Colors.grey),

                            ],
                          )

                      )

                  ),
                  Divider(
                    thickness: 4, // thickness of the line
                    indent: 10, // empty space to the leading edge of divider.
                    endIndent: 10, // empty space to the trailing edge of the divider.
                    color: Colors.grey[200], // The color to use when painting the line.
                    height: 20, // The divider's height extent.
                  ),
                  Container(
                    //height: 40,
                      width: 360,
                      child: InkWell(
                          onTap: kycimagesFromCamera,
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Text('Camera',style: TextStyle(color: Colors.black, fontSize: 14)),

                              Icon(FontAwesomeIcons.camera, color:Colors.grey,),

                            ],
                          )

                      )

                  ),




                ],
              ),

            ),
          ),
        );
      },
    );
  }
  //++++++++++++++++++++++++++++++++++For Companynumberr+++++++++++++++++++++++++++++++++++++++++

  void Companynumber()
  {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          elevation: 16,
          child: Padding(
            padding:  EdgeInsets.all(8.0),
            child: Container(
              height: 200,
              child: Column(
                children: [
                  Padding(
                    padding:  EdgeInsets.all(0.0),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // SizedBox(width: 20,),
                          Text('Get Image', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),),
                          IconButton(
                            icon: Icon(Icons.close, color: Colors.grey,),
                            onPressed: (){
                              Navigator.pop(context);
                            },

                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(thickness: 1,),
                  Container(
                      height: 40,
                      width: 360,

                      child:  InkWell(
                          onTap:kycimagesFromGallery,

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [


                              Text('Gallery',style: TextStyle(color: Colors.black, fontSize: 14)),

                              Icon(FontAwesomeIcons. image, color:Colors.grey),

                            ],
                          )

                      )

                  ),
                  Divider(
                    thickness: 4, // thickness of the line
                    indent: 10, // empty space to the leading edge of divider.
                    endIndent: 10, // empty space to the trailing edge of the divider.
                    color: Colors.grey[200], // The color to use when painting the line.
                    height: 20, // The divider's height extent.
                  ),
                  Container(
                    //height: 40,
                      width: 360,
                      child: InkWell(
                          onTap: kycimagesFromCamera,
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Text('Camera',style: TextStyle(color: Colors.black, fontSize: 14)),

                              Icon(FontAwesomeIcons.camera, color:Colors.grey,),

                            ],
                          )

                      )

                  ),




                ],
              ),

            ),
          ),
        );
      },
    );
  }
  //++++++++++++++++++++++++++++++++++For ESSAI+++++++++++++++++++++++++++++++++++++++++

  void ForFssai()
  {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          elevation: 16,
          child: Padding(
            padding:  EdgeInsets.all(8.0),
            child: Container(
              height: 200,
              child: Column(
                children: [
                  Padding(
                    padding:  EdgeInsets.all(0.0),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // SizedBox(width: 20,),
                          Text('Get Image', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),),
                          IconButton(
                            icon: Icon(Icons.close, color: Colors.grey,),
                            onPressed: (){
                              Navigator.pop(context);
                            },

                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(thickness: 1,),
                  Container(
                      height: 40,
                      width: 360,

                      child:  InkWell(
                          onTap:kycimagesFromGallery,

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [


                              Text('Gallery',style: TextStyle(color: Colors.black, fontSize: 14)),

                              Icon(FontAwesomeIcons. image, color:Colors.grey),

                            ],
                          )

                      )

                  ),
                  Divider(
                    thickness: 4, // thickness of the line
                    indent: 10, // empty space to the leading edge of divider.
                    endIndent: 10, // empty space to the trailing edge of the divider.
                    color: Colors.grey[200], // The color to use when painting the line.
                    height: 20, // The divider's height extent.
                  ),
                  Container(
                    //height: 40,
                      width: 360,
                      child: InkWell(
                          onTap: kycimagesFromCamera,
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Text('Camera',style: TextStyle(color: Colors.black, fontSize: 14)),

                              Icon(FontAwesomeIcons.camera, color:Colors.grey,),

                            ],
                          )

                      )

                  ),




                ],
              ),

            ),
          ),
        );
      },
    );
  }

  //++++++++++++++++++++++++++++++++++For Liquior+++++++++++++++++++++++++++++++++++++++++
  void Liquor()
  {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          elevation: 16,
          child: Padding(
            padding:  EdgeInsets.all(8.0),
            child: Container(
              height: 200,
              child: Column(
                children: [
                  Padding(
                    padding:  EdgeInsets.all(0.0),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // SizedBox(width: 20,),
                          Text('Get Image', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),),
                          IconButton(
                            icon: Icon(Icons.close, color: Colors.grey,),
                            onPressed: (){
                              Navigator.pop(context);
                            },

                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(thickness: 1,),
                  Container(
                      height: 40,
                      width: 360,

                      child:  InkWell(
                          onTap:kycimagesFromGallery,

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [


                              Text('Gallery',style: TextStyle(color: Colors.black, fontSize: 14)),

                              Icon(FontAwesomeIcons. image, color:Colors.grey),

                            ],
                          )

                      )

                  ),
                  Divider(
                    thickness: 4, // thickness of the line
                    indent: 10, // empty space to the leading edge of divider.
                    endIndent: 10, // empty space to the trailing edge of the divider.
                    color: Colors.grey[200], // The color to use when painting the line.
                    height: 20, // The divider's height extent.
                  ),
                  Container(
                    //height: 40,
                      width: 360,
                      child: InkWell(
                          onTap: kycimagesFromCamera,
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Text('Camera',style: TextStyle(color: Colors.black, fontSize: 14)),

                              Icon(FontAwesomeIcons.camera, color:Colors.grey,),

                            ],
                          )

                      )

                  ),




                ],
              ),

            ),
          ),
        );
      },
    );
  }
  //++++++++++++++++++++++++++++++++++For Trade+++++++++++++++++++++++++++++++++++++++++
  void Trade()
  {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          elevation: 16,
          child: Padding(
            padding:  EdgeInsets.all(8.0),
            child: Container(
              height: 200,
              child: Column(
                children: [
                  Padding(
                    padding:  EdgeInsets.all(0.0),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // SizedBox(width: 20,),
                          Text('Get Image', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),),
                          IconButton(
                            icon: Icon(Icons.close, color: Colors.grey,),
                            onPressed: (){
                              Navigator.pop(context);
                            },

                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(thickness: 1,),
                  Container(
                      height: 40,
                      width: 360,

                      child:  InkWell(
                          onTap:kycimagesFromGallery,

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [


                              Text('Gallery',style: TextStyle(color: Colors.black, fontSize: 14)),

                              Icon(FontAwesomeIcons. image, color:Colors.grey),

                            ],
                          )

                      )

                  ),
                  Divider(
                    thickness: 4, // thickness of the line
                    indent: 10, // empty space to the leading edge of divider.
                    endIndent: 10, // empty space to the trailing edge of the divider.
                    color: Colors.grey[200], // The color to use when painting the line.
                    height: 20, // The divider's height extent.
                  ),
                  Container(
                    //height: 40,
                      width: 360,
                      child: InkWell(
                          onTap: kycimagesFromCamera,
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Text('Camera',style: TextStyle(color: Colors.black, fontSize: 14)),

                              Icon(FontAwesomeIcons.camera, color:Colors.grey,),

                            ],
                          )

                      )

                  ),




                ],
              ),

            ),
          ),
        );
      },
    );
  }
  //++++++++++++++++++++++++++++++++++For other+++++++++++++++++++++++++++++++++++++++++
  void Document()
  {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          elevation: 16,
          child: Padding(
            padding:  EdgeInsets.all(8.0),
            child: Container(
              height: 200,
              child: Column(
                children: [
                  Padding(
                    padding:  EdgeInsets.all(0.0),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // SizedBox(width: 20,),
                          Text('Get Image', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),),
                          IconButton(
                            icon: Icon(Icons.close, color: Colors.grey,),
                            onPressed: (){
                              Navigator.pop(context);
                            },

                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(thickness: 1,),
                  Container(
                      height: 40,
                      width: 360,

                      child:  InkWell(
                          onTap:kycimagesFromGallery,

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [


                              Text('Gallery',style: TextStyle(color: Colors.black, fontSize: 14)),

                              Icon(FontAwesomeIcons. image, color:Colors.grey),

                            ],
                          )

                      )

                  ),
                  Divider(
                    thickness: 4, // thickness of the line
                    indent: 10, // empty space to the leading edge of divider.
                    endIndent: 10, // empty space to the trailing edge of the divider.
                    color: Colors.grey[200], // The color to use when painting the line.
                    height: 20, // The divider's height extent.
                  ),
                  Container(
                    //height: 40,
                      width: 360,
                      child: InkWell(
                          onTap: kycimagesFromCamera,
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Text('Camera',style: TextStyle(color: Colors.black, fontSize: 14)),

                              Icon(FontAwesomeIcons.camera, color:Colors.grey,),

                            ],
                          )

                      )

                  ),




                ],
              ),

            ),
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
          backgroundColor: Colors.white,
          bottomNavigationBar:
          currentIndex == 1?
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,bottom: 20,top: 10),
            child: InkWell(
              onTap: ()
              {
                print("FInal Category Value");
                print(_selectedTest);

                if(imageGile != null && service_name.text.isNotEmpty && service_price.text.isNotEmpty && _selectedTest != null)
                  {
                    setState(() {
                      serviceName = false;
                      servicePrice = false;
                      serviceImg = false;
                      selectCat = false;
                      selectCat = selectCat;
                    });

                    File _service_img = imageGile;
                    String _service_name = service_name.text.toString();
                    String _service_cat = cat_id.toString();
                    String _service_price= service_price.text.toString();
                    String _service_unit = unit_price.toString();
                    String _service_duration = service_duration.text.toString();
                    String _service_desc= service_desc.text.toString();
                    String _service_discount= discount_service_price.text.toString();

                    setState(() {
                      isLoaders = true;

                    });
                    BusinessService().BusinessServiceData(_service_discount,_service_desc,_service_name,_selectedTest == null?cat_id:_selectedTest,_service_price,_service_unit,_service_duration,_service_img).then((val)
                    {
                      setState(() {
                        isLoaders= false;
                      });
                      if(val == 200 || val== 201)
                      {

                        Fluttertoast.showToast(
                            msg:"Service Saved Successfully",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor:Get.theme.colorScheme.secondary,
                            textColor: Colors.white,
                            fontSize: 14.0
                        );
                        setState(() {
                          selectseven = true;
                          currentIndex = 2;
                        });
                      }
                    });
                  }
                else if(imageGile == null && service_name.text.isEmpty && service_price.text.isEmpty && _selectedTest == null)
                  {
                    setState(() {
                      serviceName = true;
                      servicePrice = true;
                      serviceImg = true;
                      selectCat = true;
                    });
                  }
                else if(imageGile == null)
                  {
                    setState(() {
                      serviceImg = true;
                    });
                  }
                else if(service_name.text.isEmpty)
                  {
                    setState(() {
                      serviceName = true;
                      // servicePrice = false;
                      // serviceImg = false;
                      // selectCat = false;
                    });
                  }
                else if(service_price.text.isEmpty)
                  {
                    setState(() {
                     // serviceName = false;
                      servicePrice = true;
                      // serviceImg = false;
                      // selectCat = false;
                    });
                  }
                else if(_selectedTest != null)
                  {

                    setState(() {
                      // serviceName = false;
                      // servicePrice = false;
                      // serviceImg = false;
                       selectCat = true;
                    });
                  }
              },
              child: isLoaders == true? Container(
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Get.theme.colorScheme.secondary,
                  ),
                  //alignment: Alignment.,
                  width: 400,

                  child: Center(child: CircularProgressIndicator(color: Colors.white,strokeWidth: 2,))):
              Container(height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Get.theme.colorScheme.secondary,
                ),
                //alignment: Alignment.,
                width: 400,
                child:  Center(child: Text("Next",style: TextStyle(color: Colors.white,fontSize: 14),)),
              ),
            ),
          ):
          currentIndex == 2?
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,bottom: 20,top: 10),
            child: InkWell(
              onTap: ()
              {
                if(company_name.text.isNotEmpty && addresss.text.isNotEmpty && district.text.isNotEmpty && city_name.text.isNotEmpty && pincode.text.isNotEmpty && landmark.text.isNotEmpty && mobile_number.text.isNotEmpty)
                  {
                    setState(()
                    {
                      companyNameValid = false;
                      companyAddress = false;
                      companyDistrict = false;
                      companyCity = false;
                      companyPincode = false;
                      companyLandmark = false;
                      mobileNumberValid = false;
                    }
                    );
                    if(mobile_number.text.length ==  10)
                      {

                        String _compnay = company_name.text.toString();
                        String _address = addresss.text.toString();
                        String _district = district.text.toString();
                        String _city = city_name.text.toString();
                        String _pincode = pincode.text.toString();
                        String _landmark = landmark.text.toString();
                        String _mobile_number = mobile_number.text.toString();
                        setState(() {
                          isLoaders =true;
                        });
                        AddressSaved().SaveAddress(_compnay,_address,_district,_city,_pincode,_landmark,_mobile_number).then((val)
                        {   setState(() {
                          isLoaders =false;
                        });
                        var msg = val['message'];
                        Fluttertoast.showToast(
                            msg:msg.toString(),
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Get.theme.colorScheme.secondary,
                            textColor: Colors.white,
                            fontSize: 14.0
                        );
                        setState(() {
                          select =true;
                          currentIndex = 3;
                        });

                        });
                      }
                    else
                      {
                        Fluttertoast.showToast(
                            msg:"Phone number should be 10 digit",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Get.theme.colorScheme.secondary,
                            textColor: Colors.white,
                            fontSize: 14.0
                        );

                      }

                  }
                else if(company_name.text.isEmpty && addresss.text.isEmpty && district.text.isEmpty && city_name.text.isEmpty && pincode.text.isEmpty && landmark.text.isEmpty && mobile_number.text.isEmpty && pincode.text.isEmpty)
                   {

                     setState(()
                         {
                           companyNameValid = true;
                           companyAddress = true;
                           companyDistrict = true;
                           companyCity = true;
                           companyPincode = true;
                           companyLandmark = true;
                           mobileNumberValid = true;
                         }
                     );

                   }
                else if(company_name.text.isEmpty )
                  {
                    setState(()
                    {
                      companyNameValid = true;
                      // companyAddress = false;
                      // companyDistrict = false;
                      // companyCity = false;
                      // companyLandmark = false;
                      // mobileNumberValid = false;
                    }
                    );
                  }
                else if(addresss.text.isEmpty )
                  {
                    setState(()
                    {
                      // companyNameValid = false;
                      companyAddress = true;
                      // companyDistrict = false;
                      // companyCity = false;
                      // companyLandmark = false;
                      // mobileNumberValid = false;
                    }
                    );
                  }
                else if(district.text.isEmpty )
                  {
                    setState(()
                    {
                      // companyNameValid = false;
                      // companyAddress = false;
                      companyDistrict = true;
                      // companyCity = false;g
                      // companyLandmark = false;
                      // mobileNumberValid = false;
                    }
                    );
                  }
                else if(city_name.text.isEmpty )
                  {
                    setState(()
                    {
                      // companyNameValid = false;
                      // companyAddress = false;
                      // companyDistrict = false;
                      companyCity = true;
                      // companyLandmark = false;
                      // mobileNumberValid = false;
                    }
                    );
                  }
                else if(landmark.text.isEmpty )
                  {
                    setState(()
                    {
                      // companyNameValid = false;
                      // companyAddress = false;
                      // companyDistrict = false;
                      // companyCity = false;
                      companyLandmark = true;
                      // mobileNumberValid = false;
                    }
                    );
                  }
                else if(mobile_number.text.isEmpty )
                  {
                    setState(()
                    {
                      // companyNameValid = false;
                      // companyAddress = false;
                      // companyDistrict = false;
                      // companyCity = false;
                      // companyLandmark = false;
                      mobileNumberValid = true;
                    }
                    );
                  }
                else if(pincode.text.isEmpty )
                  {
                    setState(()
                    {
                      // companyNameValid = false;
                      // companyAddress = false;
                      // companyDistrict = false;
                      // companyCity = false;
                      // companyLandmark = false;
                      // mobileNumberValid = false;
                      companyPincode = true;
                    }
                    );
                  }





                // if(_compnay.isNotEmpty&&_address.isNotEmpty &&_district.isNotEmpty&&_city.isNotEmpty&&_pincode.isNotEmpty&&_landmark.isNotEmpty&&_mobile_number.isNotEmpty)
                // {
                //   setState(() {
                //     isLoaders =true;
                //   });
                //   AddressSaved().SaveAddress(_compnay,_address,_district,_city,_pincode,_landmark,_mobile_number).then((val)
                //   {   setState(() {
                //     isLoaders =false;
                //   });
                //
                //     var msg = val['message'];
                //     Fluttertoast.showToast(
                //         msg:msg.toString(),
                //         toastLength: Toast.LENGTH_SHORT,
                //         gravity: ToastGravity.CENTER,
                //         timeInSecForIosWeb: 1,
                //         backgroundColor: Get.theme.colorScheme.secondary,
                //         textColor: Colors.white,
                //         fontSize: 14.0
                //     );
                //     setState(() {
                //       select =true;
                //       currentIndex = 3;
                //     });
                //
                //
                //   });
                // }
                // else
                // {
                //   print("ALL DATA EMPTY");
                //   Fluttertoast.showToast(
                //       msg:"Please fill all the fields",
                //       toastLength: Toast.LENGTH_SHORT,
                //       gravity: ToastGravity.CENTER,
                //       timeInSecForIosWeb: 1,
                //       backgroundColor:Get.theme.colorScheme.secondary,
                //       textColor: Colors.white,
                //       fontSize: 14.0
                //   );
                // }

              },
              child: isLoaders == true? Container(
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Get.theme.colorScheme.secondary,
                  ),
                  //alignment: Alignment.,
                  width: 400,

                  child: Center(child: CircularProgressIndicator(color: Colors.white,strokeWidth: 2,))):Container(height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Get.theme.colorScheme.secondary,
                ),
                //alignment: Alignment.,
                width: 400,
                child:  Center(child: Text("Next",style: TextStyle(color: Colors.white,fontSize: 14),)),
              ),
            ),
          ):
          currentIndex == 3?
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,bottom: 20,top: 10),
            child: InkWell(
              onTap: ()
              {
                String _establishment = establish.text.toString();
                String _payment = payment_method.text.toString();
                String awards = add_awards.text.toString();
                String _website = website.text.toString();
                File _image = Imageupload;
                File _video = videoupload;
                //String certificate = cert;
                PlatformFile certificate = file1;
                print("+++++++++++++++++++++IMAGE DETAILS+++++++++++++++++++++++++++");
                print(_establishment);
                print(_image);
                // print(_video);
                print(certificate);
                print(img);
                print(video);
                print(cert_file);
                setState(() {
                  isLoaderone =true;
                });

                BusinessDetaols().BusinessDetaolsData(_establishment,_payment,awards,_website,_image,_video,certificate).then((val)
                {
                  setState(() {
                    isLoaderone =false;
                  });
                  if(val == 200 || val ==201)
                  {
                    setState(() {
                      selectone =true;
                      currentIndex = 4;
                    });
                    Fluttertoast.showToast(
                        msg:"Business details update sucessfully",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor:Get.theme.colorScheme.secondary,
                        textColor: Colors.white,
                        fontSize: 14.0
                    );
                  }


                });





              },
              child:isLoaderone == true? Container(
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Get.theme.colorScheme.secondary,
                  ),
                  //alignment: Alignment.,
                  width: 400,

                  child: Center(child: CircularProgressIndicator(color: Colors.white,strokeWidth: 2,))): Container(height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Get.theme.colorScheme.secondary,
                ),
                //alignment: Alignment.,
                width: 400,
                child:  Center(child: Text("Next",style: TextStyle(color: Colors.white,fontSize: 14),)),
              ),
            ),
          ):
          currentIndex == 4?
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,bottom: 20,top: 10),
            child: InkWell(
              onTap: ()
              {
                String _facebook = facebook.text.toString();
                String _instagram = instagram.text.toString();
                String _twitter = twitter.text.toString();
                String _youtube = youtube.text.toString();
                String _linkedin = linkedin.text.toString();
                String _yahoo = yahoo.text.toString();
                setState(() {
                  isLoadertwo =true;
                });
                print("++++++++++++++++++++++++++++++++++++++Links DETAILS++++++++++++++++++++++++++++++++");
                print(_facebook);
                print(_instagram);
                print(_twitter);
                print(_youtube);
                print(_linkedin);
                print(_yahoo);
                SocialMediaData().SocialMediaLink(_facebook,_instagram,_twitter,_youtube,_linkedin,_yahoo).then((val)
                {
                  setState(() {
                    isLoadertwo =false;
                    selecttwo = true;
                    currentIndex =5;

                  });
                  if(val ==200 || val ==201)
                  {
                    Fluttertoast.showToast(
                        msg:"Social media links saved sucessfully".toString(),
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor:Get.theme.colorScheme.secondary,
                        textColor: Colors.white,
                        fontSize: 14.0

                    );
                  }


                });
                // if(_facebook.isNotEmpty && _instagram.isNotEmpty && _twitter.isNotEmpty && _youtube.isNotEmpty && _linkedin.isNotEmpty && _yahoo.isNotEmpty)
                // {
                //   setState(() {
                //     isLoadertwo =true;
                //   });
                //   SocialMediaData().SocialMediaLink(_facebook,_instagram,_twitter,_youtube,_linkedin,_yahoo).then((val)
                //   {
                //     setState(() {
                //       isLoadertwo =false;
                //       selecttwo = true;
                //       currentIndex =5;
                //
                //     });
                //     if(val ==200 || val ==201)
                //       {
                //         Fluttertoast.showToast(
                //             msg:"Social media links saved sucessfully".toString(),
                //             toastLength: Toast.LENGTH_SHORT,
                //             gravity: ToastGravity.CENTER,
                //             timeInSecForIosWeb: 1,
                //             backgroundColor:Get.theme.colorScheme.secondary,
                //             textColor: Colors.white,
                //             fontSize: 14.0
                //
                //         );
                //       }
                //
                //
                //   });
                // }
                // else
                // {
                //   Fluttertoast.showToast(
                //       msg:"Please fill all fields",
                //       toastLength: Toast.LENGTH_SHORT,
                //       gravity: ToastGravity.CENTER,
                //       timeInSecForIosWeb: 1,
                //       backgroundColor:Get.theme.colorScheme.secondary,
                //       textColor: Colors.white,
                //       fontSize: 14.0
                //
                //   );
                //
                // }




              },
              child: isLoadertwo == true? Container(
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Get.theme.colorScheme.secondary,
                  ),
                  //alignment: Alignment.,
                  width: 400,

                  child: Center(child: CircularProgressIndicator(color: Colors.white,strokeWidth: 2,))):Container(height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Get.theme.colorScheme.secondary,
                ),
                //alignment: Alignment.,
                width: 400,
                child:  Center(child: Text("Next",style: TextStyle(color: Colors.white,fontSize: 14),)),
              ),
            ),
          ):
          currentIndex == 5?
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,bottom: 20,top: 10),
            child: InkWell(
              onTap: ()
              {
                String _register_gdtn = register_gstn.text.toString();
                String _register_address = register_under_gst.text.toString();
                String _register_pincode = register_pincode.text.toString();
                String gst_no = gstno.text.toString();
                String pan = pan_umber.text.toString();
                setState(() {
                  isLoaderthree=true;
                });
                GstData().GstDataField(_register_gdtn, _register_address, _register_pincode, gst_no, pan).then((val)
                {
                  setState(() {
                    isLoaderthree =false;

                  });
                  var msg = val['message'];

                  Fluttertoast.showToast(
                      msg:msg.toString(),
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor:Get.theme.colorScheme.secondary,
                      textColor: Colors.white,
                      fontSize: 14.0

                  );
                  setState(() {
                    selectthree = true;
                    currentIndex =6;

                  });
                });
                // if(_register_gdtn.isNotEmpty&&_register_address.isNotEmpty&&_register_pincode.isNotEmpty&&gst_no.isNotEmpty&&pan.isNotEmpty)
                // {
                //   setState(() {
                //     isLoaderthree=true;
                //   });
                //   GstData().GstDataField(_register_gdtn, _register_address, _register_pincode, gst_no, pan).then((val)
                //   {
                //     setState(() {
                //       isLoaderthree =false;
                //
                //     });
                //     var msg = val['message'];
                //
                //     Fluttertoast.showToast(
                //         msg:msg.toString(),
                //         toastLength: Toast.LENGTH_SHORT,
                //         gravity: ToastGravity.CENTER,
                //         timeInSecForIosWeb: 1,
                //         backgroundColor:Get.theme.colorScheme.secondary,
                //         textColor: Colors.white,
                //         fontSize: 14.0
                //
                //     );
                //     setState(() {
                //       selectthree = true;
                //       currentIndex =6;
                //
                //     });
                //   });
                //
                // }
                // else
                // {
                //   Fluttertoast.showToast(
                //       msg:"Plaes fill all fields",
                //       toastLength: Toast.LENGTH_SHORT,
                //       gravity: ToastGravity.CENTER,
                //       timeInSecForIosWeb: 1,
                //       backgroundColor:Get.theme.colorScheme.secondary,
                //       textColor: Colors.white,
                //       fontSize: 14.0
                //
                //   );
                // }

              },
              child:isLoaderthree == true? Container(
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Get.theme.colorScheme.secondary,
                  ),
                  //alignment: Alignment.,
                  width: 400,

                  child: Center(child: CircularProgressIndicator(color: Colors.white,strokeWidth: 2,))): Container(height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Get.theme.colorScheme.secondary,
                ),
                //alignment: Alignment.,
                width: 400,
                child:  Center(child: Text("Next",style: TextStyle(color: Colors.white,fontSize: 14),)),
              ),
            ),
          ):
          currentIndex == 6?
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,bottom: 20,top: 10),
            child: InkWell(
              onTap: ()
              {
                setState(() {
                  isLoaderfour = true;
                });
                KycDetails().KycDetailsDadta(Pan, driving, passport_file, liquir, trade, llp, company,documnet,Fssai).then((val)                  {
                  setState(() {
                    isLoaderfour = false;
                    selectfour=true;
                    currentIndex =7;


                  });
                  if(val ==200 || val ==201)
                  {

                    Fluttertoast.showToast(
                        msg:"Kyc details saved successfully".toString(),
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor:Get.theme.colorScheme.secondary,
                        textColor: Colors.white,
                        fontSize: 14.0

                    );

                  }


                });
                //
                // if(pan_img.isEmpty&&drive_img.isEmpty&&passport_img.isEmpty&&trade_img.isEmpty&&llp_img.isEmpty&&other_docu_img.isEmpty&&fssai_img.isEmpty)
                // {
                //   if(Pan!=null && driving!=null &&passport_file !=null&&liquir !=null &&trade!=null &&llp!=null&&company!=null&&documnet!=null&&Fssai!=null)
                //   {
                //     KycDetails().KycDetailsDadta(Pan, driving, passport_file, liquir, trade, llp, company,documnet,Fssai).then((val)                  {
                //       var msg = val['message'];
                //
                //       Fluttertoast.showToast(
                //           msg:msg.toString(),
                //           toastLength: Toast.LENGTH_SHORT,
                //           gravity: ToastGravity.CENTER,
                //           timeInSecForIosWeb: 1,
                //           backgroundColor:Get.theme.colorScheme.secondary,
                //           textColor: Colors.white,
                //           fontSize: 14.0
                //
                //       );
                //       setState(() {
                //         selectfour = true;
                //         currentIndex =6;
                //
                //       });
                //     });
                //
                //   }
                //   else
                //   {
                //     Fluttertoast.showToast(
                //         msg:"Plaes fill all fields",
                //         toastLength: Toast.LENGTH_SHORT,
                //         gravity: ToastGravity.CENTER,
                //         timeInSecForIosWeb: 1,
                //         backgroundColor:Get.theme.colorScheme.secondary,
                //         textColor: Colors.white,
                //         fontSize: 14.0
                //
                //     );
                //   }
                // }
                // else
                // {
                //   setState(() {
                //     selectfour = true;
                //     currentIndex =6;
                //
                //   });
                // }

              },
              child: isLoaderfour == true? Container(
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Get.theme.colorScheme.secondary,
                  ),
                  //alignment: Alignment.,
                  width: 400,

                  child: Center(child: CircularProgressIndicator(color: Colors.white,strokeWidth: 2,))):Container(height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Get.theme.colorScheme.secondary,
                ),
                //alignment: Alignment.,
                width: 400,
                child:  Center(child: Text("Next",style: TextStyle(color: Colors.white,fontSize: 14),)),
              ),
            ),
          ):
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,bottom: 20,top: 10),
            child: InkWell(
              onTap: ()
              {
                setState(() {
                  isLoadersix =true;

                });
                print("++++++++++++++++++++++++PROMOTS DATA+++++++++++++++++++++++++");
                print(plan);
                print(benefits);
                print(promote_data);
                print(benefits_data);
                print(selected);
                String plans = plan == null ?promote_data.toString():plan.toString();

                PromoteAndBenifits().PromoteAndBenifitsData(plan == null ?promote_data:plan ,benefits==null?benefits_data:benefits).then((val)
                {
                  setState(() {
                    isLoadersix =false;
                    selectfive =true;


                  });
                  var msg = val['message'];
                  var status = val['status'];

                  if(plan == null?promote_data.isNotEmpty:plan.isNotEmpty && selected != null)
                  {
                    Fluttertoast.showToast(
                        msg:msg.toString(),
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor:Get.theme.colorScheme.secondary,
                        textColor: Colors.white,
                        fontSize: 14.0

                    );
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentPage(selected:selected,mobileNumber:mobileNumber,)));

                  }
                  else
                  {
                    Fluttertoast.showToast(
                        msg:"Please select plan".toString(),
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor:Get.theme.colorScheme.secondary,
                        textColor: Colors.white,
                        fontSize: 14.0

                    );
                  }

                });
                // if(promote_data.isEmpty && benefits_data.isEmpty&&promote_data.isEmpty&&benefits_data.isEmpty)
                // {
                //   Fluttertoast.showToast(
                //       msg:"Please selcet ",
                //       toastLength: Toast.LENGTH_SHORT,
                //       gravity: ToastGravity.CENTER,
                //       timeInSecForIosWeb: 1,
                //       backgroundColor:Get.theme.colorScheme.secondary,
                //       textColor: Colors.white,
                //       fontSize: 14.0
                //
                //   );
                // }
                //
                // if(promote_data.isEmpty && benefits_data.isEmpty)
                //   {
                //     if(promote.isNotEmpty && benefits.isNotEmpty)
                //     {
                //       setState(() {
                //         isLoadersix =true;
                //
                //       });
                //       PromoteAndBenifits().PromoteAndBenifitsData(promote,benefits).then((val)
                //       {
                //         setState(() {
                //           isLoadersix =false;
                //           selectfive =true;
                //         });
                //         var msg = val['message'];
                //         Fluttertoast.showToast(
                //             msg:msg.toString(),
                //             toastLength: Toast.LENGTH_SHORT,
                //             gravity: ToastGravity.CENTER,
                //             timeInSecForIosWeb: 1,
                //             backgroundColor:Get.theme.colorScheme.secondary,
                //             textColor: Colors.white,
                //             fontSize: 14.0
                //
                //         );
                //
                //       });
                //
                //     }
                //     else
                //     {
                //       Fluttertoast.showToast(
                //           msg:"Please selcet ",
                //           toastLength: Toast.LENGTH_SHORT,
                //           gravity: ToastGravity.CENTER,
                //           timeInSecForIosWeb: 1,
                //           backgroundColor:Get.theme.colorScheme.secondary,
                //           textColor: Colors.white,
                //           fontSize: 14.0
                //
                //       );
                //     }
                //   }
                // else
                //   {
                //     setState(() {
                //       isLoadersix =true;
                //       selectfive =true;
                //     });
                //     PromoteAndBenifits().PromoteAndBenifitsData(promote_data,benefits_data).then((val)
                //     {
                //       setState(() {
                //         isLoadersix =false;
                //         selectfive =true;
                //       });
                //       var msg = val['message'];
                //       Fluttertoast.showToast(
                //           msg:msg.toString(),
                //           toastLength: Toast.LENGTH_SHORT,
                //           gravity: ToastGravity.CENTER,
                //           timeInSecForIosWeb: 1,
                //           backgroundColor:Get.theme.colorScheme.secondary,
                //           textColor: Colors.white,
                //           fontSize: 14.0
                //
                //       );
                //
                //     });
                //
                //
                //   }



              },
              child:isLoadersix == true?
              Container(
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Get.theme.colorScheme.secondary,
                  ),
                  //alignment: Alignment.,
                  width: 400,

                  child: Center(child: CircularProgressIndicator(color: Colors.white,strokeWidth: 2,))):
              Container(height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Get.theme.colorScheme.secondary,
                ),
                //alignment: Alignment.,
                width: 400,
                child:  Center(child: Text("Save",style: TextStyle(color: Colors.white,fontSize: 14),)),
              ),
            ),
          ),
          appBar: AppBar(
            // toolbarHeight: 80,
            elevation: 0,
            title: Text("Business Details"),
            centerTitle: true,
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back_ios,
                  color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
                // Get.back()
              },
            ),

            bottom: PreferredSize(
              preferredSize: Size.fromHeight(60),
              child: Container(
                height: 60,
                width: 400,
                padding:  EdgeInsets.all(8.0),
                color: Colors.white,

                child: Center(
                  child: ListView(
                      scrollDirection: Axis.horizontal,
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   unselectedLabelColor: Get.theme.colorScheme.secondary,
                      // isScrollable: true,
                      //  // indicatorSize: TabBarIndicatorSize.tab,
                      //   indicatorPadding: EdgeInsets.only(top: 5.0, bottom: 10.0),

                      children: [
                        SelctSeven(selectseven), selectseven == true ? SizedBox(
                          width: 80,
                          child: Divider(
                            height: 10,
                            thickness: 1,

                            color:selectseven == true ?Get.theme.colorScheme.secondary: Colors.grey,
                          ),
                        ): SizedBox(width: 20,),
                        SelctOne(select), select == true ? SizedBox(
                          width: 80,
                          child: Divider(
                            height: 10,
                            thickness: 1,

                            color:select == true ?Get.theme.colorScheme.secondary: Colors.grey,
                          ),
                        ): SizedBox(width: 20,), // SizedBox(width: 15,),
                        SelctTwo(selectone), selectone == true ? SizedBox(
                          width: 80,
                          child: Divider(
                            height: 10,
                            thickness: 1,

                            color:selectone == true ?Get.theme.colorScheme.secondary: Colors.grey,
                          ),
                        ): SizedBox(width: 20,), SelctThree(selecttwo),
                        selecttwo ==true ? SizedBox(
                          width: 80,
                          child: Divider(
                            height: 10,
                            thickness: 1,

                            color:selecttwo == true ?Get.theme.colorScheme.secondary: Colors.grey,
                          ),
                        ): SizedBox(width: 20,), SelctFour(selectthree),
                        selectthree == true ?
                        SizedBox(
                          width: 80,
                          child: Divider(
                            height: 10,
                            thickness: 1,

                            color:selectthree == true ?Get.theme.colorScheme.secondary: Colors.grey,
                          ),
                        ):
                        SizedBox(width: 20,),
                        SelctFive(selectfour),
                        selectfour == true ?
                        SizedBox(
                          width: 80,
                          child: Divider(
                            height: 10,
                            thickness: 1,

                            color:selectfour == true ?Get.theme.colorScheme.secondary: Colors.grey,
                          ),
                        ):
                        SizedBox(width: 20,),
                        SelctSix(selectfive),



                      ]
                  ),
                ),

              ),
            ),
            backgroundColor:  Get.theme.colorScheme.secondary,

          ),

          body:SingleChildScrollView(
            child: currentIndex == 1?
            StepSeven():
            currentIndex == 2?
            StepOne():
            currentIndex == 3?
            StepTwo():
            currentIndex == 4?
            StepThree():
            currentIndex == 5?
            StepFour():
            currentIndex == 6?
            StepFive(): StepSix(),

          )
      ),

    );
  }
  //+++++++++++++++++++++STEP ONE+++++++++++++++++++++++++++++++++++++
  StepOne()
  {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 10,),
          Container(child: Center(child: Text("Address",style: TextStyle(color:Get.theme.colorScheme.secondary,fontSize: 18),))),
          //------------------------Company name------------------------------------
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,top: 5, ),
            child: Text("Company name",style: TextStyle(color: Get.theme.colorScheme.secondary,fontSize: 12),),
          ),
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,top: 10,
                bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Color(0xff8ba3bd)
                      ),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  padding: EdgeInsets.all(8),

                  child: TextFormField(
                    controller: company_name,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText:'Enter company name',
                        hintStyle: TextStyle(color: Color(0xff8ba3bd)),

                        // label: Text("Company Name"),
                        // labelText: 'Company Name',
                        // prefixIcon: Icon(Icons.person),
                        // prefixIcon: Image.asset('assets/img/Company.png'),


                        labelStyle: TextStyle(color: Colors.grey)

                    ),

                  ),
                ),
                SizedBox(height:8),
                companyNameValid == true && company_name.text.isEmpty?Text("Company name is required",style:TextStyle(color:Colors.red,fontSize: 12)):Container()

              ],
            ),
          ),
          //------------------------Address-----------------------------------------
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,top: 5, ),
            child: Text("Address",style: TextStyle(color: Get.theme.colorScheme.secondary,fontSize: 12),),
          ),
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,top: 15,bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Color(0xff8ba3bd)
                      ),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  //padding: EdgeInsets.all(8),

                  child: Center(
                    child: TextFormField(
                      controller: addresss,
                      maxLines: 3,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter address',
                          hintStyle: TextStyle(color: Color(0xff8ba3bd)),
                          contentPadding: EdgeInsets.only(left: 10,top: 20),
                          //prefixIcon: Icon(Icons.location_on_sharp),
                          // prefixIcon: Padding(
                          //   padding: const EdgeInsets.all(10.0),
                          //   child: Image.asset('assets/img/address.png'),
                          // ),
                          // prefixIcon: Container(
                          //   height: 5,
                          //   width: 5,
                          //   child: Image.asset('assets/img/address.png',height: 5,width: 5,fit: BoxFit.fill,),
                          // ),
                          labelStyle: TextStyle(color: Colors.grey)

                      ),

                    ),
                  ),
                ),
                SizedBox(height:8),

                companyAddress == true && addresss.text.isEmpty?Text("Company address is required",style:TextStyle(color:Colors.red,fontSize: 12)):Container()

              ],
            ),
          ),
          //------------------------District----------------------------------------
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,top: 5, ),
            child: Text("District",style: TextStyle(color: Get.theme.colorScheme.secondary,fontSize: 12),),
          ),
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,top: 15,bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Color(0xff8ba3bd)
                      ),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  padding: EdgeInsets.all(8),

                  child: TextFormField(
                    controller: district,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        //  prefixIcon: Icon(Icons.location_on_sharp),
                        // prefixIcon: Image.asset('assets/img/City , district .png'),
                        hintStyle: TextStyle(color: Color(0xff8ba3bd)),
                        hintText: 'Enter district',
                        labelStyle: TextStyle(color: Colors.grey)

                    ),

                  ),
                ),
                SizedBox(height:8),
                companyDistrict == true && district.text.isEmpty?Text("Company district is required",style:TextStyle(color:Colors.red,fontSize: 12)):Container()

              ],
            ),
          ),
          //------------------------City---------------------------------------------
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,top: 5, ),
            child: Text("City",style: TextStyle(color: Get.theme.colorScheme.secondary,fontSize: 12),),
          ),
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,top: 15,bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Color(0xff8ba3bd)
                      ),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  padding: EdgeInsets.all(8),

                  child: TextFormField(
                    controller: city_name,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        //  prefixIcon: Icon(Icons.Location),
                        // prefixIcon: Icon(Icons.location_on_sharp),
                        // prefixIcon: Image.asset('assets/img/City , district .png'),
                        hintStyle: TextStyle(color: Color(0xff8ba3bd)),


                        hintText: 'Enter city',
                        labelStyle: TextStyle(color: Colors.grey)

                    ),

                  ),
                ),
                SizedBox(height:8),
                companyCity == true && city_name.text.isEmpty?Text("City is required",style:TextStyle(color:Colors.red,fontSize: 12)):Container()

              ],
            ),
          ),
          //-----------------------Pincode------------------------------------------
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,top: 5, ),
            child: Text("Pincode",style: TextStyle(color: Get.theme.colorScheme.secondary,fontSize: 12),),
          ),
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,top: 15,bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Color(0xff8ba3bd)
                      ),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  padding: EdgeInsets.all(8),

                  child: TextFormField(
                    controller: pincode,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: InputBorder.none,

                        //  prefixIcon: Icon(Icons.Location),
                        // prefixIcon: Icon(Icons.location_on_sharp),
                        // prefixIcon: Image.asset('assets/img/City , district .png'),
                        hintStyle: TextStyle(color: Color(0xff8ba3bd)),

                        hintText: 'Enter pincode',
                        labelStyle: TextStyle(color: Colors.grey)

                    ),

                  ),
                ),
                SizedBox(height:8),

                companyPincode== true && pincode.text.isEmpty?Text("Pincode is required",style:TextStyle(color:Colors.red,fontSize: 12)):Container()

              ],
            ),
          ),
          //-------------------------=Landmark---------------------------------------
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,top: 5, ),
            child: Text("Landmark",style: TextStyle(color: Get.theme.colorScheme.secondary,fontSize: 12),),
          ),
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,top: 15,bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Color(0xff8ba3bd)
                      ),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  padding: EdgeInsets.all(8),

                  child: TextFormField(
                    controller: landmark,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        //  prefixIcon: Icon(Icons.Location),
                        // prefixIcon: Icon(Icons.location_on_sharp),
                        // prefixIcon: Image.asset('assets/img/landmark.png'),
                        hintStyle: TextStyle(color: Color(0xff8ba3bd)),

                        hintText: 'Enter landmark',
                        labelStyle: TextStyle(color: Colors.grey)

                    ),

                  ),
                ),
                SizedBox(height:8),
                companyLandmark == true && landmark.text.isEmpty?Text("Landmark is required",style:TextStyle(color:Colors.red,fontSize: 12)):Container()

              ],
            ),
          ),
          //---------------------------Mobile number--------------------------------
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,top: 5, ),
            child: Text("Mobile number",style: TextStyle(color: Get.theme.colorScheme.secondary,fontSize: 12),),
          ),
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,top: 15,bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Color(0xff8ba3bd)
                      ),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  // padding: EdgeInsets.all(8),

                  child: Center(
                    child: TextFormField(
                      controller: mobile_number,
                      maxLength: 10,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          counter: Offstage(),
                          contentPadding: EdgeInsets.only(left: 10),
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Color(0xff8ba3bd)),

                          //  prefixIcon: Icon(Icons.Location),
                          hintText: 'Enter mobile number',
                          // prefixIcon: Image.asset('assets/img/phone number.png'),
                          //  prefixIcon: Icon(Icons.phone),
                          labelStyle: TextStyle(color: Colors.grey)

                      ),

                    ),
                  ),
                ),
                SizedBox(height:8),

                mobileNumberValid == true && mobile_number.text.isEmpty?Text("Mobile number is required",style:TextStyle(color:Colors.red,fontSize: 12)):Container()

              ],
            ),
          ),
          // Padding(
          //   padding:  EdgeInsets.all(15.0),
          //   child: Container(
          //     height: 40,
          //     decoration: BoxDecoration(
          //       border: Border.all(
          //         color: Colors.grey
          //       ),
          //       borderRadius: BorderRadius.circular(5)
          //     ),
          //     padding: EdgeInsets.all(8),
          //
          //     child: TextFormField(
          //
          //       decoration: InputDecoration(
          //         border: InputBorder.none,
          //           prefixIcon: Icon(Icons.location_on_sharp),
          //           labelText: 'Pincode',
          //           labelStyle: TextStyle(color: Colors.grey)
          //
          //       ),
          //
          //     ),
          //   ),
          // ),
          // Padding(
          //   padding:  EdgeInsets.all(15.0),
          //   child: Container(
          //     height: 40,
          //     decoration: BoxDecoration(
          //       border: Border.all(
          //         color: Colors.grey
          //       ),
          //       borderRadius: BorderRadius.circular(5)
          //     ),
          //     padding: EdgeInsets.all(8),
          //
          //     child: TextFormField(
          //
          //       decoration: InputDecoration(
          //         border: InputBorder.none,
          //           labelText: 'Mobile number',
          //           prefixIcon: Icon(Icons.location_on_sharp),
          //
          //           labelStyle: TextStyle(color: Colors.grey)
          //
          //       ),
          //
          //     ),
          //   ),
          // ),

        ],
      ),
    );

  }
  //+++++++++++++++++++++STEP TWO+++++++++++++++++++++++++++++++++++++

  StepTwo()
  {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 10,),
          Container(child: Center(child: Text("Business Details",style: TextStyle(color:Get.theme.colorScheme.secondary,fontSize: 18),))),

          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,top: 20, ),
            child: Text("Add  your establishment",style: TextStyle(color: Get.theme.colorScheme.secondary,fontSize: 12),),
          ),
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,top: 10,
                bottom: 10),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Color(0xff8ba3bd)                  ),
                  borderRadius: BorderRadius.circular(5)
              ),
              padding: EdgeInsets.all(8),

              child: TextFormField(
                controller: establish,

                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText:'Add  your establishment',
                    hintStyle: TextStyle(color: Color(0xff8ba3bd)),

                    // label: Text("Company Name"),
                    // labelText: 'Company Name',
                    // prefixIcon: Icon(Icons.person),
                    // prefixIcon: Image.asset('assets/img/Company.png'),


                    labelStyle: TextStyle(color: Colors.grey)

                ),

              ),
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,top: 5, ),
            child: Text("Payment method",style: TextStyle(color: Get.theme.colorScheme.secondary,fontSize: 12),),
          ),
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,top: 15,bottom: 10),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Color(0xff8ba3bd)
                  ),
                  borderRadius: BorderRadius.circular(5)
              ),
              padding: EdgeInsets.all(8),

              child: TextFormField(
                controller: payment_method,
                maxLines: 1,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Payment method',
                    hintStyle: TextStyle(color: Color(0xff8ba3bd)),

                    //prefixIcon: Icon(Icons.location_on_sharp),
                    //  prefixIcon: Image.asset('assets/img/address.png'),


                    // prefixIcon: Container(
                    //   height: 5,
                    //   width: 5,
                    //   child: Image.asset('assets/img/address.png',height: 5,width: 5,fit: BoxFit.fill,),
                    // ),
                    labelStyle: TextStyle(color: Colors.grey)

                ),

              ),
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,top: 5, ),
            child: Text("Add awards",style: TextStyle(color: Get.theme.colorScheme.secondary,fontSize: 12),),
          ),
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,top: 15,bottom: 10),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Color(0xff8ba3bd)
                  ),
                  borderRadius: BorderRadius.circular(5)
              ),
              padding: EdgeInsets.all(8),

              child: TextFormField(
                controller: add_awards,

                decoration: InputDecoration(
                    border: InputBorder.none,
                    //  prefixIcon: Icon(Icons.location_on_sharp),
                    //  prefixIcon: Image.asset('assets/img/City , district .png'),


                    hintText: 'Add awards',
                    hintStyle: TextStyle(color: Color(0xff8ba3bd))

                ),

              ),
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,top: 5, ),
            child: Text("Add certificate",style: TextStyle(color: Get.theme.colorScheme.secondary,fontSize: 12),),
          ),
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,top: 15,bottom: 10),
            child: InkWell(
              onTap: () async {

                final result = await FilePicker.platform.pickFiles();
                if(result == null) return SizedBox();
                final file = result.files.first;
                print('+++++++++++++++SELECT CERTFIVATE+++++++++++++++++++++++++++++');

                print(file);
                if(file != null)
                {
                  print(file.name);
                  print(file.bytes);
                  print(file.size);
                  print(file.extension);
                  print(file.path);

                  setState(() {
                    cert = file.path;
                    file1 = file;
                    print("++++++++++++++++");
                    print(cert);
                    print(file1);//file1 is a global variable which i created

                  });
                }
              },
              child: Container(
                  height: 50,
                  width: 400,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Color(0xff8ba3bd)
                      ),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  padding: EdgeInsets.all(8),
                  child :Row(
                    children: [
                      Icon(Icons.note, color: Color(0xff8ba3bd)),
                      SizedBox(width: 10,),
                      file1 == null && cert_file == null ?
                      Text('Add certificate',style: TextStyle(color: Color(0xff8ba3bd)),):
                      file1!=null?
                      Flexible(child: Text("Certificate uploaded".toString(), style: TextStyle(overflow:TextOverflow.ellipsis,),maxLines: 1,)):
                      cert_file == null?
                      Text('Add certificate',style: TextStyle(color: Color(0xff8ba3bd)),):

                      Flexible(child: Text("Certificate uploaded".toString(), style: TextStyle(overflow:TextOverflow.ellipsis,),maxLines: 1,))
                    ],
                  )
                // child: TextFormField(
                //
                //   decoration: InputDecoration(
                //       border: InputBorder.none,
                //       //  prefixIcon: Icon(Icons.Location),
                //       // prefixIcon: Icon(Icons.location_on_sharp),
                //      // prefixIcon: Image.asset('assets/img/City , district .png'),
                //       hintStyle: TextStyle(color: Color(0xff8ba3bd)),
                //
                //
                //       hintText: 'Add certificate',
                //       labelStyle: TextStyle(color: Colors.grey)
                //
                //   ),
                //
                // ),
              ),
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,top: 5, ),
            child: Text("Image upload",style: TextStyle(color: Get.theme.colorScheme.secondary,fontSize: 12),),
          ),
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,top: 10, bottom: 10),
            child: InkWell(
              onTap: ForProfile,

              child: Container(
                // height: 50,
                  width: 400,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Color(0xff8ba3bd)
                      ),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  padding: EdgeInsets.all(10),

                  child:Imageupload==null && img == null ?
                  Row(
                    children: [
                      Icon(Icons.upload,
                          color: Color(0xff8ba3bd)
                      ),
                      SizedBox(width: 10,),
                      Text('Image upload',style: TextStyle(color: Color(0xff8ba3bd)))

                    ],
                  ):
                  Imageupload !=null ?Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(Imageupload)
                            )
                        ),
                      ),
                    ],
                  ):
                  img == null?
                  Row(
                    children: [
                      Icon(Icons.upload,
                          color: Color(0xff8ba3bd)
                      ),
                      SizedBox(width: 10,),
                      Text('Image upload',style: TextStyle(color: Color(0xff8ba3bd)))

                    ],
                  ):
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(img.toString())
                            )
                        ),
                      ),
                    ],
                  )

              ),
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,top: 5, ),
            child: Text("video upload",style: TextStyle(color: Get.theme.colorScheme.secondary,fontSize: 12),),
          ),
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,top: 10, bottom: 10),
            child: InkWell(
              onTap: ForVideoUpload,

              child: Container(
                // height: 50,
                  width: 400,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Color(0xff8ba3bd)
                      ),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  padding: EdgeInsets.all(10),

                  child:videoupload==null && video==null?
                  Row(
                    children: [
                      Icon(Icons.upload,color: Color(0xff8ba3bd)
                        ,),
                      SizedBox(width: 10,),
                      Text('video upload',style: TextStyle(color: Color(0xff8ba3bd)),),

                    ],
                  ):
                  videoupload!= null ?
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        fit: BoxFit.cover,
                        child: SizedBox(
                          height: 120,
                          width: 140,
                          child: AspectRatio(
                            aspectRatio: 20 / 10,
                            // aspectRatio: _videoPlayerController.value.aspectRatio,
                            child: VideoPlayer(_videoPlayerController),
                          ),
                        ),
                      ),
                    ],
                  ):
                  video==null ?
                  Row(
                    children: [
                      Icon(Icons.upload,color: Color(0xff8ba3bd)
                        ,),
                      SizedBox(width: 10,),
                      Text('video upload',style: TextStyle(color: Color(0xff8ba3bd)),),

                    ],
                  ):
                  Container(
                    width: 120,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        if(video != null)
                          PlayerController.value.isInitialized ?
                          FittedBox(
                            fit: BoxFit.cover,
                            child: SizedBox(
                              height: 120,
                              width: 140,
                              child: AspectRatio(
                                aspectRatio: 20 / 10,
                                // aspectRatio: _videoPlayerController.value.aspectRatio,
                                child: VideoPlayer(PlayerController),
                              ),
                            ),
                          ):
                          Row(
                            children: [
                              Icon(Icons.upload,color: Color(0xff8ba3bd)
                                ,),
                              SizedBox(width: 10,),
                              Text('video upload',style: TextStyle(color: Color(0xff8ba3bd)),),

                            ],
                          )
                      ],
                    ),
                  )

                // Container(
                //   child: Column(
                //     children: <Widget>[
                //       if(videoupload != null)
                //         _videoPlayerController.value.isInitialized
                //             ? AspectRatio(
                //
                //           aspectRatio: _videoPlayerController.value.aspectRatio,
                //           child: VideoPlayer(_videoPlayerController),
                //         ):
                //         Row(
                //           children: [
                //             Icon(Icons.upload,color: Color(0xff8ba3bd)
                //               ,),
                //             SizedBox(width: 10,),
                //             Text('video upload',style: TextStyle(color: Color(0xff8ba3bd)),),
                //
                //           ],
                //         )
                //     ],
                //   ),
                // ),



                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Container(
                //       height: 50,
                //       width: 50,
                //       decoration: BoxDecoration(
                //           image: DecorationImage(
                //               fit: BoxFit.cover,
                //               image: FileImage(videoupload)
                //           )
                //       ),
                //     ),
                //   ],
                // ):
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Container(
                //       height: 50,
                //       width: 50,
                //       decoration: BoxDecoration(
                //           image: DecorationImage(
                //               fit: BoxFit.cover,
                //               image: NetworkImage(video.toString())
                //           )
                //       ),
                //     ),
                //   ],
                // ),

              ),
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,top: 5, ),
            child: Text("Business website",style: TextStyle(color: Get.theme.colorScheme.secondary,fontSize: 12),),
          ),
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,top: 15,bottom: 10),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Color(0xff8ba3bd)
                  ),
                  borderRadius: BorderRadius.circular(5)
              ),
              padding: EdgeInsets.all(8),

              child: TextFormField(
                controller: website,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    //  prefixIcon: Icon(Icons.Location),
                    hintStyle: TextStyle(color: Color(0xff8ba3bd)),

                    hintText: 'Business website',
                    // prefixIcon: Image.asset('assets/img/phone number.png'),
                    //  prefixIcon: Icon(Icons.phone),
                    labelStyle: TextStyle(color: Colors.grey)

                ),

              ),
            ),
          ),
          // Padding(
          //   padding:  EdgeInsets.all(15.0),
          //   child: Container(
          //     height: 40,
          //     decoration: BoxDecoration(
          //       border: Border.all(
          //         color: Colors.grey
          //       ),
          //       borderRadius: BorderRadius.circular(5)
          //     ),
          //     padding: EdgeInsets.all(8),
          //
          //     child: TextFormField(
          //
          //       decoration: InputDecoration(
          //         border: InputBorder.none,
          //           prefixIcon: Icon(Icons.location_on_sharp),
          //           labelText: 'Pincode',
          //           labelStyle: TextStyle(color: Colors.grey)
          //
          //       ),
          //
          //     ),
          //   ),
          // ),
          // Padding(
          //   padding:  EdgeInsets.all(15.0),
          //   child: Container(
          //     height: 40,
          //     decoration: BoxDecoration(
          //       border: Border.all(
          //         color: Colors.grey
          //       ),
          //       borderRadius: BorderRadius.circular(5)
          //     ),
          //     padding: EdgeInsets.all(8),
          //
          //     child: TextFormField(
          //
          //       decoration: InputDecoration(
          //         border: InputBorder.none,
          //           labelText: 'Mobile number',
          //           prefixIcon: Icon(Icons.location_on_sharp),
          //
          //           labelStyle: TextStyle(color: Colors.grey)
          //
          //       ),
          //
          //     ),
          //   ),
          // ),




        ],
      ),
    );

  }
  //+++++++++++++++++++++STEP THREE+++++++++++++++++++++++++++++++++++++

  StepThree()
  {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 10,),
          Container(child: Center(child: Text("Social Media Link Upload",style: TextStyle(color:Get.theme.colorScheme.secondary,fontSize: 18),))),
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,top: 20, ),
            child: Text("Facebook link",style: TextStyle(color: Get.theme.colorScheme.secondary,fontSize: 12),),
          ),
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,top: 10,
                bottom: 10),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                  border: Border.all(
                      color:Color(0xff8ba3bd)
                  ),
                  borderRadius: BorderRadius.circular(5)
              ),
              padding: EdgeInsets.all(8),

              child: TextFormField(
                controller: facebook,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText:'Facebook link',
                    // label: Text("Company Name"),
                    // labelText: 'Company Name',
                    prefixIcon: Icon(FontAwesomeIcons.facebook,color: Colors.blueAccent.shade700,),
                    // prefixIcon: Image.asset('assets/img/Company.png'),


                    hintStyle:TextStyle(color: Color(0xff8ba3bd))

                ),

              ),
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,top: 5, ),
            child: Text("Instagram link",style: TextStyle(color: Get.theme.colorScheme.secondary,fontSize: 12),),
          ),
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,top: 15,bottom: 10),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Color(0xff8ba3bd)
                  ),
                  borderRadius: BorderRadius.circular(5)
              ),
              padding: EdgeInsets.all(8),

              child: TextFormField(
                controller: instagram,
                maxLines: 1,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Instagram link',
                    prefixIcon: Icon(FontAwesomeIcons.instagram,color: Colors.red,),
                    //  prefixIcon: Image.asset('assets/img/address.png'),


                    // prefixIcon: Container(
                    //   height: 5,
                    //   width: 5,
                    //   child: Image.asset('assets/img/address.png',height: 5,width: 5,fit: BoxFit.fill,),
                    // ),
                    hintStyle:TextStyle(color: Color(0xff8ba3bd))

                ),

              ),
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,top: 5, ),
            child: Text("Twitter link",style: TextStyle(color: Get.theme.colorScheme.secondary,fontSize: 12),),
          ),
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,top: 15,bottom: 10),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Color(0xff8ba3bd)
                  ),
                  borderRadius: BorderRadius.circular(5)
              ),
              padding: EdgeInsets.all(8),

              child: TextFormField(
                controller: twitter,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(FontAwesomeIcons.twitter,color: Colors.blue,),
                    //  prefixIcon: Image.asset('assets/img/City , district .png'),


                    hintText: 'Twitter',
                    hintStyle:TextStyle(color: Color(0xff8ba3bd))

                ),

              ),
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,top: 5, ),
            child: Text("Youtube link",style: TextStyle(color: Get.theme.colorScheme.secondary,fontSize: 12),),
          ),
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,top: 15,bottom: 10),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Color(0xff8ba3bd)
                  ),
                  borderRadius: BorderRadius.circular(5)
              ),
              padding: EdgeInsets.all(8),

              child: TextFormField(
                controller: youtube,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(FontAwesomeIcons.youtube,color: Colors.red,),
                    // prefixIcon: Icon(Icons.location_on_sharp),
                    // prefixIcon: Image.asset('assets/img/City , district .png'),


                    hintText: 'Youtube',
                    hintStyle:TextStyle(color: Color(0xff8ba3bd))

                ),

              ),
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,top: 5, ),
            child: Text("Linkedin link",style: TextStyle(color: Get.theme.colorScheme.secondary,fontSize: 12),),
          ),
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,top: 15,bottom: 10),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Color(0xff8ba3bd)
                  ),
                  borderRadius: BorderRadius.circular(5)
              ),
              padding: EdgeInsets.all(8),

              child: TextFormField(
                controller: linkedin,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(FontAwesomeIcons.linkedinIn,color: Colors.blue,),
                    // prefixIcon: Icon(Icons.location_on_sharp),
                    // prefixIcon: Image.asset('assets/img/City , district .png'),

                    hintText: 'Linkedin link',
                    hintStyle:TextStyle(color: Color(0xff8ba3bd))

                ),

              ),
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,top: 5, ),
            child: Text("Yahoo link",style: TextStyle(color: Get.theme.colorScheme.secondary,fontSize: 12),),
          ),
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,top: 15,bottom: 10),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Color(0xff8ba3bd)
                  ),
                  borderRadius: BorderRadius.circular(5)
              ),
              padding: EdgeInsets.all(8),

              child: TextFormField(
                controller: yahoo,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(FontAwesomeIcons.yahoo,color: Colors.deepPurple.shade700,),
                    // prefixIcon: Icon(Icons.location_on_sharp),
                    //  prefixIcon: Image.asset('assets/img/landmark.png'),

                    hintText: 'Yahoo',
                    hintStyle:TextStyle(color: Color(0xff8ba3bd))

                ),

              ),
            ),
          ),
          // Padding(
          //   padding:  EdgeInsets.only(left: 20.0,right: 20,top: 15,bottom: 10),
          //   child: Container(
          //     height: 50,
          //     decoration: BoxDecoration(
          //         border: Border.all(
          //             color: Colors.grey
          //         ),
          //         borderRadius: BorderRadius.circular(5)
          //     ),
          //     padding: EdgeInsets.all(8),
          //
          //     child: TextFormField(
          //
          //       decoration: InputDecoration(
          //           border: InputBorder.none,
          //           //  prefixIcon: Icon(Icons.Location),
          //           hintText: 'Business website',
          //          // prefixIcon: Image.asset('assets/img/phone number.png'),
          //           //  prefixIcon: Icon(Icons.phone),
          //           labelStyle: TextStyle(color: Colors.grey)
          //
          //       ),
          //
          //     ),
          //   ),
          // ),
          // Padding(
          //   padding:  EdgeInsets.all(15.0),
          //   child: Container(
          //     height: 40,
          //     decoration: BoxDecoration(
          //       border: Border.all(
          //         color: Colors.grey
          //       ),
          //       borderRadius: BorderRadius.circular(5)
          //     ),
          //     padding: EdgeInsets.all(8),
          //
          //     child: TextFormField(
          //
          //       decoration: InputDecoration(
          //         border: InputBorder.none,
          //           prefixIcon: Icon(Icons.location_on_sharp),
          //           labelText: 'Pincode',
          //           labelStyle: TextStyle(color: Colors.grey)
          //
          //       ),
          //
          //     ),
          //   ),
          // ),
          // Padding(
          //   padding:  EdgeInsets.all(15.0),
          //   child: Container(
          //     height: 40,
          //     decoration: BoxDecoration(
          //       border: Border.all(
          //         color: Colors.grey
          //       ),
          //       borderRadius: BorderRadius.circular(5)
          //     ),
          //     padding: EdgeInsets.all(8),
          //
          //     child: TextFormField(
          //
          //       decoration: InputDecoration(
          //         border: InputBorder.none,
          //           labelText: 'Mobile number',
          //           prefixIcon: Icon(Icons.location_on_sharp),
          //
          //           labelStyle: TextStyle(color: Colors.grey)
          //
          //       ),
          //
          //     ),
          //   ),
          // ),

        ],
      ),
    );

  }
  //+++++++++++++++++++++STEP FOUR+++++++++++++++++++++++++++++++++++++

  StepFour()
  {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 10,),
          Container(child: Center(child: Text("GST",style: TextStyle(color:Get.theme.colorScheme.secondary,fontSize: 18),))),
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,top: 20, ),
            child: Text("Reigistered with GSTN",style: TextStyle(color: Get.theme.colorScheme.secondary,fontSize: 12),),
          ),
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,top: 10,
                bottom: 10),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Color(0xff8ba3bd)
                  ),
                  borderRadius: BorderRadius.circular(5)
              ),
              padding: EdgeInsets.all(8),

              child: TextFormField(
                controller: register_gstn,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText:'Reigistered with GSTN',
                    // label: Text("Company Name"),
                    // labelText: 'Company Name',
                    // prefixIcon: Icon(Icons.person),
                    // prefixIcon: Image.asset('assets/img/Company.png'),


                    hintStyle: TextStyle(color: Color(0xff8ba3bd))

                ),

              ),
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,top: 5, ),
            child: Text("Registered address under GST",style: TextStyle(color: Get.theme.colorScheme.secondary,fontSize: 12),),
          ),

          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,top: 15,bottom: 10),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Color(0xff8ba3bd)
                  ),
                  borderRadius: BorderRadius.circular(5)
              ),
              padding: EdgeInsets.all(8),

              child: TextFormField(
                controller: register_under_gst,
                maxLines: 1,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Registered address under GST',
                    //prefixIcon: Icon(Icons.location_on_sharp),
                    //  prefixIcon: Image.asset('assets/img/address.png'),


                    // prefixIcon: Container(
                    //   height: 5,
                    //   width: 5,
                    //   child: Image.asset('assets/img/address.png',height: 5,width: 5,fit: BoxFit.fill,),
                    // ),
                    hintStyle: TextStyle(color:Color(0xff8ba3bd))

                ),

              ),
            ),
          ),
          // Padding(
          //   padding:  EdgeInsets.only(left: 20.0,right: 20,top: 5, ),
          //   child: Text("Pincode",style: TextStyle(color: Get.theme.colorScheme.secondary,fontSize: 12),),
          // ),
          // Padding(
          //   padding:  EdgeInsets.only(left: 20.0,right: 20,top: 15,bottom: 10),
          //   child: Container(
          //     height: 50,
          //     decoration: BoxDecoration(
          //         border: Border.all(
          //             color: Color(0xff8ba3bd)
          //         ),
          //         borderRadius: BorderRadius.circular(5)
          //     ),
          //     padding: EdgeInsets.all(8),
          //
          //     child: TextFormField(
          //       controller: register_pincode,
          //
          //       decoration: InputDecoration(
          //           border: InputBorder.none,
          //           //  prefixIcon: Icon(Icons.location_on_sharp),
          //           //  prefixIcon: Image.asset('assets/img/City , district .png'),
          //
          //
          //           hintText: 'Pincode',
          //           hintStyle: TextStyle(color: Color(0xff8ba3bd))
          //
          //       ),
          //
          //     ),
          //   ),
          // ),
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,top: 5, ),
            child: Text("GST no/ UIN of registred",style: TextStyle(color: Get.theme.colorScheme.secondary,fontSize: 12),),
          ),

          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,top: 15,bottom: 10),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Color(0xff8ba3bd)
                  ),
                  borderRadius: BorderRadius.circular(5)
              ),
              padding: EdgeInsets.all(8),

              child: TextFormField(
                controller: gstno,

                decoration: InputDecoration(
                    border: InputBorder.none,
                    //  prefixIcon: Icon(Icons.Location),
                    // prefixIcon: Icon(Icons.location_on_sharp),
                    // prefixIcon: Image.asset('assets/img/City , district .png'),


                    hintText: 'GST no/ UIN of registred',
                    hintStyle: TextStyle(color: Color(0xff8ba3bd))

                ),

              ),
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,top: 5, ),
            child: Text("PAN number",style: TextStyle(color: Get.theme.colorScheme.secondary,fontSize: 12),),
          ),
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,top: 15,bottom: 10),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Color(0xff8ba3bd)
                  ),
                  borderRadius: BorderRadius.circular(5)
              ),
              padding: EdgeInsets.all(8),

              child: TextFormField(
                controller: pan_umber,

                decoration: InputDecoration(
                    border: InputBorder.none,
                    //  prefixIcon: Icon(Icons.Location),
                    hintText: 'PAN number',
                    // prefixIcon: Image.asset('assets/img/phone number.png'),
                    //  prefixIcon: Icon(Icons.phone),
                    hintStyle: TextStyle(color:Color(0xff8ba3bd))

                ),

              ),
            ),
          ),
          // Padding(
          //   padding:  EdgeInsets.all(15.0),
          //   child: Container(
          //     height: 40,
          //     decoration: BoxDecoration(
          //       border: Border.all(
          //         color: Colors.grey
          //       ),
          //       borderRadius: BorderRadius.circular(5)
          //     ),
          //     padding: EdgeInsets.all(8),
          //
          //     child: TextFormField(
          //
          //       decoration: InputDecoration(
          //         border: InputBorder.none,
          //           prefixIcon: Icon(Icons.location_on_sharp),
          //           labelText: 'Pincode',
          //           labelStyle: TextStyle(color: Colors.grey)
          //
          //       ),
          //
          //     ),
          //   ),
          // ),
          // Padding(
          //   padding:  EdgeInsets.all(15.0),
          //   child: Container(
          //     height: 40,
          //     decoration: BoxDecoration(
          //       border: Border.all(
          //         color: Colors.grey
          //       ),
          //       borderRadius: BorderRadius.circular(5)
          //     ),
          //     padding: EdgeInsets.all(8),
          //
          //     child: TextFormField(
          //
          //       decoration: InputDecoration(
          //         border: InputBorder.none,
          //           labelText: 'Mobile number',
          //           prefixIcon: Icon(Icons.location_on_sharp),
          //
          //           labelStyle: TextStyle(color: Colors.grey)
          //
          //       ),
          //
          //     ),
          //   ),
          // ),




        ],
      ),
    );

  }
  //+++++++++++++++++++++STEP FIVE+++++++++++++++++++++++++++++++++++++

  StepFive()
  {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 10,),
          Container(child: Center(child: Text("KYC",style: TextStyle(color:Get.theme.colorScheme.secondary,fontSize: 18),))),
          //_______________PAN CARD_____________________________
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,top: 20, ),
            child: Text("PAN card",style: TextStyle(color: Get.theme.colorScheme.secondary,fontSize: 12),),
          ),
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,top: 10, bottom: 10),
            child: InkWell(

              onTap: ()
              {
                setState(() {
                  pan_image = true;
                  driving_license = false;
                  passport = false;
                  llp_number = false;
                  company_licence = false;
                  liquor_license = false;
                  trade_license = false;
                  other_document = false;
                  fssai = false;
                  _passport = false;

                });
                ForPan();
              },

              child: Container(
                // height: 50,
                  width: 400,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Color(0xff8ba3bd)
                      ),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  padding: EdgeInsets.all(10),

                  child:Pan==null && pan_img == null? Row(
                    children: [
                      Icon(Icons.upload, color: Color(0xff8ba3bd)),
                      SizedBox(width: 10,),
                      Text('PAN card number',style: TextStyle(color: Color(0xff8ba3bd)),)

                    ],
                  ):Pan!=null?
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(Pan)
                            )
                        ),
                      ),
                    ],
                  ):
                  pan_img ==null ?
                  Row(
                    children: [
                      Icon(Icons.upload, color: Color(0xff8ba3bd)),
                      SizedBox(width: 10,),
                      Text('PAN card number',style: TextStyle(color: Color(0xff8ba3bd)),)

                    ],
                  ):Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(pan_img.toString())
                            )
                        ),
                      ),
                    ],
                  )

              ),
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,top: 5, ),
            child: Text("Driving license",style: TextStyle(color: Get.theme.colorScheme.secondary,fontSize: 12),),
          ),
          //_______________Driving license_____________________________

          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,top: 10, bottom: 10),
            child: InkWell(
              onTap: ()
              {
                setState(() {
                  driving_license = true;
                  pan_image = false;
                  passport = false;
                  llp_number = false;
                  company_licence = false;
                  liquor_license = false;
                  trade_license = false;
                  other_document = false;
                  fssai = false;
                  _passport = false;
                });
                ForDriving();
              },

              child: Container(
                // height: 50,
                  width: 400,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Color(0xff8ba3bd)
                      ),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  padding: EdgeInsets.all(10),

                  child:driving==null && drive_img == null? Row(
                    children: [
                      Icon(Icons.upload, color: Color(0xff8ba3bd)),
                      SizedBox(width: 10,),
                      Text('Driving licence no',style: TextStyle(color: Color(0xff8ba3bd)))

                    ],
                  ):
                  driving !=null?
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(driving)
                            )
                        ),
                      ),
                    ],
                  ):
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(drive_img.toString())
                            )
                        ),
                      ),
                    ],
                  )

              ),
            ),
          ),
          //---------------Passport------------------------------------
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,top: 5, ),
            child: Text("Passport",style: TextStyle(color: Get.theme.colorScheme.secondary,fontSize: 12),),
          ),
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,top: 10, bottom: 10),
            child: InkWell(
              onTap: ()
              {
                setState(() {
                  _passport = true;
                  pan_image = false;
                  driving_license = false;
                  llp_number = false;
                  company_licence = false;
                  liquor_license = false;
                  trade_license = false;
                  other_document = false;
                  fssai = false;

                });
                ForPassport();
              },


              child: Container(
                // height: 50,
                  width: 400,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color:Color(0xff8ba3bd)
                      ),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  padding: EdgeInsets.all(10),

                  child:passport_file==null && passport_img==null? Row(
                    children: [
                      Icon(Icons.upload, color: Color(0xff8ba3bd)),
                      SizedBox(width: 10,),
                      Text('Passport',style: TextStyle(color: Color(0xff8ba3bd)))

                    ],
                  ):
                  passport_file !=null ?
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(passport_file)
                            )
                        ),
                      ),
                    ],
                  ):
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(passport_img.toString())
                            )
                        ),
                      ),
                    ],
                  )


              ),
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,top: 5, ),
            child: Text("Business llp number",style: TextStyle(color: Get.theme.colorScheme.secondary,fontSize: 12),),
          ),

          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,top: 10, bottom: 10),
            child: InkWell(
              onTap: ()
              {
                setState(() {
                  llp_number = true;
                  _passport = false;
                  pan_image = false;
                  driving_license = false;
                  company_licence = false;
                  liquor_license = false;
                  trade_license = false;
                  other_document = false;
                  fssai = false;

                });
                Business();
              },
              child: Container(
                // height: 50,
                  width: 400,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Color(0xff8ba3bd)
                      ),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  padding: EdgeInsets.all(10),

                  child:llp==null && llp_img == null ? Row(
                    children: [
                      Icon(Icons.upload, color: Color(0xff8ba3bd),),
                      SizedBox(width: 10,),
                      Text('Business llp number',style: TextStyle(color: Color(0xff8ba3bd)))

                    ],
                  ):llp!=null ?
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(llp)
                            )
                        ),
                      ),
                    ],
                  ):
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(llp_img.toString())
                            )
                        ),
                      ),
                    ],
                  )

              ),
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,top: 5, ),
            child: Text("Company licence number",style: TextStyle(color: Get.theme.colorScheme.secondary,fontSize: 12),),
          ),
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,top: 10, bottom: 10),
            child: InkWell(
              onTap: ()
              {
                setState(() {
                  company_licence = true;
                  llp_number = false;
                  _passport = false;
                  pan_image = false;
                  driving_license = false;
                  liquor_license = false;
                  trade_license = false;
                  other_document = false;
                  fssai = false;

                });
                Companynumber();
              },


              child: Container(
                // height: 50,
                  width: 400,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Color(0xff8ba3bd)
                      ),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  padding: EdgeInsets.all(10),

                  child:company==null && compantylic_img == null? Row(
                    children: [
                      Icon(Icons.upload, color: Color(0xff8ba3bd)),
                      SizedBox(width: 10,),
                      Text('Company licence number',style: TextStyle(color: Color(0xff8ba3bd)))

                    ],
                  ):
                  company !=null ?Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(company)
                            )
                        ),
                      ),
                    ],
                  ):
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(compantylic_img.toString())
                            )
                        ),
                      ),
                    ],
                  )

              ),
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,top: 5, ),
            child: Text("FSSAI licence number",style: TextStyle(color: Get.theme.colorScheme.secondary,fontSize: 12),),
          ),
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,top: 10, bottom: 10),
            child: InkWell(
              onTap: ()
              {
                setState(() {
                  fssai = true;
                  company_licence = false;
                  llp_number = false;
                  _passport = false;
                  pan_image = false;
                  driving_license = false;
                  liquor_license = false;
                  trade_license = false;
                  other_document = false;

                });
                ForFssai();
              },


              child: Container(
                // height: 50,
                  width: 400,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Color(0xff8ba3bd)
                      ),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  padding: EdgeInsets.all(10),

                  child:Fssai==null && fssai_img == null? Row(
                    children: [
                      Icon(Icons.upload, color: Color(0xff8ba3bd)),
                      SizedBox(width: 10,),
                      Text('FSSAI licence number',style: TextStyle(color: Color(0xff8ba3bd)))

                    ],
                  ): Fssai !=null ?
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(Fssai)
                            )
                        ),
                      ),
                    ],
                  ):
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(fssai_img.toString())
                            )
                        ),
                      ),
                    ],
                  )


              ),
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,top: 5, ),
            child: Text("Liquor licence number",style: TextStyle(color: Get.theme.colorScheme.secondary,fontSize: 12),),
          ),
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,top: 10, bottom: 10),
            child: InkWell(
              onTap: ()
              {
                setState(() {
                  liquor_license = true;
                  fssai = false;
                  company_licence = false;
                  llp_number = false;
                  _passport = false;
                  pan_image = false;
                  driving_license = false;
                  trade_license = false;
                  other_document = false;

                });
                Liquor();
              },


              child: Container(
                // height: 50,
                  width: 400,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Color(0xff8ba3bd)
                      ),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  padding: EdgeInsets.all(10),

                  child:liquir==null && liq_img == null ? Row(
                    children: [
                      Icon(Icons.upload, color: Color(0xff8ba3bd)),
                      SizedBox(width: 10,),
                      Text('Liquor licence number',style: TextStyle(color: Color(0xff8ba3bd)))

                    ],
                  ):liquir !=null?
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(liquir)
                            )
                        ),
                      ),
                    ],
                  ):
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(liq_img.toString())
                            )
                        ),
                      ),
                    ],
                  )

              ),
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,top: 5, ),
            child: Text("Trade licence number",style: TextStyle(color: Get.theme.colorScheme.secondary,fontSize: 12),),
          ),

          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,top: 10, bottom: 10),
            child: InkWell(
              onTap: ()
              {
                setState(() {
                  trade_license = true;
                  liquor_license = false;
                  fssai = false;
                  company_licence = false;
                  llp_number = false;
                  _passport = false;
                  pan_image = false;
                  driving_license = false;
                  other_document = false;

                });
                Trade();


              },
              child: Container(
                // height: 50,
                  width: 400,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Color(0xff8ba3bd)
                      ),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  padding: EdgeInsets.all(10),

                  child:trade==null && trade_img == null ? Row(
                    children: [
                      Icon(Icons.upload, color: Color(0xff8ba3bd)),
                      SizedBox(width: 10,),
                      Text('Trade licence number',style: TextStyle(color: Color(0xff8ba3bd)))

                    ],
                  ):
                  trade!=null?
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(trade)
                            )
                        ),
                      ),
                    ],
                  ):
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(trade_img.toString())
                            )
                        ),
                      ),
                    ],
                  )

              ),
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,top: 5, ),
            child: Text("Other documents",style: TextStyle(color: Get.theme.colorScheme.secondary,fontSize: 12),),
          ),
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,top: 10, bottom: 10),
            child: InkWell(
              onTap: ()
              {
                setState(() {
                  other_document = true;
                  trade_license = false;
                  liquor_license = false;
                  fssai = false;
                  company_licence = false;
                  llp_number = false;
                  _passport = false;
                  pan_image = false;
                  driving_license = false;

                });
                Document();
              },


              child: Container(
                // height: 50,
                  width: 400,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Color(0xff8ba3bd)
                      ),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  padding: EdgeInsets.all(10),

                  child:documnet==null && other_docu_img == null ? Row(
                    children: [
                      Icon(Icons.upload, color: Color(0xff8ba3bd)),
                      SizedBox(width: 10,),
                      Text('Other documents',style: TextStyle(color: Color(0xff8ba3bd)))
                    ],
                  ): documnet !=null?
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(documnet)
                            )
                        ),
                      ),
                    ],
                  ):
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(other_docu_img.toString())
                            )
                        ),
                      ),
                    ],
                  )

              ),
            ),
          ),
        ],
      ),
    );

  }
  //+++++++++++++++++++++STEP SIX+++++++++++++++++++++++++++++++++++++

  StepSix()
  {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 20,),
          Padding(
            padding:  EdgeInsets.only(left: 20.0),
            child: Text("Promote Now",style: TextStyle(color:Get.theme.colorScheme.secondary,fontSize: 18),),
          ),
          Container(
            height: 200,
            child: FutureBuilder(
                future: allPlans,
                builder: (context,snapshot) {
                  if(snapshot.hasData)
                  {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data['data'].length,
                        itemBuilder: (context,index) {
                          var data = index;

                          // if(promote_data == snapshot.data['data'][index]['plan_name'] )
                          // {
                          // selected = index;
                          // }
                          var itx;
                          int dat_id;
                          itx =index;
                          return Container(

                            padding:  EdgeInsets.only(left: 0.0,top: 10),
                            decoration:BoxDecoration(
                              color: Colors.white,
                              // border:Border.all(
                              //     color: Colors.grey.shade300
                              // ),
                              borderRadius: BorderRadius.circular(5),


                            ),
                            child:
                            Column(
                              children: [
                                ListTile(
                                  title: Text(snapshot.data['data'][index]['plan_name'].toString()),
                                  leading: Radio(
                                    activeColor: Get.theme.colorScheme.secondary,
                                    value: data,
                                    groupValue: selected,
                                    onChanged: ( ind) {
                                      print("CHECK PLAN");
                                      print(plan_status);
                                      if(plan_status == null)
                                      {
                                        setState(() {
                                          selected = ind;
                                          ctxx = index;
                                          plan = snapshot.data['data'][index]['plan_name'].toString();
                                          plan_id = snapshot.data['data'][index]['id'].toString();
                                          plan_desc = snapshot.data['data'][index]['description'].toString();
                                          plan_duration = snapshot.data['data'][index]['plan_duration'].toString();
                                          plan_price = snapshot.data['data'][index]['plan_price'].toString();
                                          promote = "Per week";
                                          print("check");
                                          print(index);
                                          print(selected);
                                          print(plan);

                                        });
                                      }
                                      else
                                      {
                                        Fluttertoast.showToast(
                                            msg:"Your plan will  completes on "+endDate.toString(),
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor:Get.theme.colorScheme.secondary,
                                            textColor: Colors.white,
                                            fontSize: 14.0
                                        );
                                      }


                                    },

                                  ),
                                ),
                                // index == selected?
                                // Padding(
                                //   padding:  EdgeInsets.only(left: 35.0),
                                //   child: Container(
                                //          width: 400,
                                //     child:
                                //     Row(
                                //       mainAxisAlignment : MainAxisAlignment.spaceBetween,
                                //       children: [
                                //         Text("₹ "+snapshot.data['data'][index]['plan_price'].toString()),
                                //         Padding(
                                //           padding:  EdgeInsets.all(8.0),
                                //           child: Container(
                                //               padding:  EdgeInsets.all(10.0),
                                //
                                //               decoration:BoxDecoration(
                                //                 color: Colors.blue.shade700,
                                //                 border:Border.all(
                                //                     color: Colors.grey.shade300
                                //                 ),
                                //                 borderRadius: BorderRadius.circular(5),
                                //
                                //
                                //               ),
                                //               child: Text("Pay Now",style: TextStyle(color: Colors.white),)),
                                //         ),
                                //
                                //       ],
                                //     ),
                                //   ),
                                // ): Container()
                              ],
                            ),
                          );
                        }
                    );
                  }
                  else
                  {
                    return Container();
                  }

                }
            ),
          ),
          //   InkWell(
          //   onTap: ()
          //   {
          //    // Get.toNamed(Routes.CHECKOUT);
          //
          //
          //     // openCheckout();
          //     // Get.lazyPut<RazorPayController>(
          //     //       () => RazorPayController(),
          //     //
          //     // );
          //
          //    // GetPage(name: Routes.CHECKOUT, page: () => CheckoutView(), binding: CheckoutBinding(), middlewares: [AuthMiddleware()]);
          //   },
          //   child: Container(
          //     width: 200,
          //     padding: EdgeInsets.all(15),
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(5),
          //       color: Colors.grey.shade200
          //     ),
          //     child:
          //     Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         Text("Pay now"),
          //         Text("₹ 120"),
          //       ],
          //     ),
          //   ),
          // ),
          //   ListTile(
          //   title:  Text('Per month'),
          //   leading: Radio(
          //     value: selt!=null && selt == 2?selt:2,
          //     activeColor: Get.theme.colorScheme.secondary,
          //
          //     groupValue: selected,
          //     onChanged: ( value) {
          //       setState(() {
          //         selected = value;
          //         promote = "Per month";
          //
          //       });
          //     },
          //   ),
          // ),
          //   ListTile(
          //   title:  Text('Per year'),
          //   leading: Radio(
          //     value: selt!=null && selt == 3?selt:3,
          //     activeColor: Get.theme.colorScheme.secondary,
          //
          //     groupValue: selected,
          //     onChanged: ( value) {
          //       setState(() {
          //         selected = value;
          //         promote = "Per year";
          //
          //
          //       });
          //     },
          //   ),
          // ),
          SizedBox(height: 10,),
          Padding(
            padding:  EdgeInsets.only(left: 20.0),
            child: Text("Benefits of get:",style: TextStyle(color:Get.theme.colorScheme.secondary,fontSize: 18),),
          ),
          ListTile(
            title:  Text('Search by name & category'),
            leading: Radio(
              activeColor: Get.theme.colorScheme.secondary,
              value: 4,
              groupValue: num,
              onChanged: ( value) {
                setState(() {
                  num = value;
                  benefits ="Search by name & category";
                });
              },
            ),
          ),
          ListTile(
            title:  Text('Premium listing'),
            leading: Radio(
              value: 5,
              activeColor: Get.theme.colorScheme.secondary,

              groupValue: num,
              onChanged: ( value) {
                setState(() {
                  num = value;
                  benefits ="Premium listing";

                });
              },
            ),
          ),
          ListTile(
            title:  Text('Business leads'),
            leading: Radio(
              value: 6,
              activeColor: Get.theme.colorScheme.secondary,
              groupValue: num,
              onChanged: ( value) {
                setState(() {
                  num = value;
                  benefits = "Business leads";

                });
              },
            ),
          ),
          ListTile(
            title:  Text('Verified seal(view)'),
            leading: Radio(
              value: 7,
              activeColor: Get.theme.colorScheme.secondary,

              groupValue: num,
              onChanged: ( value) {
                setState(() {
                  num = value;
                  benefits = "Verified seal(view)";

                });
              },
            ),
          ),
          ListTile(
            title:  Text('Digital catelogue(view)'),
            leading: Radio(
              value: 8,
              activeColor: Get.theme.colorScheme.secondary,

              groupValue: num,
              onChanged: ( value) {
                setState(() {
                  num = value;
                  benefits = "Digital catelogue(view)";

                });
              },
            ),
          ),




        ],
      ),
    );

  }

  //+++++++++++++++++++++STEP SEVEN+++++++++++++++++++++++++++++++++++++

  StepSeven()
  {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 10,),
          Container(child: Center(child: Text("Service Details",style: TextStyle(color:Get.theme.colorScheme.secondary,fontSize: 18),))),
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,top: 20, ),
            child: Text("Service name",style: TextStyle(color: Get.theme.colorScheme.secondary,fontSize: 12),),
          ),
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,top: 15, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Color(0xff8ba3bd)                  ),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  padding: EdgeInsets.all(8),

                  child: TextFormField(
                    controller: service_name,
                    // onChanged: (val)
                    // {
                    //   setState(() {
                    //     service_name.text = val.toString();
                    //
                    //   });
                    //
                    // },
                    // onSaved: (val)
                    // {
                    //   setState(() {
                    //     serviceName = false;
                    //     service_name.text = val.toString();
                    //
                    //   });
                    //
                    // },

                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText:'Service name',
                        hintStyle: TextStyle(color: Color(0xff8ba3bd)),

                        // label: Text("Company Name"),
                        // labelText: 'Company Name',
                        // prefixIcon: Icon(Icons.person),
                        // prefixIcon: Image.asset('assets/img/Company.png'),


                        labelStyle: TextStyle(color: Colors.grey)

                    ),

                  ),
                ),
                SizedBox(height:8),
                serviceName == true && service_name.text.isEmpty?Text("Service name is required",style:TextStyle(color:Colors.red,fontSize: 12)):Container()

              ],
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,top: 5, ),
            child: Text("Service price",style: TextStyle(color: Get.theme.colorScheme.secondary,fontSize: 12),),
          ),
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,top: 15,
                bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Color(0xff8ba3bd)                  ),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  padding: EdgeInsets.all(8),

                  child: TextFormField(
                    controller: service_price,

                    // onChanged: (val)
                    // {
                    //   setState(() {
                    //     service_price.text = val.toString();
                    //
                    //   });
                    //
                    // },
                    // onSaved: (val)
                    // {
                    //   setState(() {
                    //     servicePrice = false;
                    //     service_price.text = val.toString();
                    //
                    //   });
                    //
                    // },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText:'Service price',
                        hintStyle: TextStyle(color: Color(0xff8ba3bd)),

                        // label: Text("Company Name"),
                        // labelText: 'Company Name',
                        // prefixIcon: Icon(Icons.person),
                        // prefixIcon: Image.asset('assets/img/Company.png'),


                        labelStyle: TextStyle(color: Colors.grey)

                    ),

                  ),
                ),
                SizedBox(height: 8,),
                servicePrice == true && service_price.text.isEmpty?Text("Service price is required",style:TextStyle(color:Colors.red,fontSize: 12)):Container()

              ],
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,top: 5, ),
            child: Text("Service discount price",style: TextStyle(color: Get.theme.colorScheme.secondary,fontSize: 12),),
          ),
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,top: 15,
                bottom: 10),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Color(0xff8ba3bd)                  ),
                  borderRadius: BorderRadius.circular(5)
              ),
              padding: EdgeInsets.all(8),

              child: TextFormField(
                controller: discount_service_price,

                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText:'Service discount price',
                    hintStyle: TextStyle(color: Color(0xff8ba3bd)),

                    // label: Text("Company Name"),
                    // labelText: 'Company Name',
                    // prefixIcon: Icon(Icons.person),
                    // prefixIcon: Image.asset('assets/img/Company.png'),


                    labelStyle: TextStyle(color: Colors.grey)

                ),

              ),
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,top: 5, ),
            child: Text("Unit Price",style: TextStyle(color: Get.theme.colorScheme.secondary,fontSize: 12),),
          ),
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,top: 15,bottom: 10),
            child: Container(
              padding: EdgeInsets.all(10),
              height: 50,
              width: 400,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Color(0xff8ba3bd)                  ),
                  borderRadius: BorderRadius.circular(5)
              ),

              child: DropdownButtonHideUnderline(
                child: DropdownButton2(
                  hint: Text(
                    'Unit Price',
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme
                          .of(context)
                          .hintColor,
                    ),
                  ),

                  onChanged: (String newValue) {
                    setState(() {
                      unit_price = newValue;
                      //    unit_price = dropdownValue;
                    });
                  },
                  // value: dropdownValue == null ?unit_price:dropdownValue,
                  value: unit_price,

                  items: <String>[unit_price == null || unit_price == "fixed" ?'hourly':unit_price,unit_price == null || unit_price =="hourly"?'fixed':unit_price]
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  buttonHeight: 30,
                  buttonWidth: double.infinity,
                  itemHeight: 40,
                  underline: SizedBox(),
                ),
              ),
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,top: 5, ),
            child: Text("Duration",style: TextStyle(color: Get.theme.colorScheme.secondary,fontSize: 12),),
          ),
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,top: 15, bottom: 10),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Color(0xff8ba3bd)                  ),
                  borderRadius: BorderRadius.circular(5)
              ),
              padding: EdgeInsets.all(8),

              child: TextFormField(
                controller: service_duration,

                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText:'Duration',
                    hintStyle: TextStyle(color: Color(0xff8ba3bd)),

                    // label: Text("Company Name"),
                    // labelText: 'Company Name',
                    // prefixIcon: Icon(Icons.person),
                    // prefixIcon: Image.asset('assets/img/Company.png'),


                    labelStyle: TextStyle(color: Colors.grey)

                ),

              ),
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,top: 5, ),
            child: Text("Description",style: TextStyle(color: Get.theme.colorScheme.secondary,fontSize: 12),),
          ),
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,top: 15,
                bottom: 10),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Color(0xff8ba3bd)                  ),
                  borderRadius: BorderRadius.circular(5)
              ),
              padding: EdgeInsets.all(8),

              child: TextFormField(
                controller: service_desc,

                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText:'Description',
                    hintStyle: TextStyle(color: Color(0xff8ba3bd)),

                    // label: Text("Company Name"),
                    // labelText: 'Company Name',
                    // prefixIcon: Icon(Icons.person),
                    // prefixIcon: Image.asset('assets/img/Company.png'),


                    labelStyle: TextStyle(color: Colors.grey)

                ),

              ),
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,top: 5, ),
            child: Text("Categories",style: TextStyle(color: Get.theme.colorScheme.secondary,fontSize: 12),),
          ),
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,top: 15,bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  height: 50,
                  width: 400,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Color(0xff8ba3bd)                  ),
                      borderRadius: BorderRadius.circular(5)
                  ),

                  child: DropdownButtonHideUnderline(
                    child: FutureBuilder(
                        future: callAPi,
                        builder: (context,snapshot) {
                          return DropdownButton2(
                            hint: snapshot.data == null ?Text("Categories",style: TextStyle(
                              fontSize: 14,
                              color: Theme
                                  .of(context)
                                  .hintColor,
                            ),):
                            Text("Categories",
                              //  select_id == null? 'Categories':select_id['name']['en'].toString(),
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme
                                    .of(context)
                                    .hintColor,
                              ),
                            ),

                            onChanged: onChangeDropdownTests,
                            // value: dropdownValue == null ?unit_price:dropdownValue,
                            value: _selectedTest,
                            items:_dropdownTestItems,

                            buttonHeight: 30,
                            buttonWidth: double.infinity,
                            itemHeight: 40,
                            underline: SizedBox(),
                          );
                        }
                    ),
                  ),
                ),
                SizedBox(height: 8,),
                selectCat == true && _selectedTest == null ? Text("Category field is required",style:TextStyle(color:Colors.red,fontSize: 12)):Container()

              ],
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,top: 5, ),
            child: Text("Service image upload",style: TextStyle(color: Get.theme.colorScheme.secondary,fontSize: 12),),
          ),
          Padding(
            padding:  EdgeInsets.only(left: 20.0,right: 20,top: 15, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: Service_image,

                  child: Container(
                    // height: 50,
                      width: 400,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Color(0xff8ba3bd)
                          ),
                          borderRadius: BorderRadius.circular(5)
                      ),
                      padding: EdgeInsets.all(10),

                      child:imageGile==null && imagess ==null ?
                      Row(
                        children: [
                          Icon(Icons.upload,
                              color: Color(0xff8ba3bd)
                          ),
                          SizedBox(width: 10,),
                          Text('Service image upload',style: TextStyle(color: Color(0xff8ba3bd)))

                        ],
                      ):
                      imageGile !=null ?Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: FileImage(imageGile)
                                )
                            ),
                          ),
                        ],
                      ):
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(imagess.toString())
                                )
                            ),
                          ),
                        ],
                      )

                  ),
                ),
                SizedBox(height:8),
                serviceImg == true && imageGile == null ?Text("Service image is required",style:TextStyle(color:Colors.red,fontSize: 12)):Container()

              ],
            ),
          ),

        ],
      ),
    );

  }

  _getFromCamera2() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageGile = File(pickedFile.path);
      });
      Navigator.pop(context);

    }
  }
  _getFromGallery2() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageGile = File(pickedFile.path);
      });
      Navigator.pop(context);

    }
  }
  /// Get Image For Cover Image
  _getFromGallery() async {

    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );

    //   final fileName = file(ProjectImage.path);
    if (pickedFile != null) {
      setState((){Imageupload = File(pickedFile.path);});
      file = File(Imageupload.path.toString());
      // fileName = Path.basename(file.path);
      decodedImage = await decodeImageFromList(Imageupload.readAsBytesSync());
      setState((){
        imageSize = decodedImage;
      });
      Navigator.pop(context);

      print(decodedImage.width);
      print(decodedImage.height);

      print(fileName);
    }
  }
  _getFromCamera() async {

    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );

    //   final fileName = file(ProjectImage.path);
    if (pickedFile != null) {
      setState((){Imageupload = File(pickedFile.path);});
      file = File(Imageupload.path.toString());
      // fileName = Path.basename(file.path);
      decodedImage = await decodeImageFromList(Imageupload.readAsBytesSync());
      setState((){
        imageSize = decodedImage;
      });
      Navigator.pop(context);
      print(decodedImage.width);
      print(decodedImage.height);

      print(fileName);
    }
  }
  _getFromGalleryForvideo() async {
    PickedFile pickedFile = await ImagePicker().getVideo(source: ImageSource.gallery);
    videoupload = File(pickedFile.path);
    _videoPlayerController = VideoPlayerController.file(videoupload)..initialize().then((_) {
      setState(() { });
      _videoPlayerController.pause();
      print("++++++++++++++++++++++++++++++Video upload++++++++++++++++++++++++++++++++++++++");
      print(videoupload);
      print("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
    });
    Navigator.pop(context);


    // PickedFile pickedFile = await ImagePicker().getImage(
    //   source: ImageSource.gallery,
    //   maxWidth: 1800,
    //   maxHeight: 1800,
    // );
    //
    // if (pickedFile != null) {
    //   setState((){videoupload = File(pickedFile.path);});
    //   file = File(videoupload.path.toString());
    //   // fileName = Path.basename(file.path);
    //   decodedImage = await decodeImageFromList(videoupload.readAsBytesSync());
    //   setState((){
    //     imageSize = decodedImage;
    //   });
    //   Navigator.pop(context);
    //
    //   print(decodedImage.width);
    //   print(decodedImage.height);
    //
    //   print(fileName);
    // }
  }
  _getFromCameraForvideo() async {

    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );

    //   final fileName = file(ProjectImage.path);
    if (pickedFile != null) {
      setState((){videoupload = File(pickedFile.path);});
      file = File(videoupload.path.toString());
      // fileName = Path.basename(file.path);
      decodedImage = await decodeImageFromList(videoupload.readAsBytesSync());
      setState((){
        imageSize = decodedImage;
      });
      Navigator.pop(context);
      print(decodedImage.width);
      print(decodedImage.height);

      print(fileName);
    }
  }
  //++++++++++++++++++++++++++++++PAN+++++++++++++++++++++++++++++++++++
  kycimagesFromGallery() async {

    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );

    //   final fileName = file(ProjectImage.path);
    if (pickedFile != null) {
      File general;
      if(pan_image == true)
      {

        setState((){Pan = File(pickedFile.path);});
        file = File(Pan.path.toString());
        // fileName = Path.basename(file.path);
        decodedImage = await decodeImageFromList(Pan.readAsBytesSync());
        setState((){
          imageSize = decodedImage;
        });
        Navigator.pop(context);

        print(decodedImage.width);
        print(decodedImage.height);

        print(fileName);
      }
      if(_passport == true)
      {
        setState((){passport_file = File(pickedFile.path);});
        file = File(passport_file.path.toString());
        // fileName = Path.basename(file.path);
        decodedImage = await decodeImageFromList(passport_file.readAsBytesSync());
        setState((){
          imageSize = decodedImage;
        });
        Navigator.pop(context);

        print(decodedImage.width);
        print(decodedImage.height);

        print(fileName);
      }
      if(driving_license == true)
      {
        setState((){driving = File(pickedFile.path);});
        file = File(driving.path.toString());
        // fileName = Path.basename(file.path);
        decodedImage = await decodeImageFromList(driving.readAsBytesSync());
        setState((){
          imageSize = decodedImage;
        });
        Navigator.pop(context);

        print(decodedImage.width);
        print(decodedImage.height);

        print(fileName);
      }
      if(llp_number == true)
      {
        setState((){llp = File(pickedFile.path);});
        file = File(llp.path.toString());
        // fileName = Path.basename(file.path);
        decodedImage = await decodeImageFromList(llp.readAsBytesSync());
        setState((){
          imageSize = decodedImage;
        });
        Navigator.pop(context);

        print(decodedImage.width);
        print(decodedImage.height);

        print(fileName);
      }
      if(company_licence == true)
      {
        setState((){company = File(pickedFile.path);});
        file = File(company.path.toString());
        // fileName = Path.basename(file.path);
        decodedImage = await decodeImageFromList(company.readAsBytesSync());
        setState((){
          imageSize = decodedImage;
        });
        Navigator.pop(context);

        print(decodedImage.width);
        print(decodedImage.height);

        print(fileName);
      }
      if(fssai == true)
      {
        setState((){ Fssai= File(pickedFile.path);});
        file = File(Fssai.path.toString());
        // fileName = Path.basename(file.path);
        decodedImage = await decodeImageFromList(Fssai.readAsBytesSync());
        setState((){
          imageSize = decodedImage;
        });
        Navigator.pop(context);

        print(decodedImage.width);
        print(decodedImage.height);

        print(fileName);
      }
      if(liquor_license == true)
      {
        setState((){ liquir= File(pickedFile.path);});
        file = File(liquir.path.toString());
        // fileName = Path.basename(file.path);
        decodedImage = await decodeImageFromList(liquir.readAsBytesSync());
        setState((){
          imageSize = decodedImage;
        });
        Navigator.pop(context);

        print(decodedImage.width);
        print(decodedImage.height);

        print(fileName);
      }
      if(trade_license == true)
      {
        setState((){ trade= File(pickedFile.path);});
        file = File(trade.path.toString());
        // fileName = Path.basename(file.path);
        decodedImage = await decodeImageFromList(trade.readAsBytesSync());
        setState((){
          imageSize = decodedImage;
        });
        Navigator.pop(context);

        print(decodedImage.width);
        print(decodedImage.height);

        print(fileName);
      }
      if(other_document == true)
      {
        setState((){ documnet= File(pickedFile.path);});
        file = File(documnet.path.toString());
        // fileName = Path.basename(file.path);
        decodedImage = await decodeImageFromList(documnet.readAsBytesSync());
        setState((){
          imageSize = decodedImage;
        });
        Navigator.pop(context);

        print(decodedImage.width);
        print(decodedImage.height);

        print(fileName);
      }


    }
  }
  kycimagesFromCamera() async {

    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      File general;
      if(pan_image == true)
      {

        setState((){Pan = File(pickedFile.path);});
        file = File(Pan.path.toString());
        // fileName = Path.basename(file.path);
        decodedImage = await decodeImageFromList(Pan.readAsBytesSync());
        setState((){
          imageSize = decodedImage;
        });
        Navigator.pop(context);

        print(decodedImage.width);
        print(decodedImage.height);

        print(fileName);
      }
      if(driving_license == true)
      {
        setState((){driving = File(pickedFile.path);});
        file = File(driving.path.toString());
        // fileName = Path.basename(file.path);
        decodedImage = await decodeImageFromList(driving.readAsBytesSync());
        setState((){
          imageSize = decodedImage;
        });
        Navigator.pop(context);

        print(decodedImage.width);
        print(decodedImage.height);

        print(fileName);
      }
      if(_passport == true)
      {
        setState((){passport_file = File(pickedFile.path);});
        file = File(passport_file.path.toString());
        // fileName = Path.basename(file.path);
        decodedImage = await decodeImageFromList(passport_file.readAsBytesSync());
        setState((){
          imageSize = decodedImage;
        });
        Navigator.pop(context);

        print(decodedImage.width);
        print(decodedImage.height);

        print(fileName);
      }
      if(llp_number == true)
      {
        setState((){llp = File(pickedFile.path);});
        file = File(llp.path.toString());
        // fileName = Path.basename(file.path);
        decodedImage = await decodeImageFromList(llp.readAsBytesSync());
        setState((){
          imageSize = decodedImage;
        });
        Navigator.pop(context);

        print(decodedImage.width);
        print(decodedImage.height);

        print(fileName);
      }
      if(company_licence == true)
      {
        setState((){company = File(pickedFile.path);});
        file = File(company.path.toString());
        // fileName = Path.basename(file.path);
        decodedImage = await decodeImageFromList(company.readAsBytesSync());
        setState((){
          imageSize = decodedImage;
        });
        Navigator.pop(context);

        print(decodedImage.width);
        print(decodedImage.height);

        print(fileName);
      }
      if(fssai == true)
      {
        setState((){ Fssai= File(pickedFile.path);});
        file = File(Fssai.path.toString());
        // fileName = Path.basename(file.path);
        decodedImage = await decodeImageFromList(Fssai.readAsBytesSync());
        setState((){
          imageSize = decodedImage;
        });
        Navigator.pop(context);

        print(decodedImage.width);
        print(decodedImage.height);

        print(fileName);
      }
      if(liquor_license == true)
      {
        setState((){ liquir= File(pickedFile.path);});
        file = File(liquir.path.toString());
        // fileName = Path.basename(file.path);
        decodedImage = await decodeImageFromList(liquir.readAsBytesSync());
        setState((){
          imageSize = decodedImage;
        });
        Navigator.pop(context);

        print(decodedImage.width);
        print(decodedImage.height);

        print(fileName);
      }
      if(trade_license == true)
      {
        setState((){ trade= File(pickedFile.path);});
        file = File(trade.path.toString());
        // fileName = Path.basename(file.path);
        decodedImage = await decodeImageFromList(trade.readAsBytesSync());
        setState((){
          imageSize = decodedImage;
        });
        Navigator.pop(context);

        print(decodedImage.width);
        print(decodedImage.height);

        print(fileName);
      }
      if(other_document == true)
      {
        setState((){ documnet= File(pickedFile.path);});
        file = File(documnet.path.toString());
        // fileName = Path.basename(file.path);
        decodedImage = await decodeImageFromList(documnet.readAsBytesSync());
        setState((){
          imageSize = decodedImage;
        });
        Navigator.pop(context);

        print(decodedImage.width);
        print(decodedImage.height);

        print(fileName);
      }


    }

    //   final fileName = file(ProjectImage.path);
    // if (pickedFile != null) {
    //   setState((){Imageupload = File(pickedFile.path);});
    //   file = File(Imageupload.path.toString());
    //   // fileName = Path.basename(file.path);
    //   decodedImage = await decodeImageFromList(Imageupload.readAsBytesSync());
    //   setState((){
    //     imageSize = decodedImage;
    //   });
    //   Navigator.pop(context);
    //   print(decodedImage.width);
    //   print(decodedImage.height);
    //
    //   print(fileName);
    // }
  }

}

