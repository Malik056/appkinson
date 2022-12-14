import 'dart:convert';
import 'package:appkinson/constants/globals.dart';
import 'package:appkinson/routes/routes_doctor.dart';
import 'package:appkinson/services/end_points.dart';
import 'package:appkinson/views/report/Widget_Chart_Line.dart';
import 'package:appkinson/views/report/Widget_Chart_Pie.dart';
import 'package:flutter/material.dart';
import 'widget_chart_serie.dart';

String? averageSymtomsResponse;
String? averageSymptomsByMonth;
String? averageGameScore;
String? averageDyskineciasWithoutMonth;
String? averageEmotionalSymptoms;
String? dataDisrepancy;
String? dataNoMotors;
String? dataSymptomsByDay;

var piedata; //Gráfica promedio de sintomas
var seriedata; //Gráfica promedio de sintomas por mes
var seriedataGameAverage; //Gráfica promedio de veces y puntaje jugado por mes
var serieDataDiskineias; //Gráfica de porcentaje de diskinecias entre meses
var seriesDataEmotional; //Gráfica de promedio de puntaje del formulario emocional por meses
var lineDataMedicinesDiscrepacy; //Gráfica de discrepancia del tiempo de toma de médicamento
var lineDataNoMotors; //Gráfica de sintomas no motores
var lineDataSymptomsDay; //Gráfica de síntomas por día

//COLORES
var colorsSintomasPorMeses = _generateColorsSyntomsChart();

//IDS
var idsSymptomsAverage = ['ON MUY BUENO', 'ON', 'OFF', 'OFF MUY MALO'];
var idsAverageGame = ['PUNTAJE', 'CANTIDAD JUGADA'];
var idsDyskineciasAverage = ['DISQUINECIAS'];
var idsEmotionalAverage = ['ÁNIMO'];
var idsMedicinesAverage = ['LEVODOPA'];
var idsNoMotorsAverage = ['SÍNTOMAS NO MOTORES'];
var idsSymptomsDaily = ['COMPORTAMIENTO DIARIO'];
//DESCRIPCIONES
String descripcionSymptoms = "Esta gráfica fue construida sumando la cantidad de registros existentes en el intervalo de tiempo escogido y sacando el porcentaje de cada uno de los síntomas sobre dicho total";
String descriptionSymptomsByMonth = "Esta gráfica fue construida dividiendo el intervalo de tiempo escogido por meses, posteriormente se saca el promedio de cada uno de los síntomas en dichos meses";
String descriptionAverageGame = "Esta gráfica fue construida dividiendo el intervalo de tiempo escogido por meses, posteriormente se calcula el promedio de los puntajes obtenidos en cada mes, además de gráficar la cantidad de veces que jugó en el mes";
String descriptionDysquinecias = "Esta gráfica fue construida dividiendo el intervalo de tiempo escogido por meses, posteriormente se calcula cuántos de los registros existentes tuvieron disquinecias en cada mes";
String descriptionEmotional = "Esta gráfica fue construida dividiendo el intervalo de tiempo escogido por meses, posteriormente se calcula el puntaje promedio obtenido en cada mes";
String descriptionMedicines = "Esta gráfica  construida dividiendo el intervalo de tiempo escogido por meses, posteriormente se calcula el promedio de tiempo en minutos que tuvo de desfase en la toma del médicamento";
String descriptionNoMotors = "Esta gráfica  construida dividiendo el intervalo de tiempo escogido por semanas, posteriormente se calcula el promedio del puntaje obtenido el el fomulario de síntomas no motores de dichas semanas. Las semanas se cuentan desde el inicio del intervalo escogido";
String descriptionSymptomsByDay = "En esta gráfica se muestran cada una de las horas del día y el estado registrado en dicha hora. Cada estado es gráficado bajo los siguientes números: [0,1,2,3] representando 0 = OFF MUY MALO , 1 = OFF, 2 = ON , 3 = ON MUY BUENO";

//CONSTRUCCIÓN DE DESCRIPCIÓN DE DATOS DE GRÁFICAS DE SERIE
String dataDescriptionSymptomsByMonth = "";
String dataDescriptionAverageGame = "";
String dataDescriptionAverageDyskinecias = "";
String dataDescriptionAverageEmotional = "";
String dataDescriptionSymptomsDay = "";
String dataDescriptionNoMotores = "";

