within ISDC2022_Workshops.Examples;

model TeaCupTextual "Textual model for cooling cup"
  import BusinessSimulation.Units.{Time,Rate};
  extends BusinessSimulation.Icons.Example;
  // parameters
  parameter Real initTempCup(unit = "degC") = 90 "Initial temperature in the cup";
  parameter Real tempRoom(unit = "degC") = 20 "Temperature in the room";
  parameter Time adjTime(displayUnit = "min") = 600 "Time constant for adjustment process";
  // stock & flow variables
  Real tempCup(start = initTempCup, unit = "degC") "Temperature in the cup is modeled as a stock";
  Rate heatFlow(displayUnit = "1/min") "Outflow of heat from the cup";
equation
  heatFlow = (tempRoom - tempCup) / adjTime;
  der(tempCup) = heatFlow;
  annotation(Documentation(info = "<html>
<p class=\"aside\">This information is part of the ISDC2022 Workshops package.</p>
<p>
This is a stylized model of heat loss for a cup of tea. The model given here is textual only, e.g., there are no components with connections.
</p>
<p>
The temperature in the cup is modeled as a stock (<code>tempCup</code>) with a flow (<code>heatFlow</code>). The outflow of heat, i.e., a negative flow of heat, can be obtained as <code>(tempRoom - tempCup)/adjTime</code>.
</p>
</html>", figures = {Figure(title = "Temperature", identifier = "temp", preferred = true, plots = {Plot(curves = {Curve(y = tempCup)}, __Wolfram_markerAppearances = {MarkerAppearance(marker = "d3d94"), MarkerAppearance(marker = "e4da3")})}, caption = "Tea cup cooling down to room temperature", __Wolfram_markers = {Marker(identifier = "e4da3", position = MarkerPosition(x = 300, xUnit = "s")), Marker(identifier = "d3d94", position = MarkerPosition(x = 600, xUnit = "s"))}, __Wolfram_intervals = {Interval(identifier = "556e0", startMarker = "e4da3", endMarker = "d3d94")})}), experiment(StopTime = 3600, __Wolfram_DisplayTimeUnit = "min"), Diagram(coordinateSystem(extent = {{-148.5, -105}, {148.5, 105}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5}), graphics = {Text(visible = true, origin = {3.28, 10}, rotation = 33.802, textColor = {76, 112, 136}, extent = {{-86.72, -12}, {86.72, 12}}, textString = "textual model only", fontName = "Lato Black")}));
end TeaCupTextual;
