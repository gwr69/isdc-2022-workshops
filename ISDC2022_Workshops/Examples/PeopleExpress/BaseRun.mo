within ISDC2022_Workshops.Examples.PeopleExpress;

model BaseRun "Basic model for PEX dynamics"
  extends ISDC2022_Workshops.Interfaces.PeopleExpressSimulationRun;
  extends BusinessSimulation.Icons.SimulationModel;
  Components.Fleet fleet "PEX fleet subsystem" annotation(Placement(visible = true, transformation(origin = {-60, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Components.Staff staff "PEX staff subsystem" annotation(Placement(visible = true, transformation(origin = {0, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Components.Passengers passengers "PEX passenger subsystem" annotation(Placement(visible = true, transformation(origin = {80, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Interfaces.IO dataBus annotation(Placement(visible = true, transformation(origin = {0, 50}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {0, 55.556}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(dataBus, staff.io) annotation(Line(visible = true, origin = {0, 20}, points = {{-0, 30}, {0, -30}}, color = {0, 0, 128}));
  connect(dataBus, passengers.io) annotation(Line(visible = true, origin = {53.333, 43.333}, points = {{-53.333, 6.667}, {26.667, 6.667}, {26.667, -13.333}}, color = {0, 0, 128}));
  connect(dataBus, fleet.io) annotation(Line(visible = true, origin = {-40, 43.333}, points = {{40, 6.667}, {-20, 6.667}, {-20, -13.333}}, color = {0, 0, 128}));
end BaseRun;
