import 'package:bizmart/app/models/business_details_get_api/enquiry_form_get_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
class EnquiryListDetailsPage extends StatefulWidget {
  final String s_name;
  final String sid;
  const EnquiryListDetailsPage({Key key, this.s_name, this.sid}) : super(key: key);

  @override
  State<EnquiryListDetailsPage> createState() => _EnquiryListDetailsPageState();
}

class _EnquiryListDetailsPageState extends State<EnquiryListDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text(widget.s_name.toString(),style: TextStyle(color: Colors.white,fontSize: 18),),
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
        child: Container(
          child: FutureBuilder(
            future: EnquiryFormGet().EnquiryFormGetData(widget.sid),
            builder: (context,snapshot)
            {
              if(snapshot.hasData)
                {
                  if(snapshot.data['data'].length == 0)
                    {
                      return Container(
                        height: 500,
                        child: Center(
                          child: Text("No enquiry")
                        ),
                      );
                    }
                  else
                    {
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount:snapshot.data['data'].length ,
                          itemBuilder: (context,index)
                          {
                            return Padding(
                              padding:  EdgeInsets.all(10.0),
                              child: Container(
                                padding:  EdgeInsets.all(12.0),

                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(14),
                                    border: Border.all(
                                        color: Colors.grey.shade300
                                    )
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.person,color: Get.theme.colorScheme.secondary, size: 20,),
                                        SizedBox(width: 5,),
                                        Text(snapshot.data['data'][index]['name'].toString(),style: TextStyle(fontSize:14,color: Colors.grey.shade700),)
                                      ],
                                    ),
                                    SizedBox(height: 10,),

                                    Row(
                                      children: [
                                        Icon(Icons.phone,color: Colors.green, size: 20,),
                                        SizedBox(width: 5,),
                                        Text(snapshot.data['data'][index]['phone'].toString(),style: TextStyle(fontSize:14,color: Colors.grey.shade700),)
                                      ],
                                    ),
                                    SizedBox(height: 10,),

                                    Row(
                                      children: [
                                        Icon(Icons.mail,color: Colors.red, size: 20,),
                                        SizedBox(width: 5,),
                                        Text(snapshot.data['data'][index]['email'].toString(),style: TextStyle(fontSize:14,color: Colors.grey.shade700),)
                                      ],
                                    ),
                                    SizedBox(height: 10,),


                                    Padding(
                                      padding:  EdgeInsets.all(5.0),
                                      child: Container(
                                          width: double.infinity,
                                          padding:  EdgeInsets.all(5.0),

                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: Colors.grey.shade200
                                              )
                                          ),
                                          child:
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [

                                                  Icon(Icons.description,color: Colors.blue, size: 20,),
                                                  SizedBox(width: 5,),
                                                  Text("Describtion",style: TextStyle(fontSize:16,color: Colors.black),),
                                                ],
                                              ),

                                              Padding(
                                                padding:  EdgeInsets.all(8.0),
                                                child: Text(snapshot.data['data'][index]['description'].toString(),
                                                  style: TextStyle(fontSize:14,color: Colors.grey.shade700,
                                                    overflow: TextOverflow.ellipsis,

                                                  ),
                                                  maxLines: 4,),
                                              ),
                                            ],
                                          )),
                                    )

                                  ],
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
                      child: SizedBox(
                        height: 40,
                        width: 40,
                        child: CircularProgressIndicator(
                          color: Get.theme.colorScheme.secondary,
                          strokeWidth: 3,
                        ),
                      ),
                    ),
                  );                }
            },

          ),
        ),
      ),


    );
  }
}