class ListReportPage extends StatefulWidget {
  final int? idPatient;
  final List<DateTime> picked;

  ListReportPage({Key? key, required this.idPatient, required this.picked}) : super(key: key);
  _ListReportPage createState() => _ListReportPage(idPatient, picked);
}

class _ListReportPage extends State<ListReportPage> {
  final int? idPatient;
  List<DateTime> picked;

  _ListReportPage(this.idPatient, this.picked);

  @override
  void initState() {
    var now = picked[1];
    var lastDate = picked[0];
    _getAllDataCharts(lastDate, now).then((value) {
      if (averageSymtomsResponse != null) {
        //TODO: Handle Null (TAHA)

        var averageSymtomsResponseDecode = json.decode(averageSymtomsResponse!);
        List<double> averageSymptoms = [];
        //Construyendo los datos de la gráfica de promedio de los síntomas del paciente - Gráfica de tortas
        averageSymptoms.add(averageSymtomsResponseDecode["on"].toDouble());
        averageSymptoms.add(averageSymtomsResponseDecode["onG"].toDouble());
        averageSymptoms.add(averageSymtomsResponseDecode["off"].toDouble());
        averageSymptoms.add(averageSymtomsResponseDecode["offB"].toDouble());

        piedata = returnDataPie(averageSymptoms);
      }

      //---------------------------------------------------------------------------
      //Construyendo la gráfica del promedio de síntomas por cada mes - Gráfica de barras
      if (averageSymptomsByMonth != null) {
        //TODO: Handle Null (TAHA)
        var averageSymtomsByMonthResponseDecode = json.decode(averageSymptomsByMonth!);
        if (dataDescriptionSymptomsByMonth != "") {
          dataDescriptionSymptomsByMonth = "";
        }
        for (int i = 0; i < averageSymtomsByMonthResponseDecode.length; i++) {
          dataDescriptionSymptomsByMonth = dataDescriptionSymptomsByMonth + toMonthString(averageSymtomsByMonthResponseDecode[i]['mes']) + " : " + averageSymtomsByMonthResponseDecode[i]['onG'].toString() + " en ON MUY BUENO " + averageSymtomsByMonthResponseDecode[i]['on'].toString() + " en ON " + averageSymtomsByMonthResponseDecode[i]['off'].toString() + " en OFF " + averageSymtomsByMonthResponseDecode[i]['offG'].toString() + "en OFF MUY MALO \n";
        }
        seriedata = returnDataSeries(averageSymtomsByMonthResponseDecode.length, averageSymtomsByMonthResponseDecode);
      }
      //Construyendo la gráfica de promedio de puntaje obtenido en el juego por mes - Gráfica de barras

      if (averageGameScore != null) {
        //TODO: Manage null (TAHA)
        var averageGameResponseDecode = json.decode(averageGameScore!);
        if (dataDescriptionAverageGame != "") {
          dataDescriptionAverageGame = "";
        }
        for (int i = 0; i < averageGameResponseDecode.length; i++) {
          dataDescriptionAverageGame = dataDescriptionAverageGame + toMonthString(averageGameResponseDecode[i]['mes']) + " : " + averageGameResponseDecode[i]['Promedio'].toString() + " en promedio de puntaje jugado y " + averageGameResponseDecode[i]['Cantidad'].toString() + " de veces jugadas. \n Puntaje máximo:" + averageGameResponseDecode[i]['Max'].toString() + ". Puntaje mínimo: " + averageGameResponseDecode[i]['Min'].toString() + " \n";
        }
        seriedataGameAverage = returnDataSeriesGameAverage(averageGameResponseDecode.length, averageGameResponseDecode);
      }
      //
      //Construyeno la gráfica de porcentaje de disquinecias por meses - Gráfica de pie
      if (averageDyskineciasWithoutMonth != null) {
        //TODO: Manage null (TAHA)
        var averageDyskineciasDecode = json.decode(averageDyskineciasWithoutMonth!);
        if (dataDescriptionAverageDyskinecias != "") {
          dataDescriptionAverageDyskinecias = "";
        }
        for (int i = 0; i < averageDyskineciasDecode.length; i++) {
          dataDescriptionAverageDyskinecias = dataDescriptionAverageDyskinecias + toMonthString(averageDyskineciasDecode[i]['mes']) + " : " + averageDyskineciasDecode[i]['Promedio'].toString() + " en porcentaje de disquinesias presentadas en el mes \n ";
        }
        serieDataDiskineias = returnDataPieAverageDiskinecias(averageDyskineciasDecode.length, averageDyskineciasDecode);
      }
      //Construyendo la gráfica de promedio de puntaje del formulario emocional por meses
      if (averageEmotionalSymptoms != null) {
        //TODO: manage null (TAHA)
        var averageEmotionalSymptomsDecode = json.decode(averageEmotionalSymptoms!);
        if (dataDescriptionAverageEmotional != "") {
          dataDescriptionAverageEmotional = "";
        }
        for (int i = 0; i < averageEmotionalSymptomsDecode.length; i++) {
          dataDescriptionAverageEmotional = dataDescriptionAverageEmotional + toMonthString(averageEmotionalSymptomsDecode[i]['mes']) + " : " + averageEmotionalSymptomsDecode[i]['Promedio'].toString() + " en promedio de puntaje de ánimo \n ";
        }
        seriesDataEmotional = returnDataSeriesEmotionalAverage(averageEmotionalSymptomsDecode.length, averageEmotionalSymptomsDecode);
      }
      //Construyendo la gráfica de disrepania en los tiempos de toma de médicamentos
      if (dataDisrepancy != null) {
        var discrepandyDataDecode = json.decode(dataDisrepancy!);
        lineDataMedicinesDiscrepacy = returnDataLine(discrepandyDataDecode.length, discrepandyDataDecode);
      }
      //Construyendo la gráfica del puntaje promedio de los sintomas no motores
      if (dataNoMotors != null) {
        //TODO: Manage null (TAHA)
        var noMotorsDataDecode = json.decode(dataNoMotors!);
        if (dataDescriptionNoMotores != "") {
          dataDescriptionNoMotores = "";
        }
        for (int i = 1; i < noMotorsDataDecode.length; i++) {
          dataDescriptionNoMotores = dataDescriptionNoMotores + "Semana " + noMotorsDataDecode[i]['Week'].toString() + " : " + noMotorsDataDecode[i]['Promedio'].toString() + " en promedio. Fecha: " + noMotorsDataDecode[i]['Fecha'] + "\n Preguntas en las que respondió 'Sí': \n" + _dataNoMotorsSymptoms(noMotorsDataDecode[i]['Preguntas']) + "\n";
        }
        lineDataNoMotors = returnDataLineMotors(noMotorsDataDecode.length, noMotorsDataDecode);
      }
      //Construyendo la gráfica de los sintomas por día
      if (dataSymptomsByDay == null) {
        var symptomsByDayDataDecode = json.decode(dataSymptomsByDay!);

        if (dataDescriptionSymptomsDay != "") {
          dataDescriptionSymptomsDay = "";
        }
        for (int i = 0; i < symptomsByDayDataDecode.length; i++) {
          dataDescriptionSymptomsDay = dataDescriptionSymptomsDay + "Hora " + symptomsByDayDataDecode[i]['Hora'].toString() + '. Estado : ' + symptomsByDayDataDecode[i]['Estado'].toString() + "\n";
        }

        lineDataSymptomsDay = returnDataLineSymptomsByDay(symptomsByDayDataDecode.length, symptomsByDayDataDecode);
        print(lineDataSymptomsDay);
      }
    });
    print(lastDate);
    print(now);

    super.initState();
  }

