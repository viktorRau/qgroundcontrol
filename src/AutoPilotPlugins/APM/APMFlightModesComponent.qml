/*=====================================================================

 QGroundControl Open Source Ground Control Station

 (c) 2009 - 2015 QGROUNDCONTROL PROJECT <http://www.qgroundcontrol.org>

 This file is part of the QGROUNDCONTROL project

 QGROUNDCONTROL is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.

 QGROUNDCONTROL is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with QGROUNDCONTROL. If not, see <http://www.gnu.org/licenses/>.

 ======================================================================*/

import QtQuick                  2.5
import QtQuick.Controls         1.2

import QGroundControl.FactSystem    1.0
import QGroundControl.FactControls  1.0
import QGroundControl.Palette       1.0
import QGroundControl.Controls      1.0
import QGroundControl.Controllers   1.0
import QGroundControl.ScreenTools   1.0

QGCView {
    id:         rootQGCView
    viewPanel:  panel

    QGCPalette { id: qgcPal; colorGroupEnabled: panel.enabled }

    APMFlightModesComponentController {
        id:         controller
        factPanel:  panel
    }

    QGCViewPanel {
        id:             panel
        anchors.fill:   parent

        Flickable {
            anchors.fill: parent

            Column {
                width:  parent.width
                spacing: ScreenTools.defaultFontPixelHeight

                QGCLabel {
                    text: "Channel 5 Flight Mode Settings"
                    font.weight: Font.DemiBold
                }

                Rectangle {
                    width:  parent.width
                    height: flightModeColumn.height + ScreenTools.defaultFontPixelHeight
                    color:  qgcPal.windowShade

                    Column {
                        id:                 flightModeColumn
                        anchors.margins:    ScreenTools.defaultFontPixelWidth
                        anchors.left:       parent.left
                        anchors.right:      parent.right
                        anchors.top:        parent.top
                        spacing:            ScreenTools.defaultFontPixelHeight

                        Repeater {
                            model:  6

                            Row {
                                spacing: ScreenTools.defaultFontPixelWidth

                                property int index: modelData + 1

                                QGCLabel {
                                    anchors.baseline:   modeCombo.baseline
                                    text:               "Flight Mode " + index + ":"
                                }

                                FactComboBox {
                                    id:         modeCombo
                                    width:      ScreenTools.defaultFontPixelWidth * 15
                                    fact:       controller.getParameterFact(-1, "FLTMODE" + index)
                                    indexModel: false
                                }

                                QGCCheckBox {
                                    id:                 simple
                                    anchors.baseline:   modeCombo.baseline
                                    text:               "Simple Mode"
                                    visible:            !controller.fixedWing
                                    checked:            isChecked()

                                    onClicked: {
                                        var simpleFact = controller.getParameterFact(-1, "SIMPLE")
                                        if (checked) {
                                            simpleFact.value |= 1 << modelData
                                        } else {
                                            simpleFact.value &= ~modelData
                                        }
                                    }

                                    function isChecked() {
                                        if (simple.visible) {
                                            var simpleFact = controller.getParameterFact(-1, "SIMPLE")
                                            return simpleFact.value & (1 << modelData)
                                        } else {
                                            return false;
                                        }
                                    }
                                }

                                QGCCheckBox {
                                    id:                 superSimple
                                    anchors.baseline:   modeCombo.baseline
                                    text:               "Super Simple Mode"
                                    visible:            !controller.fixedWing
                                    checked:            isChecked()

                                    onClicked: {
                                        var simpleFact = controller.getParameterFact(-1, "SUPER_SIMPLE")
                                        if (checked) {
                                            simpleFact.value |= 1 << modelData
                                        } else {
                                            simpleFact.value &= ~modelData
                                        }
                                    }

                                    function isChecked() {
                                        if (superSimple.visible) {
                                            var simpleFact = controller.getParameterFact(-1, "SUPER_SIMPLE")
                                            return simpleFact.value & (1 << modelData)
                                        } else {
                                            return false;
                                        }
                                    }
                                }
                            }
                        } // Repeater - Flight Modes
                    } // Column - Flight Modes
                } // Rectangle - Flight Modes

                QGCLabel {
                    text: "Channel Options"
                    font.weight: Font.DemiBold
                }

                Rectangle {
                    width:  parent.width
                    height: channelOptColumn.height + ScreenTools.defaultFontPixelHeight
                    color:  qgcPal.windowShade

                    Column {
                        id:                 channelOptColumn
                        anchors.margins:    ScreenTools.defaultFontPixelWidth
                        anchors.left:       parent.left
                        anchors.right:      parent.right
                        anchors.top:        parent.top
                        spacing:            ScreenTools.defaultFontPixelHeight

                        Repeater {
                            model: 6

                            Row {
                                spacing: ScreenTools.defaultFontPixelWidth

                                property int index: modelData + 7

                                QGCLabel {
                                    anchors.baseline:   optCombo.baseline
                                    text:               "Channel option " + index + ":"
                                }

                                FactComboBox {
                                    id:         optCombo
                                    width:      ScreenTools.defaultFontPixelWidth * 15
                                    fact:       controller.getParameterFact(-1, "CH" + index + "_OPT")
                                    indexModel: false
                                }
                            }
                        } // Repeater -- Channel options
                    } // Column - Channel options
                } // Rectangle - Channel options
            } // Column
        } // FLickable
    } // QGCViewPanel
} // QGCView