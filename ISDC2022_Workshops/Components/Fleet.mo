within ISDC2022_Workshops.Components;

model Fleet "People express fleet"
  extends Interfaces.Fleet;
  parameter BusinessSimulation.Units.Rate growthTarget(displayUnit = "1/yr") = 3.17097919837646e-09 "Growth rate envisoned by Don Burr";
  parameter BusinessSimulation.Units.TangibleAssets initAC = 3 "Initial number of aircraft";
protected
  BusinessSimulation.Stocks.MaterialStock aircraft(initialValue = initAC) "Aircraft of norm size in the fleet" annotation(Placement(visible = true, transformation(origin = {0, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BusinessSimulation.SourcesOrSinks.ExponentialChange growing annotation(Placement(visible = true, transformation(origin = {-40, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BusinessSimulation.Converters.ConstantConverter targetGrowth(redeclare replaceable type OutputType = BusinessSimulation.Units.Rate, value = growthTarget) "Envisioned growth" annotation(Placement(visible = true, transformation(origin = {-120, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BusinessSimulation.Converters.Product_3 availableSeatMiles(redeclare replaceable type OutputType = BusinessSimulation.Units.AmountRate) "Available seat miles" annotation(Placement(visible = true, transformation(origin = {75, 20}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  BusinessSimulation.Converters.Min revenuePassengerMiles "Revenue passenger miles (RPM)" annotation(Placement(visible = true, transformation(origin = {30, 40}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  BusinessSimulation.Converters.Division_Guarded loadFactor(redeclare replaceable type OutputType = BusinessSimulation.Units.Fraction) "Utilization of seat capacity" annotation(Placement(visible = true, transformation(origin = {-10, 30}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  BusinessSimulation.Converters.ConstantConverterRate opDaysPerYear(redeclare replaceable type ValueType = BusinessSimulation.Units.Time_days, value = 31104000, timeBaseString = "year") "Operational days per year" annotation(Placement(visible = true, transformation(origin = {125, 15}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  BusinessSimulation.Converters.ConstantConverterRate dailyCapacityPerPlane(value(displayUnit = "thousand") = 360000, timeBaseString = "day", redeclare replaceable type ValueType = BusinessSimulation.Units.Amount) "Operational days per ye" annotation(Placement(visible = true, transformation(origin = {115, 48.013}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  BusinessSimulation.Converters.DiscreteDelay.Smooth perceivedLoadFactor(delayTime(displayUnit = "mo") = 7884000, init = BusinessSimulation.Types.InitializationOptions.SteadyState) annotation(Placement(visible = true, transformation(origin = {-40, 30}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  BusinessSimulation.Converters.Lookup.ConcaveLookupPositive adjFactor(y0 = 0, s = 0.2) "Adjustment factor for growth rate" annotation(Placement(visible = true, transformation(origin = {-80, 30}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  BusinessSimulation.Converters.Product_2 fracGrowthRate "Fractional growth rate fleet" annotation(Placement(visible = true, transformation(origin = {-80, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  // illustration
  BusinessSimulation.CausalLoop.InfoFlowIndicator lab2 annotation(Placement(visible = true, transformation(origin = {-32.37, 62.633}, extent = {{-10, -10}, {10, 10}}, rotation = -360)));
  BusinessSimulation.CausalLoop.InfoFlowIndicator lab3 annotation(Placement(visible = true, transformation(origin = {8.394, 50}, extent = {{-10, -10}, {10, 10}}, rotation = -270)));
  BusinessSimulation.CausalLoop.InfoFlowIndicator lab4 annotation(Placement(visible = true, transformation(origin = {27.782, 75}, extent = {{-10, -10}, {10, 10}}, rotation = -720)));
equation
  connect(growing.massPort, aircraft.inflow) annotation(Line(visible = true, origin = {-20, -30}, points = {{-10, 0}, {10, 0}}, color = {128, 0, 128}));
  connect(aircraft.y1, availableSeatMiles.u3) annotation(Line(visible = true, origin = {75.029, -15}, points = {{-64.529, -20}, {23.356, -20}, {23.356, 30}, {7.971, 30}}, color = {1, 37, 163}, smooth = Smooth.Bezier));
  connect(revenuePassengerMiles.u2, availableSeatMiles.y) annotation(Line(visible = true, origin = {49.127, 27.5}, points = {{-11.127, 7.5}, {2.384, 7.5}, {2.384, -7.5}, {17.873, -7.5}}, color = {0, 0, 128}, smooth = Smooth.Bezier));
  connect(revenuePassengerMiles.y, loadFactor.u1) annotation(Line(visible = true, origin = {12.5, 37.5}, points = {{9.5, 2.5}, {2.5, 2.5}, {2.5, -2.5}, {-14.5, -2.5}}, color = {1, 37, 163}, smooth = Smooth.Bezier));
  connect(availableSeatMiles.y, loadFactor.u2) annotation(Line(visible = true, origin = {45.801, 22.5}, points = {{21.199, -2.5}, {-25.801, -2.5}, {-25.801, 2.5}, {-47.801, 2.5}}, color = {1, 37, 163}, smooth = Smooth.Bezier));
  connect(opDaysPerYear.y, availableSeatMiles.u2) annotation(Line(visible = true, origin = {104.699, 17.5}, points = {{14.301, -2.5}, {0.301, -2.5}, {0.301, 2.5}, {-21.699, 2.5}}, color = {1, 37, 163}, smooth = Smooth.Bezier));
  connect(io.potentialPassengerMiles, revenuePassengerMiles.u1) "input potentialPassengerMiles (Rate)" annotation(Line(visible = true, origin = {32, 71}, points = {{-32, 34}, {-32, 9}, {28, 9}, {28, -26}, {6, -26}}, color = {0, 0, 128}, smooth = Smooth.Bezier));
  connect(dailyCapacityPerPlane.y, availableSeatMiles.u1) annotation(Line(visible = true, origin = {98, 36.507}, points = {{11, 11.506}, {-3, 11.506}, {-3, -11.507}, {-15, -11.507}}, color = {1, 37, 163}, smooth = Smooth.Bezier));
  connect(perceivedLoadFactor.u, loadFactor.y) annotation(Line(visible = true, origin = {-24.319, 30}, points = {{-6.319, 0}, {6.319, 0}}, color = {0, 0, 128}));
  connect(perceivedLoadFactor.y, adjFactor.u) annotation(Line(visible = true, origin = {-65.227, 29.203}, points = {{15.227, 0.797}, {-7.613, 0.797}, {-6.773, 0.797}}, color = {1, 37, 163}));
  connect(targetGrowth.y, fracGrowthRate.u2) annotation(Line(visible = true, origin = {-102.523, -12.5}, points = {{-11.477, -7.5}, {2.523, -7.5}, {2.523, 7.5}, {14.523, 7.5}}, color = {1, 37, 163}, smooth = Smooth.Bezier));
  connect(adjFactor.y, fracGrowthRate.u1) annotation(Line(visible = true, origin = {-94, 17.5}, points = {{6, 12.5}, {-6, 12.5}, {-6, -12.5}, {6, -12.5}}, color = {1, 37, 163}, smooth = Smooth.Bezier));
  connect(fracGrowthRate.y, growing.u) annotation(Line(visible = true, origin = {-54, -6.667}, points = {{-18, 6.667}, {9, 6.667}, {9, -13.333}}, color = {1, 37, 163}, smooth = Smooth.Bezier));
  connect(fracGrowthRate.y, io.growthRate) "output fractional growth rate" annotation(Line(visible = true, origin = {-38.4, 45}, points = {{-33.6, -45}, {-21.6, -45}, {-21.6, 15}, {38.4, 15}, {38.4, 60}}, color = {1, 37, 163}, smooth = Smooth.Bezier));
  connect(aircraft.y, io.aircraft) annotation(Line(visible = true, origin = {2.083, 51.35}, points = {{2.917, -70.95}, {2.917, 12.02}, {-2.083, 12.02}, {-2.083, 53.65}}, color = {1, 37, 163}, smooth = Smooth.Bezier));
  connect(revenuePassengerMiles.y, io.RPM) "output revenue passenger miles (RPM)" annotation(Line(visible = true, origin = {7.333, 61.667}, points = {{14.667, -21.667}, {4.34, -21.667}, {4.34, 10.833}, {-7.333, 10.833}, {-7.333, 43.333}}, color = {1, 37, 163}, smooth = Smooth.Bezier));
  annotation(Documentation(info = "<html>
<p class=\"aside\">This information is part of the ISDC2022 Workshops package.</p>
<p>The fleet of planes will grow (or decline) at a fractional rate that is determined by CEO Burr's vision, which is modulated by the perceived <code>loadFactor</code>.</p>
</html>"), Diagram(coordinateSystem(extent = {{-148.5, -105}, {148.5, 105}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5}), graphics = {Text(visible = true, origin = {-55, 98.848}, textColor = {0, 0, 128}, extent = {{-34.511, -3.848}, {34.511, 3.848}}, textString = "potentialPassengerMiles", fontSize = 12, fontName = "Lato", horizontalAlignment = TextAlignment.Right), Text(visible = true, origin = {54.511, 98.848}, textColor = {0, 0, 128}, extent = {{-34.511, -3.848}, {34.511, 3.848}}, textString = "aircraft", fontSize = 12, fontName = "Lato", horizontalAlignment = TextAlignment.Left), Text(visible = true, origin = {54.511, 93.848}, textColor = {0, 0, 128}, extent = {{-34.511, -3.848}, {34.511, 3.848}}, textString = "growthRate", fontSize = 12, fontName = "Lato", horizontalAlignment = TextAlignment.Left), Text(visible = true, origin = {54.511, 88.848}, textColor = {0, 0, 128}, extent = {{-34.511, -3.848}, {34.511, 3.848}}, textString = "revenuePassengerMiles", fontSize = 12, fontName = "Lato", horizontalAlignment = TextAlignment.Left)}));
end Fleet;
