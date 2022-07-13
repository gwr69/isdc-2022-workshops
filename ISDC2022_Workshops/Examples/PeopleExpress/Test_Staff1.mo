within ISDC2022_Workshops.Examples.PeopleExpress;

model Test_Staff1 "No Planes => no hiring; very large RPM => almost zero service quality"
  extends Interfaces.PeopleExpressSimulationRun;
  extends BusinessSimulation.Icons.Example;
  Interfaces.IO dataExchange "Data bus" annotation(Placement(visible = true, transformation(origin = {0, 40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {84.449, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BusinessSimulation.Converters.ConstantConverterRate revenuePassengerMiles(redeclare replaceable type ValueType = BusinessSimulation.Units.Amount, timeBaseString = "year", value(displayUnit = "billion") = 10000000000) "Revenue passenger miles per period" annotation(Placement(visible = true, transformation(origin = {-80, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Components.Staff staff "Staff subsystem" annotation(Placement(visible = true, transformation(origin = {0, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BusinessSimulation.Converters.ConstantConverter fleetsize(value = 0) "Aircraft in the fleed" annotation(Placement(visible = true, transformation(origin = {-80, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(staff.io, dataExchange) annotation(Line(visible = true, origin = {0, 20}, points = {{0, -20}, {-0, 20}}, color = {0, 0, 128}));
  connect(fleetsize.y, dataExchange.aircraft) "input planes" annotation(Line(visible = true, origin = {-38.5, 30}, points = {{-35.5, -10}, {-1.5, -10}, {-1.5, 10}, {38.5, 10}}, color = {1, 37, 163}, smooth = Smooth.Bezier));
  connect(revenuePassengerMiles.y, dataExchange.RPM) "input RPM" annotation(Line(visible = true, origin = {-43.5, 50}, points = {{-30.5, 10}, {-6.5, 10}, {-6.5, -10}, {43.5, -10}}, color = {1, 37, 163}, smooth = Smooth.Bezier));
  annotation(Documentation(info = "<html>
<p class=\"aside\">This information is part of the ISDC2022 Workshops package.</p>
<p>Test example.</p>
</html>"));
end Test_Staff1;