  Future _getAllDataCharts(DateTime lastDate, DateTime now) async {
    averageSymtomsResponse = await EndPoints().getAverageSymptoms(idPatient, lastDate, now);
    averageSymptomsByMonth = await EndPoints().getAverageSymptomsAndCheerUp(idPatient, lastDate, now); //corregir el  nombre del endpoint
    averageGameScore = await EndPoints().getAverageGame(idPatient, lastDate, now);
    averageDyskineciasWithoutMonth = await EndPoints().getAverageDyskineciasWithoutMonths(idPatient, lastDate, now);
    averageEmotionalSymptoms = await EndPoints().getAverageEmotionalSymptoms(idPatient, lastDate, now);
    dataDisrepancy = await EndPoints().getDiscrepancyData(idPatient, lastDate, now);
    dataNoMotors = await EndPoints().getAverageMotorsSymptoms(idPatient, lastDate, now);
    dataSymptomsByDay = await EndPoints().getAverageSymptomsByDay(idPatient, lastDate, now);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: Text('Gráficas de Reportes')),
      body: new ListView(
        children: [
          new Container(
            width: 80,
            height: 1200,
            // child: Expanded(
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(children: [
                      ElevatedButton(
                        style: buildButtonStyle(border: roundedRadius18, background: Colors.grey[50], forground: Colors.white),
                        onPressed: () {
                          RoutesDoctor().toReportChartPie(context, "idquemado", piedata, "Porcentaje de los Síntomas del Paciente \n", descripcionSymptoms);
                        },
                        child: Image.asset(
                          "assets/images/representation.png",
                          height: size.height * 0.08,
                        ),
                      ),
                      Text(
                        "Porcentaje\n de los\n Síntomas del\n Paciente \n",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.blue[900], fontSize: 17, fontFamily: "Raleway2"),
                      )
                    ]),
                    Column(children: [
                      ElevatedButton(
                        style: buildButtonStyle(
                          border: roundedRadius18,
                          background: Colors.grey[50],
                          forground: Colors.white,
                        ),
                        onPressed: () {
                          RoutesDoctor().toReportChartSerie(context, idsSymptomsAverage, seriedata, "Promedio de los Síntomas del Paciente por Meses \n \n", colorsSintomasPorMeses, "Mes", "Promedio de Síntomas", descriptionSymptomsByMonth, dataDescriptionSymptomsByMonth);
                        },
                        child: Image.asset(
                          "assets/images/output-onlinepngtools (1).png",
                          height: size.height * 0.08,
                        ),
                      ),
                      Text(
                        "Promedio\n de los\n Síntomas del\n Paciente \npor Meses",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.blue[900], fontSize: 17, fontFamily: "Raleway2"),
                      )
                    ]),
                  ],
                ),
                SizedBox(
                  height: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(children: [
                      ElevatedButton(
                        style: buildButtonStyle(
                          border: roundedRadius18,
                          background: Colors.grey[50],
                          forground: Colors.white,
                        ),
                        onPressed: () {
                          RoutesDoctor().toReportChartSerie(context, idsAverageGame, seriedataGameAverage, "Promedio de Destreza en el Juego \n \n", colorsSintomasPorMeses, "Mes", "Promedio del puntaje", descriptionAverageGame, dataDescriptionAverageGame);
                        },
                        child: Image.asset(
                          "assets/images/output-onlinepngtools (2).png",
                          height: size.height * 0.08,
                        ),
                      ),
                      Text(
                        "Promedio de \nDestreza \n en el\n Juego \n",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.blue[900], fontSize: 17, fontFamily: "Raleway2"),
                      )
                    ]),
                    Column(children: [
                      ElevatedButton(
                        style: buildButtonStyle(
                          border: roundedRadius18,
                          background: Colors.grey[50],
                          forground: Colors.white,
                        ),
                        onPressed: () {
                          RoutesDoctor().toReportChartSerie(context, idsDyskineciasAverage, serieDataDiskineias, "Porcentaje de disquinesias en meses  \n \n", colorsSintomasPorMeses, "Mes", "Porcentaje de disquinesias (%)", descriptionDysquinecias, dataDescriptionAverageDyskinecias);
                        },
                        child: Image.asset(
                          "assets/images/bar-graph.png",
                          height: size.height * 0.08,
                        ),
                      ),
                      Text(
                        "Porcentaje de \nDisquinesias \n en\nMeses \n",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.blue[900], fontSize: 17, fontFamily: "Raleway2"),
                      )
                    ]),
                  ],
                ),
                SizedBox(
                  height: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        ElevatedButton(
                          style: buildButtonStyle(
                            border: roundedRadius18,
                            background: Colors.grey[50],
                            forground: Colors.white,
                          ),
                          onPressed: () {
                            RoutesDoctor().toReportChartSerie(context, idsEmotionalAverage, seriesDataEmotional, "Promedio del puntaje del estado de ánimo del paciente \n \n", colorsSintomasPorMeses, "Meses", "Promedio del puntaje del estado de ánimo", descriptionEmotional, dataDescriptionAverageEmotional);
                          },
                          child: Image.asset(
                            "assets/images/bar-graph.png",
                            height: size.height * 0.08,
                          ),
                        ),
                        Text(
                          "Promedio del \nPuntaje del \n Estado de\n Ánimo del\n Paciente ",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.blue[900], fontSize: 17, fontFamily: "Raleway2"),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        /* RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0)),
                          onPressed: () {
                            RoutesDoctor().toReportChartLine(
                                context,
                                idsMedicinesAverage,
                `                lineDataMedicinesDiscrepacy,
                                "Desfase en la toma de medicamentos \n \n",
                                "Meses",
                                "Desfase",
                                descriptionMedicines);
                          },
                          child: Image.asset(
                            "assets/images/output-onlinepngtools (3).png",
                            height: size.height * 0.08,
                          ),
                          color: Colors.grey[50],
                          textColor: Colors.white,
                        ),
                        Text(
                          "Desfase \nen la \nToma de\nMedicamentos\n ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.blue[900],
                              fontSize: 17,
                              fontFamily: "Raleway2"),
                        )*/
                        ElevatedButton(
                          style: buildButtonStyle(
                            border: roundedRadius18,
                            background: Colors.grey[50],
                            forground: Colors.white,
                          ),
                          onPressed: () {
                            RoutesDoctor().toReportChartLine(context, idsNoMotorsAverage, lineDataNoMotors, "Promedio de los puntajes en los síntomas no motores \n \n", "Semanas", "Promedio", descriptionNoMotors, dataDescriptionNoMotores);
                          },
                          child: Image.asset(
                            "assets/images/output-onlinepngtools (3).png",
                            height: size.height * 0.08,
                          ),
                        ),
                        Text(
                          "Promedio \nde los \n Puntajes\n en los\n Síntomas \n No Motores ",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.blue[900], fontSize: 17, fontFamily: "Raleway2"),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        ElevatedButton(
                          style: buildButtonStyle(border: roundedRadius18, background: Colors.grey[50], forground: Colors.white),
                          onPressed: () {
                            RoutesDoctor().toReportChartLine(context, idsSymptomsDaily, lineDataSymptomsDay, "Síntomas diario \n \n \n \n", "Hora", "Estado", descriptionSymptomsByDay, dataDescriptionSymptomsDay);
                          },
                          child: Image.asset(
                            "assets/images/output-onlinepngtools (3).png",
                            height: size.height * 0.08,
                          ),
                        ),
                        Text(
                          "Sintomas \n por día",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.blue[900], fontSize: 17, fontFamily: "Raleway2"),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          //  ),

          /*    FlatButton(
                onPressed: () {
                  RoutesDoctor()
                      .toReportChartSerie(context, "idquemado", seriedata);
                },
                child: Text("Promedio del ejercicio realizado"),
                color: Colors.blueAccent,
                textColor: Colors.white,
              ),
              FlatButton(
                onPressed: () {
                  RoutesDoctor()
                      .toReportChartSerie(context, "idquemado", seriedata);
                },
                child: Text("Promedio del ejercicio realizado comparado con los síntomas"),
                color: Colors.blueAccent,
                textColor: Colors.white,
              ),
              FlatButton(
                onPressed: () {
                  RoutesDoctor()
                      .toReportChartSerie(context, "idquemado", seriedata);
                },
                child: Text(
                    "Promedio del ejercicio realizado comparado con el ánimo"),
                color: Colors.blueAccent,
                textColor: Colors.white,
              ),*/
        ],
      ),
    );
  }
}

