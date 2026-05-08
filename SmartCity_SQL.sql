
--WattWatch SQL Analysis Project

--1. Total and Average Daily Energy Consumption by Zone
                  SELECT Zone,
                  SUM(EnergyConsumed_kWh) AS TotalConsumption,
                 AVG(EnergyConsumed_kWh) AS AvgDailyConsumption
                 FROM SmartCityEnergy
                 GROUP BY Zone;


--2. Top 5 Highest Energy-Consuming Consumers by Type
         
    SELECT ConsumerType,
        MeterID,
        SUM(EnergyConsumed_kWh) AS TotalEnergy
        FROM SmartCityEnergy
        GROUP BY ConsumerType, MeterID 
        ORDER BY TotalEnergy DESC
         LIMIT 5;

-- 3. Monthly Trend of Consumption Across Zones
SELECT strftime('%Y-%m', Date) AS Month,
       Zone,
       SUM(EnergyConsumed_kWh) AS MonthlyConsumption
FROM SmartCityEnergy
GROUP BY Month, Zone
ORDER BY Month;

-- 4. Average Cost Per Zone
SELECT Zone,
       AVG(EnergyConsumed_kWh * TariffRate) AS AvgCost
FROM SmartCityEnergy
GROUP BY Zone;

-- 5. Meters with Highest Number of Faults or Outages
SELECT MeterID,
       COUNT(*) AS FaultCount,
       SUM(OutageMinutes) AS TotalOutage
FROM SmartCityEnergy
WHERE MeterStatus = 'Faulty'
GROUP BY MeterID
ORDER BY FaultCount DESC, TotalOutage DESC;

-- 6. Zones with Lowest Energy Efficiency
SELECT Zone,
       AVG(EnergyConsumed_kWh) AS AvgUsage,
       AVG(OutageMinutes) AS AvgOutage
FROM SmartCityEnergy
GROUP BY Zone
ORDER BY AvgUsage DESC, AvgOutage DESC;

-- 7. Peak Usage Patterns: Weekdays vs Weekends
SELECT CASE
           WHEN strftime('%w', Date) IN ('0','6') THEN 'Weekend'
           ELSE 'Weekday'
       END AS DayType,
       AVG(PeakUsage_kWh) AS AvgPeakUsage
FROM SmartCityEnergy
GROUP BY DayType;

