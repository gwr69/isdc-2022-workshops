within ISDC2022_Workshops.Components;

model Fleet "People express fleet"
  extends ISDC2022_Workshops.Interfaces.Fleet;
  BusinessSimulation.Stocks.MaterialStock aircraft(initialValue = 3) "Aircraft of norm size in the fleet" annotation(Placement(visible = true, transformation(origin = {0, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BusinessSimulation.SourcesOrSinks.ExponentialGrowth growing annotation(Placement(visible = true, transformation(origin = {-40, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter BusinessSimulation.Units.Rate growthTarget(displayUnit = "1/yr") = 3.17097919837646e-09 "Growth rate envisoned by Don Burr";
  BusinessSimulation.Converters.ConstantConverter targetGrowth(redeclare replaceable type OutputType = BusinessSimulation.Units.Rate, value = growthTarget) "Envisioned growth" annotation(Placement(visible = true, transformation(origin = {-80, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BusinessSimulation.Converters.ConstantConverter ASM_per_plane(value = 360000) "Available seat miles per plane per day" annotation(Placement(visible = true, transformation(origin = {80, 40}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  BusinessSimulation.Converters.ConstantConverter opDaysPerYear(value = 360000) "Available seat miles per plane per day" annotation(Placement(visible = true, transformation(origin = {80, 20}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  BusinessSimulation.Converters.Product_3 ASM "Available seat miles" annotation(Placement(visible = true, transformation(origin = {35, 20}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  BusinessSimulation.Converters.Min RPM "Revenue passenger miles" annotation(Placement(visible = true, transformation(origin = {0, 40}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
equation
  connect(growing.massPort, aircraft.inflow) annotation(Line(visible = true, origin = {-20, -30}, points = {{-10, 0}, {10, 0}}, color = {128, 0, 128}));
  connect(targetGrowth.y, growing.u) annotation(Line(visible = true, origin = {-54.667, -6.667}, points = {{-19.333, 6.667}, {9.667, 6.667}, {9.667, -13.333}}, color = {1, 37, 163}, smooth = Smooth.Bezier));
  connect(aircraft.y1, ASM.u3) annotation(Line(visible = true, origin = {35.029, -15}, points = {{-24.529, -20}, {23.356, -20}, {23.356, 30}, {7.971, 30}}, color = {1, 37, 163}, smooth = Smooth.Bezier));
  connect(opDaysPerYear.y, ASM.u2) annotation(Line(visible = true, origin = {58.5, 20}, points = {{15.5, 0}, {-15.5, 0}}, color = {1, 37, 163}));
  connect(ASM_per_plane.y, ASM.u1) annotation(Line(visible = true, origin = {61.75, 32.5}, points = {{12.25, 7.5}, {3.25, 7.5}, {3.25, -7.5}, {-18.75, -7.5}}, color = {1, 37, 163}, smooth = Smooth.Bezier));
  connect(RPM.u2, ASM.y) annotation(Line(visible = true, origin = {16.25, 27.5}, points = {{-8.25, 7.5}, {-1.25, 7.5}, {-1.25, -7.5}, {10.75, -7.5}}, color = {0, 0, 128}, smooth = Smooth.Bezier));
end Fleet;