//____________________________DEFINIENDO LOS COLORES DE LAS GRÁFICAS______________-
_generateColorsSyntomsChart() {
  var colorsSintomasPorMeses = [];
  colorsSintomasPorMeses.add(Colors.green[700]);
  colorsSintomasPorMeses.add(Colors.lightGreen);
  colorsSintomasPorMeses.add(Colors.red);
  colorsSintomasPorMeses.add(Colors.red[800]);
  return colorsSintomasPorMeses;
}

//_________________________FUNCIÓN PARA PASAR LOS MESES DE INT A CADENA_______________-
String toMonthString(int month) {
  if (month == 1) {
    return "Enero";
  }
  if (month == 2) {
    return "Febrero";
  }
  if (month == 3) {
    return "Marzo";
  }
  if (month == 4) {
    return "Abril";
  }
  if (month == 5) {
    return "Mayo";
  }
  if (month == 6) {
    return "Junio";
  }
  if (month == 7) {
    return "Julio";
  }
  if (month == 8) {
    return "Agosto";
  }
  if (month == 9) {
    return "Septiembre";
  }
  if (month == 10) {
    return "Octubre";
  }
  if (month == 11) {
    return "Noviembre";
  }
  if (month == 12) {
    return "Diciembre";
  }
  return "Mes no encontrado";
}

