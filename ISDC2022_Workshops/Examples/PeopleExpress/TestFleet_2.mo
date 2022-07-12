within ISDC2022_Workshops.Examples.PeopleExpress;

model TestFleet_2 "No passengers means no growth"
  extends .Interfaces.PeopleExpressSimulationRun;
  extends BusinessSimulation.Icons.Example;
  Components.Fleet fleet "The fleet subsystem" annotation(Placement(visible = true, transformation(origin = {0, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Interfaces.IO dataExchange "Data bus" annotation(Placement(visible = true, transformation(origin = {0, 40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {84.449, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BusinessSimulation.Converters.ConstantConverterRate potentialPassengerMiles(redeclare replaceable type ValueType = BusinessSimulation.Units.Amount, timeBaseString = "year", value(displayUnit = "billion") = 0) "Have very large number, so that loadFactor is always one" annotation(Placement(visible = true, transformation(origin = {-70, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(fleet.io, dataExchange) annotation(Line(visible = true, origin = {0, 20}, points = {{0, -20}, {0, 20}}, color = {0, 0, 128}));
  connect(potentialPassengerMiles.y, dataExchange.potentialPassengerMiles) annotation(Line(visible = true, origin = {-32, 40}, points = {{-32, 0}, {32, 0}}, color = {1, 37, 163}));
end TestFleet_2;
