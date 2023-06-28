import 'package:bizmart/app/models/busines_details_save_api/enquiryform_api.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
class EnquiryForm extends StatefulWidget {
  final String service_name;
  final String ser_id;
  const EnquiryForm({Key key, this.service_name, this.ser_id}) : super(key: key);

  @override
  State<EnquiryForm> createState() => _EnquiryFormState();
}

class _EnquiryFormState extends State<EnquiryForm> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController description = TextEditingController();
  @override
  bool isLoaders = false;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios,
              color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
            // Get.back()
          },
        ),
        title: Text(widget.service_name.toString()),
        centerTitle: true,
        elevation: 0,
    ),
      bottomNavigationBar: Padding(
        padding:  EdgeInsets.all(10.0),
        child: InkWell(
          onTap: ()
          {

            String _name = name.text.toString();
            String _email = email.text.toString();
            String _mobile = mobile.text.toString();
            String _description = description.text.toString();
            if(_name.isNotEmpty && _email.isNotEmpty && _mobile.isNotEmpty && _description.isNotEmpty )
              {
                final bool isValid = EmailValidator.validate(_email.trim());

                if(_mobile.length == 10)
                  {
                    if(isValid == true)
                      {
                        setState(() {
                          isLoaders = true;
                        });

                        EnquiryFormData().EnquiryFormSave(widget.ser_id,_name, _email, _mobile, _description).then((val)
                        {
                          var status_code= val['status'].toString();
                          var msg = val['message'].toString();
                          setState(() {
                            isLoaders = false;
                          });
                          if(status_code == "200" || status_code == "201")
                          {

                            Navigator.pop(context);
                            Fluttertoast.showToast(
                                msg:msg,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor:Get.theme.colorScheme.secondary,
                                textColor: Colors.white,
                                fontSize: 14.0
                            );
                          }
                          else
                          {
                            Fluttertoast.showToast(
                                msg:msg,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor:Get.theme.colorScheme.secondary,
                                textColor: Colors.white,
                                fontSize: 14.0
                            );

                          }

                        });
                      }
                    else
                      {
                        Fluttertoast.showToast(
                            msg:"Please enter valid email",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor:Get.theme.colorScheme.secondary,
                            textColor: Colors.white,
                            fontSize: 14.0
                        );
                      }


                  }
                else
                  {
                    Fluttertoast.showToast(
                        msg:"Phone number should be 10 digit",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor:Get.theme.colorScheme.secondary,
                        textColor: Colors.white,
                        fontSize: 14.0
                    );
                  }



              }
            else
              {
                Fluttertoast.showToast(
                    msg:"Please fill all the fields",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor:Get.theme.colorScheme.secondary,
                    textColor: Colors.white,
                    fontSize: 14.0
                );
              }

          },
          // child:isLoaders == true? Container(
          //     height: 45,
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(5),
          //       color: Get.theme.colorScheme.secondary,
          //     ),
          //     //alignment: Alignment.,
          //     width: 400,
          //
          //     child: Center(child: CircularProgressIndicator(color: Colors.white,strokeWidth: 2,))):
          child:Container(
            height: 60,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Get.theme.colorScheme.secondary,
              borderRadius: BorderRadius.circular(5)
            ),
            child: Center(child: Text("Enquiry Now",style: TextStyle(color: Colors.white,fontSize: 18),)),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 25,),
            Padding(
              padding:  EdgeInsets.only(left: 20.0,right: 20,top: 5, ),
              child: Text("Name",style: TextStyle(color: Get.theme.colorScheme.secondary,fontSize: 12),),
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
                 controller: name,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText:'Name',
                      hintStyle: TextStyle(color: Color(0xff8ba3bd)),

                      // label: Text("Company Name"),
                      // labelText: 'Company Name',
                      // prefixIcon: Icon(Icons.person),
                      prefixIcon: Icon(Icons.person,color: Color(0xff8ba3bd)),


                      labelStyle: TextStyle(color: Colors.grey)

                  ),

                ),
              ),
            ),
            //------------------------Address-----------------------------------------
            Padding(
              padding:  EdgeInsets.only(left: 20.0,right: 20,top: 5, ),
              child: Text("Email",style: TextStyle(color: Get.theme.colorScheme.secondary,fontSize: 12),),
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
                //padding: EdgeInsets.all(8),

                child: TextFormField(
                  controller: email,
                  maxLines: 1,
                  decoration: InputDecoration(
                   // contentPadding: EdgeInsets.only(top: 8.0),
                      border: InputBorder.none,
                      hintText: 'Email',
                      hintStyle: TextStyle(color: Color(0xff8ba3bd)),
                      //prefixIcon: Icon(Icons.location_on_sharp),
                      prefixIcon: Icon(Icons.mail,color: Color(0xff8ba3bd),

                  ),
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
            //------------------------District----------------------------------------
            Padding(
              padding:  EdgeInsets.only(left: 20.0,right: 20,top: 5, ),
              child: Text("Mobile",style: TextStyle(color: Get.theme.colorScheme.secondary,fontSize: 12),),
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
                controller: mobile,
                  keyboardType: TextInputType.phone,
                  maxLength: 10,

                  decoration: InputDecoration(
                      border: InputBorder.none,
                      counter: Offstage(),
                      //  prefixIcon: Icon(Icons.location_on_sharp),
                      prefixIcon: Icon(Icons.phone,color: Color(0xff8ba3bd)),
                      contentPadding: EdgeInsets.all(5),
                      hintStyle: TextStyle(color: Color(0xff8ba3bd)),
                      hintText: 'Mobile',
                      labelStyle: TextStyle(color: Colors.grey)

                  ),

                ),
              ),
            ),
            //------------------------City---------------------------------------------
            Padding(
              padding:  EdgeInsets.only(left: 20.0,right: 20,top: 5, ),
              child: Text("Description",style: TextStyle(color: Get.theme.colorScheme.secondary,fontSize: 12),),
            ),
            Padding(
              padding:  EdgeInsets.only(left: 20.0,right: 20,top: 15,bottom: 10),
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Color(0xff8ba3bd)
                    ),
                    borderRadius: BorderRadius.circular(5)
                ),
                padding: EdgeInsets.all(8),

                child: TextFormField(
                  maxLines: 3,
                  controller: description,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 25),
                      border: InputBorder.none,
                      //  prefixIcon: Icon(Icons.Location),
                      // prefixIcon: Icon(Icons.location_on_sharp),
                      prefixIcon:Icon(Icons.list_alt,color: Color(0xff8ba3bd)),
                      hintStyle: TextStyle(color: Color(0xff8ba3bd)),


                      hintText: 'Description',
                      labelStyle: TextStyle(color: Colors.grey)

                  ),

                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