returnDataPie(List<double> datos) {
  var linealdata = [
    new DataPieChart('ON MUY BUENO', datos[1], Colors.green[700]!),
    new DataPieChart('ON BUENO', datos[0], Colors.lightGreen),
    new DataPieChart('OFF MALO', datos[2], Colors.red),
    new DataPieChart('OFF MUY MALO', datos[3], Colors.red[800]!),
  ];
  return linealdata;
}

returnDataLineSymptomsByDay(int length, var symptomsDay) {
  var allData = [];
  List<DataLineSerie> data = [];
  for (int i = 0; i < length; i++) {
    data.add(new DataLineSerie(symptomsDay[i]['Hora'].toInt(), symptomsDay[i]['Estado'].toDouble())); // mes y promedio en tiempo del desfase calculado
  }
  allData.add(data);

  return allData;
}

returnDataLine(int length, var discrepancyaDataDecode) {
  //Gráfica de discrepancia del tiempo en la toma de médicamentos
  var allData = [];
  List<Animo> data = [];
  for (int i = 0; i < length; i++) {
    data.add(
      new Animo(
        discrepancyaDataDecode[i]['Promedio'].toDouble(),
        toMonthString(discrepancyaDataDecode[i]['mes']),
      ),
    ); // mes y promedio en tiempo del desfase calculado
  }
  allData.add(data);

  return allData;
}

