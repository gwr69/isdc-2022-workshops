within ISDC2022_Workshops.Examples.PeopleExpress;

model TestFleet_1 "Full planes at all times means we see unrestricted exponential growth"
  extends Interfaces.PeopleExpressSimulationRun;
  extends BusinessSimulation.Icons.Example;
  parameter BusinessSimulation.Units.TangibleAssets initAC = 3 "Initial number of aircraft (fleet.initAC)";
  parameter BusinessSimulation.Units.Rate growthTarget(displayUnit = "1/yr") = 3.17097919837646e-09 "Growth rate envisoned by Don Burr (fleet.growthTarget)";
  BusinessSimulation.Interfaces.Connectors.RealOutput y "Model output: aircraft" annotation(Placement(visible = true, transformation(origin = {90, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {61.898, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BusinessSimulation.Interfaces.Connectors.RealOutput y_ctrl "Control output: aircraft" annotation(Placement(visible = true, transformation(origin = {90, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {60, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
protected
  Components.Fleet fleet(initAC = initAC, growthTarget = growthTarget) "The fleet subsystem" annotation(Placement(visible = true, transformation(origin = {0, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Interfaces.IO dataExchange "Data bus" annotation(Placement(visible = true, transformation(origin = {0, 40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {84.449, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BusinessSimulation.Converters.ConstantConverterRate potentialPassengerMiles(redeclare replaceable type ValueType = BusinessSimulation.Units.Amount, timeBaseString = "year", value(displayUnit = "billion") = 10000000000) "Have very large number, so that loadFactor is always one" annotation(Placement(visible = true, transformation(origin = {-40, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BusinessSimulation.Stocks.InformationLevel ctrlAircraft(initialValue = initAC) "control stock" annotation(Placement(visible = true, transformation(origin = {0, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BusinessSimulation.SourcesOrSinks.ExponentialGrowth ctrlPurchasing(hasConstantRate = true, fractionalRate = growthTarget) "Control flow" annotation(Placement(visible = true, transformation(origin = {-40, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(fleet.io, dataExchange) annotation(Line(visible = true, origin = {0, 30}, points = {{0, -10}, {0, 10}}, color = {0, 0, 128}));
  connect(potentialPassengerMiles.y, dataExchange.potentialPassengerMiles) annotation(Line(visible = true, origin = {-17, 40}, points = {{-17, 0}, {17, 0}}, color = {1, 37, 163}));
  connect(ctrlPurchasing.massPort, ctrlAircraft.inflow) annotation(Line(visible = true, origin = {-20, -40}, points = {{-10, 0}, {10, 0}}, color = {128, 0, 128}));
  connect(ctrlAircraft.y, y_ctrl) annotation(Line(visible = true, origin = {33.333, -23.2}, points = {{-28.333, -6.4}, {-28.333, 3.2}, {56.667, 3.2}}, color = {1, 37, 163}));
  connect(dataExchange.aircraft, y) "output aircraft" annotation(Line(visible = true, origin = {42.5, 30}, points = {{-42.5, 10}, {-2.5, 10}, {-2.5, 10}, {47.5, 10}}, color = {0, 0, 128}));
  annotation(Documentation(info = "<html>
<p class=\"aside\">This information is part of the ISDC2022 Workshops package.</p>
<p>This test should show, that in the case of <code>loadFactor</code> being <code>1.0</code> the fleet should simply show exponential growth at the rate envision by the CEO.</p>
</html>"));
end TestFleet_1;
