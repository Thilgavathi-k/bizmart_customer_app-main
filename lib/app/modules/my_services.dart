import 'package:bizmart/app/models/business_details_get_api/all_categories_api.dart';
import 'package:bizmart/app/models/business_details_get_api/myservice_list.dart';
import 'package:bizmart/app/modules/business_details_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
class Nyservices extends StatefulWidget {
  const Nyservices({Key key}) : super(key: key);

  @override
  State<Nyservices> createState() => _NyservicesState();
}

class _NyservicesState extends State<Nyservices> {
  @override
  List cat_list = [];
  String cat_id;
  var apiCall;
  bool catStatus = false;
  bool isFIrst = false;
  var catapi ;
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
     // apiCall = AllCategories().AllCategoriesData();
      AllCategories().AllCategoriesData().then((val)
      {
        cat_list = val['data'];
        int i =0;
        for(i=0; i<10;i++)
        {
          cat_list.add(catapi[i]);



        }
        print("CAT LIST FROM FOR LOOP");
        print(catapi);
        print(cat_list);
        print(catapi.length);

      });



    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My services",style: TextStyle(fontSize: 18,color: Colors.white),),
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
                future: Mysevice().Mysevicelist(),
                builder: (ctx,snapshot)
                {
                  if(snapshot.hasData)
                  {
                    if(snapshot.data['data']==null ||snapshot.data['data'].length == 0 )
                      {
                        return Container(
                          height: 500,
                            child: Center(child: Text("service list empty")));
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

                              return   Padding(
                                padding:  EdgeInsets.only(left: 0.0,),
                                child:    InkWell(
                                  onTap: () {
                                    print("SELECTSERVICESS");
                                    print(sid);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (Context) =>
                                                BusinessDetails(cat_list: cat_list,sid:sid)));
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
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            height:30,
                                            width: 30,
                                            // padding: EdgeInsets.all(8),

                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(100),
                                                border: Border.all(
                                                    color: Colors.grey
                                                )
                                            ),
                                            child: Center(
                                              child: Icon(
                                                Icons.work,
                                                color: Colors.grey,
                                                size: 15,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 8,),
                                          Flexible(
                                            // child: Text(snapshot.data['data'][index]['id'].toString(),
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
                                    ),
                                  ),
                                ),
                              );
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