returnDataLineMotors(int length, var motorsDataDecode) {
  //Gráfica de discrepancia del tiempo en la toma de médicamentos
  var allData = [];
  List<DataLineSerie> data = [];
  for (int i = 0; i < length; i++) {
    data.add(new DataLineSerie(motorsDataDecode[i]['Week'].toInt(), motorsDataDecode[i]['Promedio'].toDouble())); // mes y promedio en tiempo del desfase calculado
  }
  allData.add(data);

  return allData;
}

returnDataSeries(int length, var averageSymtomsByMonthResponseDecode) {
  //GRÁFICA PROMEDIO DE LOS SÍNTOMAS DEL PACIENTE POR MES, HAY QUE PASAR EL TÍTULO DE L GRÁFICA POR PARÁMETRO

  var allData = [];
  List<Animo> data1 = []; //todos los on por cada mes
  List<Animo> data2 = []; //todos los on buenos por cada mes
  List<Animo> data3 = []; //todos los off por cada mes
  List<Animo> data4 = []; //todos los off malos por cada mes
  for (int i = 0; i < length; i++) {
    //Este ciclo recoge todos los ON
    data1.add(new Animo(
      averageSymtomsByMonthResponseDecode[i]['on'].toDouble(),
      toMonthString(
        averageSymtomsByMonthResponseDecode[i]['mes'],
      ),
    )); // el més debemos pasarlo a String
  }
  allData.add(data1);

  for (int j = 0; j < length; j++) {
    //Este ciclo recoge todos los On buenos
    data2.add(new Animo(
      averageSymtomsByMonthResponseDecode[j]['onG'].toDouble(),
      toMonthString(averageSymtomsByMonthResponseDecode[j]['mes']),
    )); // el més debemos pasarlo a String
  }
  allData.add(data2);

  for (int i = 0; i < length; i++) {
    //Este ciclo recoge todos los ff
    data3.add(new Animo(
      averageSymtomsByMonthResponseDecode[i]['off'].toDouble(),
      toMonthString(averageSymtomsByMonthResponseDecode[i]['mes']),
    )); // el més debemos pasarlo a String
  }
  allData.add(data3);
  for (int i = 0; i < length; i++) {
    //Este ciclo recoge todos los ON
    data4.add(new Animo(
      averageSymtomsByMonthResponseDecode[i]['offB'].toDouble(),
      toMonthString(averageSymtomsByMonthResponseDecode[i]['mes']),
    )); // el més debemos pasarlo a String
  }
  allData.add(data4);

  return allData;
}

