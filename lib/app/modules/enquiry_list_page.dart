import 'package:bizmart/app/models/business_details_get_api/all_categories_api.dart';
import 'package:bizmart/app/models/business_details_get_api/enquiry_form_get_api.dart';
import 'package:bizmart/app/models/business_details_get_api/myservice_list.dart';
import 'package:bizmart/app/modules/business_details_form.dart';
import 'package:bizmart/app/modules/enquiry_list_detailspage.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
class MyEnquirylist extends StatefulWidget {
  const MyEnquirylist({Key key}) : super(key: key);

  @override
  State<MyEnquirylist> createState() => _MyEnquirylistState();
}

class _MyEnquirylistState extends State<MyEnquirylist> {
  @override
  List cat_list = [];
  String cat_id;
  var apiCall;
  bool catStatus = false;
  bool isFIrst = false;
  var catapi ;
  var list_length;
  var myservice;
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      myservice = Mysevice().Mysevicelist();
      // apiCall = AllCategories().AllCategoriesData();
      // AllCategories().AllCategoriesData().then((val)
      // {
      //   cat_list = val['data'];
      //   int i =0;
      //   for(i=0; i<10;i++)
      //   {
      //     cat_list.add(catapi[i]);
      //   }
      //   print("CAT LIST FROM FOR LOOP");
      //   print(catapi);
      //   print(cat_list);
      //   print(catapi.length);
      //
      // });



    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Enquiry list",style: TextStyle(fontSize: 18,color: Colors.white),),
        centerTitle: true,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios,
              color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
            // Get.back()
          },
        ),

      ),
      body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 25,),
              // Text("Service list"),
              FutureBuilder(
                  future: myservice,
                  builder: (ctx,snapshot)
                  {
                    if(snapshot.hasData)
                    {
                      if(snapshot.data['data'].length == 0 )
                      {
                        return Container(
                            height: 500,
                            child: Center(child: Text("Enquiry list empty")));
                      }
                      else
                      {

                        return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data['data'].length,
                            itemBuilder: (ctx,index)
                            {
                              String sid = snapshot.data['data'][index]['id'].toString();
                              // EnquiryFormGet().EnquiryFormGetData(sid).then((val)
                              // {
                              //   setState(() {
                              //     list_length =  val['data'].length;
                              //     print("DATA LENGTH");
                              //     print(list_length);
                              //
                              //
                              //   });
                              //
                              // });
                              if(snapshot.data['data'].length >0  )
                              {
                                return   Padding(
                                  padding:  EdgeInsets.only(left: 0.0,),
                                  child:    InkWell(
                                    onTap: () {
                                      String s_name =snapshot.data['data'][index]['name']['en'].toString();


                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (Context) =>
                                                  EnquiryListDetailsPage(s_name:s_name,sid:sid)));
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 15,right: 15,bottom: 10),
                                      child: Container(
                                        width: double.infinity,
                                        padding: EdgeInsets.all(18),
                                        decoration: BoxDecoration(
                                            color: Colors.white,

                                            borderRadius: BorderRadius.circular(5),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.shade400,
                                                spreadRadius: 1,
                                                blurRadius: 3,
                                                offset: const Offset(0, 3),
                                              ),
                                              BoxShadow(
                                                color: Colors.grey.shade300,
                                                // offset: const Offset(-1,0),
                                              )
                                            ]

                                        ),
                                        child:
                                        Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [

                                                Flexible(
                                                  child: Text(snapshot.data['data'][index]['name']['en'].toString(),
                                                    softWrap: true,
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 1,),
                                                ),

                                                SizedBox(width: 20,),
                                                Icon(
                                                  Icons.arrow_right,
                                                  color: Colors.black,
                                                ),

                                              ],
                                            ),


                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }
                              else
                                {
                                  return Container(height: 500, child: Center(child: Text("Enquiry list empty")));

                                }

                            }
                        );
                      }



                    }
                    else
                    {
                      return Container(
                        height: 500,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Get.theme.colorScheme.secondary,
                          ),
                        ),

                      );
                    }


                  }
              )
            ],
          )
      ),
    );
  }
}
