within ISDC2022_Workshops.Components;

model Staff "People express staff"
  extends Interfaces.Staff;
  BusinessSimulation.Stocks.MaterialStock experiencedStaff(initialValue = 250) "Experienced personnel" annotation(Placement(visible = true, transformation(origin = {40, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BusinessSimulation.Stocks.DelayN newStaff(hasConstantDelayTime = false) "Freshly recruited personnel" annotation(Placement(visible = true, transformation(origin = {-40, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BusinessSimulation.Flows.Unidirectional.OutflowDynamicStock advancing "New staff becoming experienced" annotation(Placement(visible = true, transformation(origin = {0, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BusinessSimulation.SourcesOrSinks.ExponentialDecline leaving "Personnel leaving the company" annotation(Placement(visible = true, transformation(origin = {80, -10}, extent = {{10, 10}, {-10, -10}}, rotation = 0)));
  BusinessSimulation.SourcesOrSinks.Growth hiring "Recruiting new personnel" annotation(Placement(visible = true, transformation(origin = {-80, -10}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  BusinessSimulation.Converters.ConstantConverterTime timeToGainExperience(value(displayUnit = "yr") = 31536000) "Average time to become experienced staff member" annotation(Placement(visible = true, transformation(origin = {-70, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BusinessSimulation.Converters.ConstantConverterRate turnover(timeBaseString = "year", value(displayUnit = "percent") = 0, redeclare replaceable type ValueType = BusinessSimulation.Units.Amount) annotation(Placement(visible = true, transformation(origin = {110, -40}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
equation
  connect(hiring.massPort, newStaff.inflow) annotation(Line(visible = true, origin = {-60, -10}, points = {{-10, 0}, {10, 0}}, color = {128, 0, 128}));
  connect(newStaff.outflow, advancing.portA) annotation(Line(visible = true, origin = {-20, -10}, points = {{-10, 0}, {10, 0}}, color = {255, 0, 0}));
  connect(advancing.portB, experiencedStaff.inflow) annotation(Line(visible = true, origin = {20, -10}, points = {{-10, 0}, {10, 0}}, color = {128, 0, 128}));
  connect(experiencedStaff.outflow, leaving.massPort) annotation(Line(visible = true, origin = {60, -10}, points = {{-10, 0}, {10, 0}}, color = {128, 0, 128}));
  connect(timeToGainExperience.y, newStaff.u) annotation(Line(visible = true, origin = {-51.333, 20}, points = {{-12.667, 10}, {6.333, 10}, {6.333, -20}}, color = {1, 37, 163}, smooth = Smooth.Bezier));
  connect(leaving.u, turnover.y) annotation(Line(visible = true, origin = {91.333, -33.333}, points = {{-6.333, 13.333}, {-6.333, -6.667}, {12.667, -6.667}}, color = {0, 0, 128}, smooth = Smooth.Bezier));
  annotation(Documentation(info = "<html>
<p class=\"aside\">This information is part of the ISDC2022 Workshops package.</p>
<p></p>
</html>"));
end Staff;