List returnDataSeriesGameAverage(int length, var averageGameResponseDecode) {
  //GRÁFICA PROMEDIO DE JUEGO COMPARADO CON LA CANTIDAD, HAY QUE PASAR EL TÍTULO DE L GRÁFICA POR PARÁMETRO

  var allData = [];
  List<Animo> data1 = []; //Promedio del puntaje por cada mes
  List<Animo> data2 = []; //Cantidad Jugada por cada mes
  for (int i = 0; i < length; i++) {
    //Este ciclo recoge el promedio de puntaje jugado por mes
    data1.add(new Animo(
      averageGameResponseDecode[i]['Promedio'].toDouble(),
      toMonthString(averageGameResponseDecode[i]['mes']),
    )); // el més debemos pasarlo a String
  }
  allData.add(data1);

  /*for (int j = 0; j < length; j++) {
    //Este ciclo recoge la cantidad de veces jugada por mes
    data2.add(new Animo(
        averageGameResponseDecode[j]['Cantidad'].toDouble(),
        toMonthString(averageGameResponseDecode[j]
            ['mes']))); // el més debemos pasarlo a String
  }*/
  allData.add(data2);
  return allData;
}

List returnDataPieAverageDiskinecias(int length, var averageDiskineciasResponseDecode) {
  var allData = [];
  List<Animo> data1 = []; //Promedio del puntaje del formulario por cada mes

  for (int i = 0; i < length; i++) {
    //Este ciclo recoge el promedio de puntaje de disquinecias por mes
    data1.add(new Animo(
      averageDiskineciasResponseDecode[i]['Promedio'].toDouble(),
      toMonthString(averageDiskineciasResponseDecode[i]['mes']),
    )); // el més debemos pasarlo a String
  }
  allData.add(data1);
  return allData;
}

List returnDataSeriesEmotionalAverage(int length, var averageGameResponseDecode) {
  //GRÁFICA PROMEDIO DE JUEGO COMPARADO CON LA CANTIDAD, HAY QUE PASAR EL TÍTULO DE L GRÁFICA POR PARÁMETRO
  var allData = [];

  List<Animo> data1 = []; //Promedio del puntaje del formulario por cada mes

  for (int i = 0; i < length; i++) {
    //Este ciclo recoge el promedio de puntaje del formulario emocional por mes
    data1.add(new Animo(
      averageGameResponseDecode[i]['Promedio'].toDouble(),
      toMonthString(averageGameResponseDecode[i]['mes']),
    )); // el més debemos pasarlo a String
  }
  allData.add(data1);

  return allData;
}

