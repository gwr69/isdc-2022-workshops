within ISDC2022_Workshops.Examples;

model TeaCupComponentBased3 "Component-based version of the tea cup model (smooth)"
  extends BusinessSimulation.Icons.Example;
  inner BusinessSimulation.ModelSettings modelSettings(modelDisplayTimeBase = BusinessSimulation.Types.TimeBases.minutes, modelTimeHorizon(displayUnit = "min") = 3600, dt(displayUnit = "min") = 15) annotation(Placement(visible = true, transformation(origin = {-40, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BusinessSimulation.Converters.ConstantConverter tempRoom(redeclare replaceable type OutputType = BusinessSimulation.Types.Reals(unit = "degC"), value = 20) "Room temperature" annotation(Placement(visible = true, transformation(origin = {-40, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BusinessSimulation.Converters.ConstantConverterTime adjTime(value(displayUnit = "min") = 1200) "Time constant for the cooling process" annotation(Placement(visible = true, transformation(origin = {-20, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BusinessSimulation.Converters.DiscreteDelay.Smooth tempCup(redeclare replaceable type OutputType = BusinessSimulation.Types.Reals(unit = "degC"), initialValue = 90, hasConstantDelayTime = false) "Temperature of tea in the cup" annotation(Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(adjTime.y, tempCup.u_delayTime) annotation(Line(visible = true, origin = {-4.667, 15}, points = {{-9.333, 5}, {4.667, 5}, {4.667, -10}}, color = {1, 37, 163}, smooth = Smooth.Bezier));
  connect(tempRoom.y, tempCup.u) annotation(Line(visible = true, origin = {-21.681, 0}, points = {{-12.319, 0}, {12.319, 0}}, color = {1, 37, 163}));
  annotation(Documentation(info = "<html>
<p class=\"aside\">This information is part of the ISDC2022 Workshops package.</p>
<p>
In this component-based version of the <code>TeaCup</code> model we are modeling the cooling process rather compactly as a first-order exponential smooth. All we need is the room temperature (<code>tempRoom</code>) and the adjustment time (<code>adjTime</code>).
</p>
<h4>See also</h4>
<p>
<a href=\"modelica://ISDC2022_Workshops.Examples.TeaCupTextual\">TeaCupTextual</a>
</p>
</html>", figures = {Figure(title = "Cooling Process", identifier = "cooling", preferred = true, plots = {Plot(curves = {Curve(y = tempCup.y)}, __Wolfram_markerAppearances = {MarkerAppearance(marker = "d3d94"), MarkerAppearance(marker = "e4da3")})}, caption = "Teacup cooling down to room temperature", __Wolfram_markers = {Marker(identifier = "e4da3", position = MarkerPosition(x = 300, xUnit = "s")), Marker(identifier = "d3d94", position = MarkerPosition(x = 600, xUnit = "s"))}, __Wolfram_intervals = {Interval(identifier = "556e0", startMarker = "e4da3", endMarker = "d3d94")})}), experiment(StopTime = 3600, __Wolfram_DisplayTimeUnit = "min"), Diagram(coordinateSystem(extent = {{-148.5, -105}, {148.5, 105}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5}), graphics = {Text(visible = true, origin = {0, 65}, textColor = {76, 112, 136}, extent = {{-140, -6}, {140, 6}}, textString = "... using smooth", fontName = "Lato Black", textStyle = {TextStyle.Bold})}));
end TeaCupComponentBased3;
