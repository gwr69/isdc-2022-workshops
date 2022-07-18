within ISDC2022_Workshops.Examples;

model TeaCupComponentBased2 "Component-based version of the tea cup model (bidirectional flow)"
  extends BusinessSimulation.Icons.Example;
  inner BusinessSimulation.ModelSettings modelSettings(modelDisplayTimeBase = BusinessSimulation.Types.TimeBases.minutes, modelTimeHorizon(displayUnit = "min") = 3600, dt(displayUnit = "min") = 15) annotation(Placement(visible = true, transformation(origin = {-40, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BusinessSimulation.Stocks.InformationLevel tempCup(redeclare replaceable type OutputType = BusinessSimulation.Types.Reals(unit = "degC"), initialValue = 90) "Temperature of tea in a cup" annotation(Placement(visible = true, transformation(origin = {0, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BusinessSimulation.SourcesOrSinks.Cloud cloud "Unlimited heat capacity of ambient" annotation(Placement(visible = true, transformation(origin = {85, -40}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  BusinessSimulation.Converters.ConstantConverter tempRoom(redeclare replaceable type OutputType = BusinessSimulation.Types.Reals(unit = "degC"), value = 20) "Room temperature" annotation(Placement(visible = true, transformation(origin = {-60, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BusinessSimulation.Converters.Gap tempDifference "Room temperature minus the temperature of the tea" annotation(Placement(visible = true, transformation(origin = {-20, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BusinessSimulation.Converters.Division heatFlow "Heatflow rate" annotation(Placement(visible = true, transformation(origin = {15, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BusinessSimulation.Converters.ConstantConverterTime adjTime(value(displayUnit = "min") = 1200) "Time constant for the cooling process" annotation(Placement(visible = true, transformation(origin = {-20, -18.283}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BusinessSimulation.Flows.Bidirectional.Switching changing "Flow of heat to or from the cup" annotation(Placement(visible = true, transformation(origin = {40, -40}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
equation
  connect(tempDifference.y, heatFlow.u1) annotation(Line(visible = true, origin = {-3.75, 12.5}, points = {{-8.25, 7.5}, {-1.25, 7.5}, {-1.25, -7.5}, {10.75, -7.5}}, color = {1, 37, 163}, smooth = Smooth.Bezier));
  connect(adjTime.y, heatFlow.u2) annotation(Line(visible = true, origin = {-4.25, -11.642}, points = {{-9.75, -6.642}, {-0.75, -6.642}, {-0.75, 6.642}, {11.25, 6.642}}, color = {1, 37, 163}, smooth = Smooth.Bezier));
  connect(tempRoom.y, tempDifference.u1) annotation(Line(visible = true, origin = {-43, 32.5}, points = {{-11, 7.5}, {-2, 7.5}, {-2, -7.5}, {15, -7.5}}, color = {1, 37, 163}, smooth = Smooth.Bezier));
  connect(tempCup.y2, tempDifference.u2) annotation(Line(visible = true, origin = {-39.625, 5}, points = {{29.125, -50}, {-20.375, -50}, {-20.375, 10}, {11.625, 10}}, color = {1, 37, 163}, smooth = Smooth.Bezier));
  connect(heatFlow.y, changing.u) annotation(Line(visible = true, origin = {37.667, -10}, points = {{-14.667, 10}, {7.333, 10}, {7.333, -20}}, color = {1, 37, 163}, smooth = Smooth.Bezier));
  connect(tempCup.outflow, changing.portB) annotation(Line(visible = true, origin = {20, -40}, points = {{-10, 0}, {10, 0}}, color = {128, 0, 128}));
  connect(changing.portA, cloud.massPort) annotation(Line(visible = true, origin = {62.5, -40}, points = {{-12.5, 0}, {12.5, 0}}, color = {128, 0, 128}));
  annotation(Documentation(info = "<html>
<p class=\"aside\">This information is part of the ISDC2022 Workshops package.</p>
<p>
In this component-based version of the <code>TeaCup</code> model we are modeling the outflow from the cup as a biflow (<code>changing</code>) and can thus have all formulae match up with the textual model.
</p>
<h4>See also</h4>
<p>
<a href=\"modelica://ISDC2022_Workshops.Examples.TeaCupTextual\">TeaCupTextual</a>,
<a href=\"modelica://ISDC2022_Workshops.Examples.TeaCupComponentBased2S\">TeaCupComponentBased2S</a>
</p>
</html>", figures = {Figure(title = "Temperature", identifier = "temp", preferred = true, plots = {Plot(curves = {Curve(y = tempCup.y)}, __Wolfram_markerAppearances = {MarkerAppearance(marker = "d3d94"), MarkerAppearance(marker = "e4da3")})}, caption = "Tea cup cooling down to room temperature", __Wolfram_markers = {Marker(identifier = "e4da3", position = MarkerPosition(x = 300, xUnit = "s")), Marker(identifier = "d3d94", position = MarkerPosition(x = 600, xUnit = "s"))}, __Wolfram_intervals = {Interval(identifier = "556e0", startMarker = "e4da3", endMarker = "d3d94")})}), experiment(StopTime = 3600, __Wolfram_DisplayTimeUnit = "min"), Diagram(coordinateSystem(extent = {{-148.5, -105}, {148.5, 105}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5}), graphics = {Text(visible = true, origin = {0, 65}, textColor = {76, 112, 136}, extent = {{-140, -6}, {140, 6}}, textString = "... using biflow", fontName = "Lato Black", textStyle = {TextStyle.Bold})}));
end TeaCupComponentBased2;
