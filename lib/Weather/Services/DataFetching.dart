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
  String getClockInUtcPlus3Hours(int timeSinceEpochInSec) {
    final time = DateTime.fromMillisecondsSinceEpoch(timeSinceEpochInSec * 1000,
        isUtc: true)
        .add(const Duration(hours: 3));
    return '${time.hour}:${time.second}';
  }

  @override
  Widget build(BuildContext context) {
    var time = getClockInUtcPlus3Hours(1669291435);
    // var hh = time!/(60);
    print(DateTime.now());
    // var mm = (time!%(60))/60;
    print(time);
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

              SizedBox(
                height: height*0.06,
              ),
              Container(
                alignment: Alignment.center,

                height: height*0.2,
                margin: EdgeInsets.symmetric(horizontal: width*0.035),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  color: Color.fromRGBO(14, 20, 51, 1),
                  image: DecorationImage(
                      image: AssetImage("assets/images/25503.jpg", ),
                      opacity: 0.5,
                      fit: BoxFit.cover),
                ),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.network('http://openweathermap.org/img/wn/${widget.snapshot!.data!.weather![0].icon}@2x.png'),


                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.snapshot!.data!.weather![0].main.toString(), style: TextStyle(fontWeight: FontWeight.w800, color: Colors.white, fontSize: width*0.08),),
                            SizedBox(height: height*0.01,),
                            Text(widget.snapshot!.data!.name.toString(),
                              style: TextStyle(fontSize: width*0.054,color:Color.fromRGBO(255, 255, 255, 0.8),fontWeight: FontWeight.w700 ),),
                            SizedBox(height: height*0.005,),
                            Row(
                              children: [
                                Text("${DateFormat.Hm().format(DateTime.now())}", style: TextStyle(fontSize: width*0.043,color:Color.fromRGBO(255, 255, 255, 0.8) ),),
                                SizedBox(width: width*0.015,),

                                Text("${DateFormat.MMMEd().format(DateTime.now())}",style: TextStyle(fontSize: width*0.043,color:Color.fromRGBO(255, 255, 255, 0.8) ), ),
                              ],
                            ),

                          ],
                        ),
                        SizedBox(
                          width: width*0.02,
                        ),
                        Text((((widget.snapshot!.data!.main!.temp)!-273).round().toString())+" °C",
                          style: TextStyle(fontWeight: FontWeight.w500,fontSize: width*0.11, color: Colors.white),),
                        SizedBox(
                          width: width*0.02,
                        )

                      ],
                    ),

                  ],
                )
              ),
              SizedBox(height: height*0.03,),
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
                            Text(widget.snapshot!.data!.main!.pressure.toString()+" hPa", style: infofont,),
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
                            Text((widget.snapshot!.data!.main!.feelsLike!-273).round().toString()+ " °C", style: infofont,),
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
                            Text((widget.snapshot!.data!.main!.tempMin!-273).round().toString()+" °C", style: infofont,)
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
                            Text((widget.snapshot!.data!.main!.tempMax!-273).round().toString()+" °C", style: infofont,)
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

                            Text(getClockInUtcPlus3Hours(widget.snapshot!.data!.sys!.sunrise!.round()).toString(), style: infofont,)
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
                            Text(getClockInUtcPlus3Hours(widget.snapshot!.data!.sys!.sunset!.round()).toString(), style: infofont,)
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
  final container_color=[const Color.fromRGBO(0, 0, 139, 0.7),Colors.lightBlue,Colors.amber,Colors.orange,Colors.deepOrange,Colors.red];
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
