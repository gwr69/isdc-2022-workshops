within ISDC2022_Workshops.Examples.PeopleExpress;

model TestFleet_2 "No passengers means no growth"
  extends Interfaces.PeopleExpressSimulationRun;
  extends BusinessSimulation.Icons.Example;
  parameter BusinessSimulation.Units.TangibleAssets initAC = 3 "Initial number of aircraft (fleet.initAC)";
  BusinessSimulation.Interfaces.Connectors.RealOutput y "Model output: aircraft" annotation(Placement(visible = true, transformation(origin = {90, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {61.608, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BusinessSimulation.Interfaces.Connectors.RealOutput y_ctrl "Control output: aircraft" annotation(Placement(visible = true, transformation(origin = {90, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {60, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BusinessSimulation.Converters.ConstantConverter ctrlAircraft(value = initAC) annotation(Placement(visible = true, transformation(origin = {40, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
protected
  Components.Fleet fleet(initAC = initAC) "The fleet subsystem" annotation(Placement(visible = true, transformation(origin = {0, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Interfaces.IO dataExchange "Data bus" annotation(Placement(visible = true, transformation(origin = {0, 40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {84.449, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BusinessSimulation.Converters.ConstantConverterRate potentialPassengerMiles(redeclare replaceable type ValueType = BusinessSimulation.Units.Amount, timeBaseString = "year", value(displayUnit = "billion") = 0) "Have very large number, so that loadFactor is always one" annotation(Placement(visible = true, transformation(origin = {-45, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(fleet.io, dataExchange) annotation(Line(visible = true, origin = {0, 30}, points = {{0, -10}, {0, 10}}, color = {0, 0, 128}));
  connect(potentialPassengerMiles.y, dataExchange.potentialPassengerMiles) annotation(Line(visible = true, origin = {-19.5, 40}, points = {{-19.5, 0}, {19.5, 0}}, color = {1, 37, 163}));
  connect(dataExchange.aircraft, y) "model output aircraft" annotation(Line(visible = true, origin = {45, 40}, points = {{-45, 0}, {45, 0}}, color = {0, 0, 128}));
  connect(ctrlAircraft.y, y_ctrl) annotation(Line(visible = true, origin = {68, -20}, points = {{-22, 0}, {22, 0}}, color = {1, 37, 163}));
  annotation(Documentation(info = "<html>
<p class=\"aside\">This information is part of the ISDC2022 Workshops package.</p>
<p>If there are no passengers, then the fleet size should remain at its initial value.</p>
</html>"));
end TestFleet_2;
