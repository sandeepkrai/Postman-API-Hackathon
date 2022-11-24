import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:postmanapihackathon/Weather/Services/searchButton.dart';
import '../Models/weather.dart';

class FetchScreen extends StatefulWidget {
  double? lat ;
  double? long ;
  AsyncSnapshot<WeatherData>? snapshot;
  FetchScreen({this.lat, this.long, this.snapshot});

  @override
  State<FetchScreen> createState() => _FetchScreenState();
}

class _FetchScreenState extends State<FetchScreen> {
  final day=["Today","Tuesday","Wednesday"];
  final temp= [14.5,28.0,16.0,15.2,35.1,18.4,19.0,42.3,21.3];

  @override
  Widget build(BuildContext context) {
    print(widget.snapshot);
    var height= MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    TextStyle titlefont= TextStyle(fontWeight: FontWeight.w600, fontSize: width*0.055, color: Colors.white);
    TextStyle infofont= TextStyle(fontWeight: FontWeight.w400, fontSize: width*0.043,color: Color.fromRGBO(255, 255, 255, 0.8));



    return Container(


      width: width*1,
      height: height*1,
       // color: concolor(widget.snapshot!.data!.main!.temp!-273),
      child: Center(

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Expanded(child: SearchButton()),

            SizedBox(
              height: height*0.03,
            ),
            Image.network('http://openweathermap.org/img/wn/${widget.snapshot!.data!.weather![0].icon}@2x.png'),
            SizedBox(
              height: height*0.01,
            ),
            Text((((widget.snapshot!.data!.main!.temp)!-273).round().toString())+" °C",style: TextStyle(fontWeight: FontWeight.w400,fontSize: width*0.16),),
            Text(widget.snapshot!.data!.name.toString(), style: TextStyle(fontSize: width*0.06,color:Colors.grey ),),


              SizedBox(
                height: height*0.03,
              ),
              Container(
                alignment: Alignment.center,

                height: height*0.2,
                margin: EdgeInsets.symmetric(horizontal: width*0.052),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  color: Color.fromRGBO(14, 20, 51, 1),
                ),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.water_drop,
                      color: Colors.blue,
                      size: height*0.12,
                    ),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Cloudy", style: TextStyle(fontWeight: FontWeight.w800, color: Colors.white, fontSize: width*0.08),),
                        SizedBox(height: height*0.01,),
                        Text("${DateFormat.MMMEd().format(DateTime.now())}",style: TextStyle(fontSize: width*0.04,color:Color.fromRGBO(255, 255, 255, 0.8) ), ),
                        SizedBox(height: height*0.001,),
                        Text(widget.snapshot!.data!.name.toString(),
                          style: TextStyle(fontSize: width*0.04,color:Color.fromRGBO(255, 255, 255, 0.8) ),),
                      ],
                    ),
                    SizedBox(
                      width: width*0.07,
                    ),
                    Text((((widget.snapshot!.data!.main!.temp)!-273).round().toString())+" °C",
                      style: TextStyle(fontWeight: FontWeight.w500,fontSize: width*0.11, color: Colors.white),),

                  ],
                ),
              ),
              SizedBox(height: height*0.03,),


                          child: Center(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: height*0.03,
                                  ),
                                  Text(day[(index/3).floor()],


                                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: width*0.053,color: Colors.white),

                                  ),
                                  SizedBox(
                                    height: height*0.01,
                                  ),
                                  Icon(
                                    Icons.water_drop,
                                    color: Colors.blue,
                                    size: height*0.05,
                                  ),
                                  SizedBox(
                                    height: height*0.01,
                                  ),
                                  Text(temp[index].round().toString(),
                                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: width*0.053,color: Colors.white),
                                  ),

                                ],
                              )
                          ),


              SizedBox(
                height: height*0.01,
              ),
              Column(

                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: height*0.1,
                        width: width*0.45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          color: Color.fromRGBO(14, 20, 51, 1),
                        ),

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("VISIBILITY",style: titlefont,),
                            Text(((widget.snapshot!.data!.visibility)!/1000).toString()+" KM", style: infofont,)
                          ],
                        ),
                      ),
                      Container(
                        height: height*0.1,
                        width: width*0.45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          color: Color.fromRGBO(14, 20, 51, 1),                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("HUMIDITY",style: titlefont,),
                            Text(widget.snapshot!.data!.main!.humidity.toString()+"%", style: infofont,),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: height*0.015,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: height*0.1,
                        width: width*0.45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          color: Color.fromRGBO(14, 20, 51, 1),                        ),

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("PRESSURE",style: titlefont,),
                            Text(widget.snapshot!.data!.main!.pressure.toString(), style: infofont,),
                          ],
                        ),
                      ),
                      Container(
                        height: height*0.1,
                        width: width*0.45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          color: Color.fromRGBO(14, 20, 51, 1),                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("FEELS LIKE",style: titlefont,),
                            Text(widget.snapshot!.data!.main!.feelsLike.toString(), style: infofont,),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: height*0.015,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: height*0.1,
                        width: width*0.45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          color: Color.fromRGBO(14, 20, 51, 1),                        ),

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("MIN TEMP",style: titlefont,),
                            Text(widget.snapshot!.data!.main!.tempMin.toString(), style: infofont,)
                          ],
                        ),
                      ),
                      Container(
                        height: height*0.1,
                        width: width*0.45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          color: Color.fromRGBO(14, 20, 51, 1),                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("MAX TEMP",style: titlefont,),
                            Text(widget.snapshot!.data!.main!.tempMax.toString(), style: infofont,)
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: height*0.015,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: height*0.1,
                        width: width*0.45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          color: Color.fromRGBO(14, 20, 51, 1),                        ),

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("SUNRISE",style: titlefont,),
                            Text(widget.snapshot!.data!.main!.tempMin.toString(), style: infofont,)
                          ],
                        ),
                      ),
                      Container(
                        height: height*0.1,
                        width: width*0.45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          color: Color.fromRGBO(14, 20, 51, 1),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("SUNSET",style: titlefont,),
                            Text(widget.snapshot!.data!.main!.tempMax.toString(), style: infofont,)
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
              ],          )
      ),
    );


  }
}
Color concolor(double a)
{
  final container_color=[Color.fromRGBO(0, 0, 139, 0.7),Colors.lightBlue,Colors.amber,Colors.orange,Colors.deepOrange,Colors.red];
  int i;
  if(a<15.0)
  {
    i=0;
  }
  else if(a>=15.0 && a<20.0)
  {
    i=1;
  }
  else if(a>=20.0 && a<25.0)
  {
    i=2;
  }
  else if(a>=25.0 && a<30.0)
  {
    i=3;
  }
  else if(a>=30.0 && a<35)
  {
    i=4;
  }
  else
  {
    i=5;
  }
  return container_color[i];
}
