/****************************************************************************
 *
 *   (c) 2009-2016 QGROUNDCONTROL PROJECT <http://www.qgroundcontrol.org>
 *
 * QGroundControl is licensed according to the terms in the file
 * COPYING.md in the root of the source code directory.
 *
 ****************************************************************************/

#ifndef ComplexMissionItem_H
#define ComplexMissionItem_H

#include "VisualMissionItem.h"

class ComplexMissionItem : public VisualMissionItem
{
    Q_OBJECT

public:
    ComplexMissionItem(Vehicle* vehicle, QObject* parent = NULL);

    const ComplexMissionItem& operator=(const ComplexMissionItem& other);

    Q_PROPERTY(double   complexDistance     READ complexDistance    NOTIFY complexDistanceChanged)

    /// @return The distance covered the complex mission item in meters.
    virtual double complexDistance(void) const = 0;

    /// @return Amount of additional time delay in seconds needed to fly the complex item
    virtual double additionalTimeDelay(void) const { return 0; }

    /// Load the complex mission item from Json
    ///     @param complexObject Complex mission item json object
    ///     @param sequenceNumber Sequence number for first MISSION_ITEM in survey
    ///     @param[out] errorString Error if load fails
    /// @return true: load success, false: load failed, errorString set
    virtual bool load(const QJsonObject& complexObject, int sequenceNumber, QString& errorString) = 0;

    /// Get the point of complex mission item furthest away from a coordinate
    ///     @param other QGeoCoordinate to which distance is calculated
    /// @return the greatest distance from any point of the complex item to some coordinate
    virtual double greatestDistanceTo(const QGeoCoordinate &other) const = 0;

    /// This mission item attribute specifies the type of the complex item.
    static const char* jsonComplexItemTypeKey;

signals:
    void complexDistanceChanged     (double complexDistance);
    void additionalTimeDelayChanged (double additionalTimeDelay);
};

#endif