String _dataNoMotorsSymptoms(var arregloConPreguntasAfirmativas) {
  String dataFinal = "";
  for (int i = 0; i < arregloConPreguntasAfirmativas.length; i++) {
    if (arregloConPreguntasAfirmativas[i] == 'Q1') {
      dataFinal = dataFinal + "Salivación durante el día \n";
    }
    if (arregloConPreguntasAfirmativas[i] == 'Q2') {
      dataFinal = dataFinal + "Pérdida o alteración en la percepción de sabores u olores \n";
    }
    if (arregloConPreguntasAfirmativas[i] == 'Q3') {
      dataFinal = dataFinal + "Dificultad para pasar o deglutir comida o bebidas, o tendencia a atorarse \n";
      //
    }
    if (arregloConPreguntasAfirmativas[i] == 'Q4') {
      dataFinal = dataFinal + "Vómitos o náuseas \n";
      //
    }
    if (arregloConPreguntasAfirmativas[i] == 'Q5') {
      dataFinal = dataFinal + "Estreñimiento (hacer del cuerpo de 3 veces a la semana) o tener que hacer esfuerzos para hacer de vientre \n";
      //
    }
    if (arregloConPreguntasAfirmativas[i] == 'Q6') {
      dataFinal = dataFinal + "Incontinencia fecal (se escapan las heces) \n";
    }
    if (arregloConPreguntasAfirmativas[i] == 'Q7') {
      dataFinal = dataFinal + "Sensación de no haber vaciado por completo el vientre después de ir al baño \n";
      //
    }
    if (arregloConPreguntasAfirmativas[i] == 'Q8') {
      dataFinal = dataFinal + "Sensación de tener que orinar urgentemente que le obliga a ir rápidamente al baño";
      //
    }
    if (arregloConPreguntasAfirmativas[i] == 'Q9') {
      dataFinal = dataFinal + "Necesidad de levantarse habitualmente por la noche a orinar \n";
      //
    }
    if (arregloConPreguntasAfirmativas[i] == 'Q10') {
      dataFinal = dataFinal + "Dolores sin causa aparente (no debidos a otras enfermedades, como la artrosis) \n";
      //
    }
    if (arregloConPreguntasAfirmativas[i] == 'Q11') {
      dataFinal = dataFinal + "Cambio de peso sin causa aparente (no debido a un régimen o dieta) \n";
      //
    }
    if (arregloConPreguntasAfirmativas[i] == 'Q12') {
      dataFinal = dataFinal + "Problemas para recordar cosas que han pasado recientemente o dificultad para acordarse de cosas que tenía que hacer \n";
      //
    }
    if (arregloConPreguntasAfirmativas[i] == 'Q13') {
      dataFinal = dataFinal + "Pérdida de interés en lo que pasa a su alrededor o en realizar sus actividades \n";
      //
    }
    if (arregloConPreguntasAfirmativas[i] == 'Q14') {
      dataFinal = dataFinal + "Ver u oír cosas que sabe o que otras personas le dicen que no están ahí \n";
      //
    }
    if (arregloConPreguntasAfirmativas[i] == 'Q15') {
      dataFinal = dataFinal + "Dificultad para concentrarse o mantener la atención \n";
      //
    }
    if (arregloConPreguntasAfirmativas[i] == 'Q16') {
      dataFinal = dataFinal + "Sentirse triste, bajo/a de ánimo o decaído \n";
      //
    }
    if (arregloConPreguntasAfirmativas[i] == 'Q17') {
      dataFinal = dataFinal + "Sentimientos de ansiedad, miedo o pánico \n";
      //
    }
    if (arregloConPreguntasAfirmativas[i] == 'Q18') {
      dataFinal = dataFinal + "Pérdida o aumento del interés por tener relaciones sexuales \n";
      //
    }
    if (arregloConPreguntasAfirmativas[i] == 'Q19') {
      dataFinal = dataFinal + "Dificultades en la relación sexual cuando lo intenta \n";
      //
    }
    if (arregloConPreguntasAfirmativas[i] == 'Q20') {
      dataFinal = dataFinal + "Sensación de mareo o debilidad al ponerse de pie después de haber estado sentado o acostado \n";
      //
    }
    if (arregloConPreguntasAfirmativas[i] == 'Q21') {
      dataFinal = dataFinal + "Caídas \n";
      //
    }
    if (arregloConPreguntasAfirmativas[i] == 'Q22') {
      dataFinal = dataFinal + "Dificultad para mantenerse despierto/a mientras realiza actividades como trabajar, conducir o comer \n";
      //
    }
    if (arregloConPreguntasAfirmativas[i] == 'Q23') {
      dataFinal = dataFinal + "Dificultad para quedarse o mantenerse dormido por la noche \n";
      //
    }
    if (arregloConPreguntasAfirmativas[i] == 'Q24') {
      dataFinal = dataFinal + "Sueños intensos, vívidos o pesadillas \n";
      //
    }
    if (arregloConPreguntasAfirmativas[i] == 'Q25') {
      dataFinal = dataFinal + "Hablar o moverse durante el sueño como si lo estuviera viviendo \n";
      //
    }
    if (arregloConPreguntasAfirmativas[i] == 'Q26') {
      dataFinal = dataFinal + "Sensaciones desagradables en las piernas por la noche o cuando está descansando, y sensación de que necesita moverlas \n";
      //
    }
    if (arregloConPreguntasAfirmativas[i] == 'Q27') {
      dataFinal = dataFinal + "Hinchazón en las piernas \n";
      //
    }
    if (arregloConPreguntasAfirmativas[i] == 'Q28') {
      dataFinal = dataFinal + "Sudoración excesiva \n";
      //
    }
    if (arregloConPreguntasAfirmativas[i] == 'Q29') {
      dataFinal = dataFinal + "Visión doble \n";
      //
    }
    if (arregloConPreguntasAfirmativas[i] == 'Q30') {
      dataFinal = dataFinal + "Creer que le pasan cosas que otras personas le dicen que no son verdad \n";
    }
  }
  return dataFinal;
}
