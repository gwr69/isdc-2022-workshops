within ISDC2022_Workshops.Examples.PeopleExpress;

model PeopleExpress "Basic model for PEX dynamics"
  extends .Interfaces.PeopleExpressSimulationRun;
  extends BusinessSimulation.Icons.SimulationModel;
  Components.Fleet fleet "PEX fleet" annotation(Placement(visible = true, transformation(origin = {-60, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Components.Staff staff "PEX staff" annotation(Placement(visible = true, transformation(origin = {0, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Components.Passengers passengers2 annotation(Placement(visible = true, transformation(origin = {80, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
end PeopleExpress;
