within ISDC2022_Workshops.Examples;

model TeaCupComponentBased1 "Component-based version of the tea cup model (unidirectional flow)"
  extends BusinessSimulation.Icons.Example;
  inner BusinessSimulation.ModelSettings modelSettings(modelDisplayTimeBase = BusinessSimulation.Types.TimeBases.minutes, modelTimeHorizon(displayUnit = "min") = 3600, dt(displayUnit = "min") = 15) annotation(Placement(visible = true, transformation(origin = {-40, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BusinessSimulation.Stocks.InformationLevel tempCup(redeclare replaceable type OutputType = BusinessSimulation.Types.Reals(unit = "degC"), initialValue = 90) "Temperature of tea in a cup" annotation(Placement(visible = true, transformation(origin = {0, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BusinessSimulation.Flows.Unidirectional.Transition losingHeat "Heat flow from the cup" annotation(Placement(visible = true, transformation(origin = {40, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BusinessSimulation.SourcesOrSinks.Cloud cloud "Unlimited heat capacity of ambient" annotation(Placement(visible = true, transformation(origin = {85, -20}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  BusinessSimulation.Converters.ConstantConverter tempRoom(redeclare replaceable type OutputType = BusinessSimulation.Types.Reals(unit = "degC"), value = 20) "Room temperature" annotation(Placement(visible = true, transformation(origin = {-50, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BusinessSimulation.Converters.Gap tempDifference "Room temperature minus the temperature of the tea" annotation(Placement(visible = true, transformation(origin = {-20, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BusinessSimulation.Converters.Division heatLoss "Rate for the outflow of heat" annotation(Placement(visible = true, transformation(origin = {15, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BusinessSimulation.Converters.ConstantConverterTime adjTime(value(displayUnit = "min") = 1200) "Time constant for the cooling process" annotation(Placement(visible = true, transformation(origin = {-20, 1.717}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(tempCup.outflow, losingHeat.portA) annotation(Line(visible = true, origin = {20, -20}, points = {{-10, 0}, {10, 0}}, color = {128, 0, 128}));
  connect(losingHeat.portB, cloud.massPort) annotation(Line(visible = true, origin = {62.5, -20}, points = {{-12.5, 0}, {12.5, 0}}, color = {128, 0, 128}));
  connect(tempDifference.y, heatLoss.u1) annotation(Line(visible = true, origin = {-3.75, 32.5}, points = {{-8.25, 7.5}, {-1.25, 7.5}, {-1.25, -7.5}, {10.75, -7.5}}, color = {1, 37, 163}, smooth = Smooth.Bezier));
  connect(adjTime.y, heatLoss.u2) annotation(Line(visible = true, origin = {-4.25, 8.358}, points = {{-9.75, -6.642}, {-0.75, -6.642}, {-0.75, 6.642}, {11.25, 6.642}}, color = {1, 37, 163}, smooth = Smooth.Bezier));
  connect(heatLoss.y, losingHeat.u) annotation(Line(visible = true, origin = {31, 10}, points = {{-8, 10}, {4, 10}, {4, -20}}, color = {1, 37, 163}, smooth = Smooth.Bezier));
  connect(tempRoom.y, tempDifference.u2) annotation(Line(visible = true, origin = {-35.5, 27.5}, points = {{-8.5, -7.5}, {0.5, -7.5}, {0.5, 7.5}, {7.5, 7.5}}, color = {1, 37, 163}, smooth = Smooth.Bezier));
  connect(tempCup.y2, tempDifference.u1) annotation(Line(visible = true, origin = {-45.109, 10}, points = {{34.609, -35}, {-24.891, -35}, {-24.891, 35}, {17.109, 35}}, color = {1, 37, 163}, smooth = Smooth.Bezier));
  annotation(Documentation(info = "<html>
<p class=\"aside\">This information is part of the ISDC2022 Workshops package.</p>
<p>
In this component-based version of the <code>TeaCup</code> model we are modeling the outflow from the cup as a unidirectional flow (<code>losingHeat</code>). Since in this case the flow is an explicit <em>outflow</em>, we need to modify the equation for <code>heatFlow</code> in the textual model and determine its <em>postive</em> rate as <code>(tempCup - tempRoom)/adjTime</code>. 
</p>
<h4>See also</h4>
<p>
<a href=\"modelica://ISDC2022_Workshops.Examples.TeaCupTextual\">TeaCupTextual</a>,
<a href=\"modelica://ISDC2022_Workshops.Examples.TeaCupComponentBased1S\">TeaCupComponentBased1S</a>
</p>
</html>", figures = {Figure(title = "Cooling Process", identifier = "cooling", preferred = true, plots = {Plot(curves = {Curve(y = tempCup.y)}, __Wolfram_markerAppearances = {MarkerAppearance(marker = "d3d94"), MarkerAppearance(marker = "e4da3")})}, caption = "Teacup cooling down to room temperature", __Wolfram_markers = {Marker(identifier = "e4da3", position = MarkerPosition(x = 300, xUnit = "s")), Marker(identifier = "d3d94", position = MarkerPosition(x = 600, xUnit = "s"))}, __Wolfram_intervals = {Interval(identifier = "556e0", startMarker = "e4da3", endMarker = "d3d94")})}), experiment(StopTime = 3600, __Wolfram_DisplayTimeUnit = "min"), Diagram(coordinateSystem(extent = {{-148.5, -105}, {148.5, 105}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5}), graphics = {Text(visible = true, origin = {0, 65}, textColor = {76, 112, 136}, extent = {{-140, -6}, {140, 6}}, textString = "... using unidirectional flow", fontName = "Lato Black", textStyle = {TextStyle.Bold})}));
end TeaCupComponentBased1;
