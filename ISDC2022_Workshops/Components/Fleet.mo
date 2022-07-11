within ISDC2022_Workshops.Components;

model Fleet "People express fleet"
  extends ISDC2022_Workshops.Interfaces.Fleet;
  BusinessSimulation.Stocks.MaterialStock aircraft(initialValue = 3) "Aircraft of norm size in the fleet" annotation(Placement(visible = true, transformation(origin = {0, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BusinessSimulation.SourcesOrSinks.ExponentialGrowth growing annotation(Placement(visible = true, transformation(origin = {-40, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter BusinessSimulation.Units.Rate growthTarget(displayUnit = "1/yr") = 3.17097919837646e-09 "Growth rate envisoned by Don Burr";
  BusinessSimulation.Converters.ConstantConverter targetGrowth(redeclare replaceable type OutputType = BusinessSimulation.Units.Rate, value = growthTarget) "Envisioned growth" annotation(Placement(visible = true, transformation(origin = {-130, -0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BusinessSimulation.Converters.ConstantConverter operationalCapacity(value = 360000, redeclare replaceable type OutputType = BusinessSimulation.Types.Reals(unit = "ASM/plane/day")) "Available seat miles per plane per day" annotation(Placement(visible = true, transformation(origin = {120, 40}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  BusinessSimulation.Converters.Product_3 ASM "Available seat miles" annotation(Placement(visible = true, transformation(origin = {75, 20}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  BusinessSimulation.Converters.Min RPM "Revenue passenger miles" annotation(Placement(visible = true, transformation(origin = {30, 40}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  BusinessSimulation.Converters.Division loadFactor "Ratio of RPM to ASM" annotation(Placement(visible = true, transformation(origin = {-10, 30}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  BusinessSimulation.Converters.ConstantConverterRate opDaysPerYear(redeclare replaceable type ValueType = BusinessSimulation.Units.Time_days, value = 31104000, timeBaseString = "year") "Operational days per year" annotation(Placement(visible = true, transformation(origin = {125, 15}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
equation
  connect(growing.massPort, aircraft.inflow) annotation(Line(visible = true, origin = {-20, -30}, points = {{-10, 0}, {10, 0}}, color = {128, 0, 128}));
  connect(aircraft.y1, ASM.u3) annotation(Line(visible = true, origin = {75.029, -15}, points = {{-64.529, -20}, {23.356, -20}, {23.356, 30}, {7.971, 30}}, color = {1, 37, 163}, smooth = Smooth.Bezier));
  connect(operationalCapacity.y, ASM.u1) annotation(Line(visible = true, origin = {101.75, 32.5}, points = {{12.25, 7.5}, {3.25, 7.5}, {3.25, -7.5}, {-18.75, -7.5}}, color = {1, 37, 163}, smooth = Smooth.Bezier));
  connect(RPM.u2, ASM.y) annotation(Line(visible = true, origin = {48.75, 27.5}, points = {{-10.75, 7.5}, {-3.75, 7.5}, {-3.75, -7.5}, {18.25, -7.5}}, color = {0, 0, 128}, smooth = Smooth.Bezier));
  connect(RPM.y, loadFactor.u1) annotation(Line(visible = true, origin = {12.5, 37.5}, points = {{9.5, 2.5}, {2.5, 2.5}, {2.5, -2.5}, {-14.5, -2.5}}, color = {1, 37, 163}, smooth = Smooth.Bezier));
  connect(ASM.y, loadFactor.u2) annotation(Line(visible = true, origin = {45.801, 22.5}, points = {{21.199, -2.5}, {-25.801, -2.5}, {-25.801, 2.5}, {-47.801, 2.5}}, color = {1, 37, 163}, smooth = Smooth.Bezier));
  connect(opDaysPerYear.y, ASM.u2) annotation(Line(visible = true, origin = {104.699, 17.5}, points = {{14.301, -2.5}, {0.301, -2.5}, {0.301, 2.5}, {-21.699, 2.5}}, color = {1, 37, 163}, smooth = Smooth.Bezier));
  connect(io.potentialPassengerMiles, RPM.u1) "input potentialPassengerMiles (Rate)" annotation(Line(visible = true, origin = {32, 71}, points = {{-32, 34}, {-32, 9}, {28, 9}, {28, -26}, {6, -26}}, color = {0, 0, 128}, smooth = Smooth.Bezier));
  annotation(Diagram(coordinateSystem(extent = {{-148.5, -105}, {148.5, 105}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5}), graphics = {Text(visible = true, origin = {-55, 98.848}, textColor = {0, 0, 128}, extent = {{-34.511, -3.848}, {34.511, 3.848}}, textString = "potentialPassengerMiles", fontSize = 12, fontName = "Lato", horizontalAlignment = TextAlignment.Right)}));
end Fleet;
