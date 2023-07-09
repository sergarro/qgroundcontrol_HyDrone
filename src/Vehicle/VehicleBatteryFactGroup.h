/****************************************************************************
 *
 * (c) 2009-2020 QGROUNDCONTROL PROJECT <http://www.qgroundcontrol.org>
 *
 * QGroundControl is licensed according to the terms in the file
 * COPYING.md in the root of the source code directory.
 *
 ****************************************************************************/

#pragma once

#include "FactGroup.h"
#include "QGCMAVLink.h"

class Vehicle;

class VehicleBatteryFactGroup : public FactGroup
{
    Q_OBJECT

public:
    VehicleBatteryFactGroup(uint8_t batteryId, QObject* parent = nullptr);

    Q_PROPERTY(Fact* id                 READ id                 CONSTANT)
    Q_PROPERTY(Fact* function           READ function           CONSTANT)
    Q_PROPERTY(Fact* type               READ type               CONSTANT)
    Q_PROPERTY(Fact* temperature        READ temperature        CONSTANT)
    Q_PROPERTY(Fact* voltage            READ voltage            CONSTANT)
    Q_PROPERTY(Fact* current            READ current            CONSTANT)
    Q_PROPERTY(Fact* mahConsumed        READ mahConsumed        CONSTANT)
    Q_PROPERTY(Fact* percentRemaining   READ percentRemaining   CONSTANT)
    Q_PROPERTY(Fact* timeRemaining      READ timeRemaining      CONSTANT)
    Q_PROPERTY(Fact* timeRemainingStr   READ timeRemainingStr   CONSTANT)
    Q_PROPERTY(Fact* chargeState        READ chargeState        CONSTANT)
    Q_PROPERTY(Fact* instantPower       READ instantPower       CONSTANT)
    Q_PROPERTY(Fact* mode               READ mode               CONSTANT)
    Q_PROPERTY(Fact* stackv             READ stackv             CONSTANT)
    Q_PROPERTY(Fact* currentbattery     READ currentbattery     CONSTANT)
    Q_PROPERTY(Fact* energy             READ energy             CONSTANT)
    Q_PROPERTY(Fact* battvolt             READ battvolt             CONSTANT)
    Q_PROPERTY(Fact* loadvolt             READ loadvolt             CONSTANT)
    Q_PROPERTY(Fact* h2press1             READ h2press1             CONSTANT)
    Q_PROPERTY(Fact* h2press2             READ h2press2             CONSTANT)
    Q_PROPERTY(Fact* fanspeed             READ fanspeed             CONSTANT)

    Fact* id                        () { return &_batteryIdFact; }
    Fact* function                  () { return &_batteryFunctionFact; }
    Fact* type                      () { return &_batteryTypeFact; }
    Fact* voltage                   () { return &_voltageFact; }
    Fact* percentRemaining          () { return &_percentRemainingFact; }
    Fact* mahConsumed               () { return &_mahConsumedFact; }
    Fact* current                   () { return &_currentFact; }
    Fact* temperature               () { return &_temperatureFact; }
    Fact* instantPower              () { return &_instantPowerFact; }
    Fact* timeRemaining             () { return &_timeRemainingFact; }
    Fact* timeRemainingStr          () { return &_timeRemainingStrFact; }
    Fact* chargeState               () { return &_chargeStateFact; }
    Fact* mode                      () { return &_modeFact; }
    Fact* stackv                    () { return &_stackvFact; }
    Fact* currentbattery            () { return &_currentbatteryFact; }
    Fact* energy                    () { return &_energyFact; }
    Fact* battvolt                    () { return &_battvoltFact; }
    Fact* loadvolt                    () { return &_loadvoltFact; }
    Fact* h2press1                    () { return &_h2press1Fact; }
    Fact* h2press2                    () { return &_h2press2Fact; }
    Fact* fanspeed                    () { return &_fanspeedFact; }

    static const char* _batteryIdFactName;
    static const char* _batteryFunctionFactName;
    static const char* _batteryTypeFactName;
    static const char* _temperatureFactName;
    static const char* _voltageFactName;
    static const char* _currentFactName;
    static const char* _mahConsumedFactName;
    static const char* _percentRemainingFactName;
    static const char* _timeRemainingFactName;
    static const char* _timeRemainingStrFactName;
    static const char* _chargeStateFactName;
    static const char* _instantPowerFactName;
    static const char* _modeFactName;
    static const char* _stackvFactName;
    static const char* _currentbatteryFactName;
    static const char* _energyFactName;
    static const char* _battvoltFactName;
    static const char* _loadvoltFactName;
    static const char* _fanspeedFactName;
    static const char* _h2press1FactName;
    static const char* _h2press2FactName;

    static const char* _settingsGroup;

    /// Creates a new fact group for the battery id as needed and updates the Vehicle with it
    static void handleMessageForFactGroupCreation(Vehicle* vehicle, mavlink_message_t& message);

    // Overrides from FactGroup
    void handleMessage(Vehicle* vehicle, mavlink_message_t& message) override;

private slots:
    void _timeRemainingChanged(QVariant value);

private:
    static void                     _handleHighLatency          (Vehicle* vehicle, mavlink_message_t& message);
    static void                     _handleHighLatency2         (Vehicle* vehicle, mavlink_message_t& message);
    static void                     _handleBatteryStatus        (Vehicle* vehicle, mavlink_message_t& message);
    static VehicleBatteryFactGroup* _findOrAddBatteryGroupById  (Vehicle* vehicle, uint8_t batteryId);

    Fact            _batteryIdFact;
    Fact            _batteryFunctionFact;
    Fact            _batteryTypeFact;
    Fact            _voltageFact;
    Fact            _currentFact;
    Fact            _mahConsumedFact;
    Fact            _temperatureFact;
    Fact            _percentRemainingFact;
    Fact            _timeRemainingFact;
    Fact            _timeRemainingStrFact;
    Fact            _chargeStateFact;
    Fact            _instantPowerFact;
    Fact            _modeFact;
    Fact            _stackvFact;
    Fact            _currentbatteryFact;
    Fact            _energyFact;
    Fact            _battvoltFact;
    Fact            _loadvoltFact;
    Fact            _h2press1Fact;
    Fact            _h2press2Fact;
    Fact            _fanspeedFact;


    static const char* _batteryFactGroupNamePrefix;
};
