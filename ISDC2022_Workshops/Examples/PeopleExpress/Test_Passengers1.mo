within ISDC2022_Workshops.Examples.PeopleExpress;

model Test_Passengers1 "Service quality = 1 => neglectible churnRate (<< 0.001 p.a.)"
  extends Interfaces.PeopleExpressSimulationRun;
  extends BusinessSimulation.Icons.Example;
  Interfaces.IO dataExchange "Data bus" annotation(Placement(visible = true, transformation(origin = {0, 40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {84.449, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BusinessSimulation.Converters.ConstantConverter serviceQuality(value = 1) "Service quality" annotation(Placement(visible = true, transformation(origin = {-80, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Components.Passengers passengers(competitorFare.init = BusinessSimulation.Types.InitializationOptions.FixedValue, serviceReputation.init = BusinessSimulation.Types.InitializationOptions.SteadyState) "Passenger subsystem" annotation(Placement(visible = true, transformation(origin = {0, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(passengers.io, dataExchange) annotation(Line(visible = true, origin = {0, 20}, points = {{0, -20}, {-0, 20}}, color = {0, 0, 128}));
  connect(serviceQuality.y, dataExchange.serviceQuality) "input service quality" annotation(Line(visible = true, origin = {-37, 40}, points = {{-37, 0}, {37, 0}}, color = {1, 37, 163}));
  annotation(Documentation(info = "<html>
<p class=\"aside\">This information is part of the ISDC2022 Workshops package.</p>
<p>Test example.</p>
</html>"));
end Test_Passengers1;
