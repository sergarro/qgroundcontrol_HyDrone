/****************************************************************************
 *
 * (c) 2009-2020 QGROUNDCONTROL PROJECT <http://www.qgroundcontrol.org>
 *
 * QGroundControl is licensed according to the terms in the file
 * COPYING.md in the root of the source code directory.
 *
 ****************************************************************************/

import QtQuick                  2.12
import QtQuick.Controls         2.4
import QtQuick.Dialogs          1.3
import QtQuick.Layouts          1.12

import QtLocation               5.3
import QtPositioning            5.3
import QtQuick.Window           2.2
import QtQml.Models             2.1

import QGroundControl               1.0
import QGroundControl.Airspace      1.0
import QGroundControl.Airmap        1.0
import QGroundControl.Controllers   1.0
import QGroundControl.Controls      1.0
import QGroundControl.FactSystem    1.0
import QGroundControl.FlightDisplay 1.0
import QGroundControl.FlightMap     1.0
import QGroundControl.Palette       1.0
import QGroundControl.ScreenTools   1.0
import QGroundControl.Vehicle       1.0

import MAVLink                      1.0

// To implement a custom overlay copy this code to your own control in your custom code source. Then override the
// FlyViewCustomLayer.qml resource with your own qml. See the custom example and documentation for details.
Item {
    id: _root

    property var parentToolInsets               // These insets tell you what screen real estate is available for positioning the controls in your overlay
    property var totalToolInsets:   _toolInsets // These are the insets for your custom overlay additions
    property var mapControl

    QGCToolInsets {
        id:                         _toolInsets
        leftEdgeCenterInset:    0
        leftEdgeTopInset:           0
        leftEdgeBottomInset:        0
        rightEdgeCenterInset:   0
        rightEdgeTopInset:          0
        rightEdgeBottomInset:       0
        topEdgeCenterInset:       0
        topEdgeLeftInset:           0
        topEdgeRightInset:          0
        bottomEdgeCenterInset:    0
        bottomEdgeLeftInset:        0
        bottomEdgeRightInset:       0
    }
    property int batteryMode: batteryStatusMessage.mode
    Rectangle {
        id: batt
        width: 200
        height: 400
        color: Qt.rgba(0, 0, 0, 0.5)
        radius: 20
        anchors.bottom: _root.bottom
        anchors.right: _root.right
        anchors.bottomMargin: 10
        anchors.rightMargin: 10
        /*Text {
                    //text: "Información"
                    color: "white"
                    anchors.centerIn: parent
                }*/
        ColumnLayout {
            id:                 mainLayout
            anchors.margins:    ScreenTools.defaultFontPixelWidth
            anchors.top:        parent.top
            anchors.right:      parent.right
            spacing:            ScreenTools.defaultFontPixelHeight

            QGCLabel {
                Layout.alignment:   Qt.AlignCenter
                text:               qsTr("Hidrogen Battery Status")
                font.family:        ScreenTools.demiboldFontFamily
            }

            RowLayout {
                spacing: ScreenTools.defaultFontPixelWidth

                ColumnLayout {
                    Repeater {
                        model: _activeVehicle ? _activeVehicle.batteries : 0

                        ColumnLayout {
                            spacing: 0

                            property var batteryValuesAvailable: nameAvailableLoader.item

                            Loader {
                                id:                 nameAvailableLoader
                                sourceComponent:    batteryValuesAvailableComponent

                                property var battery: object
                            }


                            QGCLabel { text: qsTr("Op State") }
                            QGCLabel { text: qsTr("        ") }

                            QGCLabel { text: qsTr("Temp max")}
                            QGCLabel { text: qsTr("Stack V")}
                            QGCLabel { text: qsTr("Load Current")}
                            QGCLabel { text: qsTr("Power")}
                            QGCLabel { text: qsTr("Energy")}
                            QGCLabel { text: qsTr("Batt V")}
                            QGCLabel { text: qsTr("Batt Current")}
                            QGCLabel { text: qsTr("Load V")}
                            QGCLabel { text: qsTr("H2 pres(1)")}
                            QGCLabel { text: qsTr("H2 pres(2)")}
                            QGCLabel { text: qsTr("Fan speed")}
                            QGCLabel { text: qsTr("Battery %")}
                            QGCLabel { text: qsTr("H2 %")}

                        }
                    }
                }

                ColumnLayout {
                    Repeater {
                        model: _activeVehicle ? _activeVehicle.batteries : 0

                        ColumnLayout {
                            spacing: 0

                            property var batteryValuesAvailable: valueAvailableLoader.item

                            Loader {
                                id:                 valueAvailableLoader
                                sourceComponent:    batteryValuesAvailableComponent

                                property var battery: object
                            }

                            //QGCLabel { text: "" }

                            //QGCLabel { text: object.mode.valueString  }
                            QGCLabel {
                                text: {
                                    if (object.mode.valueString === "0") {
                                        return "Startup";
                                    } else if (object.mode.valueString === "1") {
                                        return "Startup";
                                    } else if (object.mode.valueString === "2") {
                                        return "Startup";
                                    } else if (object.mode.valueString === "3") {
                                        return "Startup";
                                    } else if (object.mode.valueString === "4") {
                                        return "Startup";
                                    } else if (object.mode.valueString === "5") {
                                        return "Startup";
                                    } else if (object.mode.valueString === "6") {
                                        return "Operation";
                                    } else if (object.mode.valueString === "7") {
                                        return "Operation";
                                    } else if (object.mode.valueString === "8") {
                                        return "Shutdown";
                                    } else if (object.mode.valueString === "9") {
                                        return "Shutdown";
                                    } else if (object.mode.valueString === "10") {
                                        return "ERROR";
                                    } else {
                                        return object.mode.valueString;
                                    }
                                }
                            }
                            QGCLabel {
                                text: {
                                    if (object.mode.valueString === "0") {
                                        return "No state";
                                    } else if (object.mode.valueString === "1") {
                                        return "Inputs ready";
                                    } else if (object.mode.valueString === "2") {
                                        return "Loop ready";
                                    } else if (object.mode.valueString === "3") {
                                        return "Start HGS";
                                    } else if (object.mode.valueString === "4") {
                                        return "Checking start up";
                                    } else if (object.mode.valueString === "5") {
                                        return "Clean Stack";
                                    } else if (object.mode.valueString === "6") {
                                        return "Operation";
                                    } else if (object.mode.valueString === "7") {
                                        return "Conditioning";
                                    } else if (object.mode.valueString === "8") {
                                        return "Shutdown";
                                    } else if (object.mode.valueString === "9") {
                                        return "OFF";
                                    } else if (object.mode.valueString === "10") {
                                        return "ERROR";
                                    } else {
                                        return object.mode.valueString;
                                    }
                                }
                            }
                            QGCLabel { text: object.temperature.valueString + " " + object.temperature.units }
                            QGCLabel { text: object.stackv.valueString/10 + " V" }
                            QGCLabel { text: object.currentbattery.valueString/100 + " A"  }
                            QGCLabel { text: object.mahConsumed.valueString/10 + " W" }
                            QGCLabel { text: object.energy.valueString/100 + " Wh" }
                            QGCLabel { text: object.battvolt.valueString/10 + " V" }
                            QGCLabel { text: object.type.rawValue == 1 ? "-"+object.timeRemaining.valueString/10 + " A" : object.timeRemaining.valueString/10 + " A" }
                            QGCLabel { text: object.loadvolt.valueString/10 + " V" }
                            QGCLabel { text: object.h2press1.valueString/100 + " B" }
                            QGCLabel { text: object.h2press2.valueString/10 + " B" }
                            QGCLabel { text: object.fanspeed.valueString/10 + " %" }
                            QGCLabel { text: object.percentRemaining.valueString + " %" }
                            QGCLabel { text: Math.round(100-object.energy.valueString/1060) + " %" }
                        }
                    }
                }
            }
        }
    }
}
