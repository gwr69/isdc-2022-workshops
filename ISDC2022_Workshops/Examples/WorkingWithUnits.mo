within ISDC2022_Workshops.Examples;

model WorkingWithUnits "Best practices to work with units in Modelica models"
  extends BusinessSimulation.Icons.Example;
  inner BusinessSimulation.ModelSettings modelSettings(modelDisplayTimeBase = BusinessSimulation.Types.TimeBases.years, modelTimeHorizon(displayUnit = "yr") = 315360000, dt(displayUnit = "yr") = 7884000) annotation(Placement(visible = true, transformation(origin = {-90, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BusinessSimulation.Stocks.MaterialStock aircraft(initialValue = 3) "Aircraft of norm size in the fleet" annotation(Placement(visible = true, transformation(origin = {0, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BusinessSimulation.SourcesOrSinks.ExponentialGrowth growing(hasConstantRate = true, fractionalRate(displayUnit = "1/yr") = 3.17097919837646e-09) annotation(Placement(visible = true, transformation(origin = {-40, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BusinessSimulation.Converters.Product_3 ASM(redeclare replaceable type OutputType = BusinessSimulation.Units.AmountRate) "Available seat miles" annotation(Placement(visible = true, transformation(origin = {75, 20}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  BusinessSimulation.Converters.ConstantConverterRate opDaysPerYear(redeclare replaceable type ValueType = BusinessSimulation.Units.Time_days, value = 31104000, timeBaseString = "year") "Operational days per year" annotation(Placement(visible = true, transformation(origin = {120, 20}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  BusinessSimulation.Converters.ConstantConverterRate carrierCapacity(value = 360e3, timeBaseString = "day", redeclare replaceable type ValueType = BusinessSimulation.Types.Reals(unit = "ASM")) "ASM per plane per day" annotation(Placement(visible = true, transformation(origin = {120, 60}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  BusinessSimulation.Converters.ConstantConverter carrierCapacityReal(value = 360e3, redeclare replaceable type OutputType = BusinessSimulation.Types.Reals(unit = "ASM/d")) "Carrier capacity given as Real with explicit units" annotation(Placement(visible = true, transformation(origin = {-90, 85}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BusinessSimulation.Converters.ConstantConverter opDaysPerYearReal(value = 360, redeclare replaceable type OutputType = BusinessSimulation.Types.Reals(unit = "d/yr")) "Operational days per year given as Real with units" annotation(Placement(visible = true, transformation(origin = {-90, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BusinessSimulation.Converters.Product_3 ASMReal(redeclare replaceable type OutputType = BusinessSimulation.Units.AmountRate) "Available seat miles" annotation(Placement(visible = true, transformation(origin = {-40, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(growing.massPort, aircraft.inflow) annotation(Line(visible = true, origin = {-20, -30}, points = {{-10, 0}, {10, 0}}, color = {128, 0, 128}));
  connect(aircraft.y1, ASM.u3) annotation(Line(visible = true, origin = {71.321, -10}, points = {{-60.821, -25}, {28.679, -25}, {28.679, 25}, {11.679, 25}}, color = {1, 37, 163}, smooth = Smooth.Bezier));
  connect(opDaysPerYear.y, ASM.u2) annotation(Line(visible = true, origin = {98.5, 20}, points = {{15.5, 0}, {-15.5, 0}}, color = {1, 37, 163}));
  connect(carrierCapacity.y, ASM.u1) annotation(Line(visible = true, origin = {100.252, 42.5}, points = {{13.748, 17.5}, {-0.252, 17.5}, {-0.252, -17.5}, {-17.252, -17.5}}, color = {1, 37, 163}, smooth = Smooth.Bezier));
  connect(aircraft.y, ASMReal.u3) annotation(Line(visible = true, origin = {-35.6, 25.721}, points = {{40.6, -45.321}, {40.6, -29.605}, {50.6, -29.605}, {50.6, 2.495}, {-34.4, 2.495}, {-34.4, 29.279}, {-12.4, 29.279}}, color = {1, 37, 163}, smooth = Smooth.Bezier));
  connect(opDaysPerYearReal.y, ASMReal.u2) annotation(Line(visible = true, origin = {-66, 60}, points = {{-18, 0}, {18, -0}}, color = {1, 37, 163}));
  connect(carrierCapacityReal.y, ASMReal.u1) annotation(Line(visible = true, origin = {-69.878, 75}, points = {{-14.122, 10}, {-0.122, 10}, {-0.122, -10}, {21.878, -10}}, color = {1, 37, 163}, smooth = Smooth.Bezier));
  annotation(Documentation(info = "<html>
<p class=\"aside\">This information is part of the ISDC2022 Workshops package.</p>
<p>
This example is taken from the <code>Fleet</code> component in the People Express model and nicely shows some intricacies with regard to working with <em>units</em> in Modelica models.
</p>
<p>
When we start out to build a model, we can never quite be sure how a variable will eventually be used. While we may work with the following declaration for the variable <code>opDaysPerYear</code> doing so is not robust:
</p>
<pre>
Real opDaysPerYear(unit = \"days/year\")
</pre>
<p>
First of all, this is a ratio and it behaves like a <em>rate</em>. Should we use the value later to come up with a rate to be used to set the rate of a <em>flow</em> we may run into difficulties.
</p>
<p>
Modelica allows us to work with different choices for <code>displayUnit</code> doing automatic conversions, while working internally with a consistent <em>canonical</em> unit. For rates the internal unit should always be <code>[1/s]</code> which allows us to enter rates in any derived unit there is, e.g., as <code>[1/mo]</code>.
</p>
<p>
The ratio <code>opDaysPerYear</code> has a further complication: Dimensionality analysis should quickly convince us that dividing a unit of <em>time</em> by a different unit of <em>time</em> must necessarily result in a <em>dimensionless</em> scalar. Modelica's unit framework will do this for us only, if we explicitly tell it that the nominator has <code>quantity = \"Time\"</code>.
</p>
<html>"), Diagram(coordinateSystem(extent = {{-148.5, -105}, {148.5, 105}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5}), graphics = {Text(visible = true, origin = {55, 64}, textColor = {255, 0, 0}, extent = {{-18.018, -6}, {18.018, 6}}, textString = "Rates", fontName = "Lato"), Line(visible = true, origin = {85.708, 59.92}, points = {{-12.591, 2.275}, {12.591, -2.275}}, color = {255, 0, 0}, arrow = {Arrow.None, Arrow.Filled}), Line(visible = true, origin = {63.974, 42.475}, points = {{-6.026, 14.259}, {6.026, -14.259}}, color = {255, 0, 0}, arrow = {Arrow.None, Arrow.Filled}), Line(visible = true, origin = {88.135, 43.974}, points = {{-20.176, 13.974}, {20.176, -13.974}}, color = {255, 0, 0}, arrow = {Arrow.None, Arrow.Filled}), Text(visible = true, origin = {-71.323, 20}, textColor = {255, 0, 0}, extent = {{-68.677, -6}, {68.677, 6}}, textString = "Work with displayUnit", fontName = "Lato", horizontalAlignment = TextAlignment.Left), Text(visible = true, origin = {-33.266, 6}, textColor = {255, 0, 0}, extent = {{-106.734, -6}, {106.734, 6}}, textString = "and keep rates internally consistant at [1/s]", fontName = "Lato", horizontalAlignment = TextAlignment.Left), Text(visible = true, origin = {30, -66}, textColor = {255, 0, 0}, extent = {{-110, -6}, {110, 6}}, textString = "Time per Time should give a dimensionless scalar", fontName = "Lato", horizontalAlignment = TextAlignment.Right), Line(visible = true, origin = {120, -25}, points = {{-0, -35}, {0, 35}}, color = {255, 0, 0}, arrow = {Arrow.None, Arrow.Filled}), Polygon(visible = true, origin = {-1.709, 76.877}, rotation = -12.49, lineColor = {255, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, points = {{-8.001, 3.447}, {-20.034, -19.627}, {-9.533, -15.693}, {-14.718, -30.789}, {-0.975, -11.981}, {-12.073, -13.579}, {-4.041, 3.027}})}), experiment(StopTime = 315360000, __Wolfram_DisplayTimeUnit = "yr"));
end WorkingWithUnits;
