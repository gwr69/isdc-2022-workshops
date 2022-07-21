within ISDC2022_Workshops.Examples;

model TeaCupPhysical1 "Physical version of the tea cup model (conductive heat transfer only)"
  import Modelica.SIunits.{Mass,SpecificHeatCapacity,Length,ThermalConductivity,ThermalConductance};
  import Modelica.Constants.pi;
  extends BusinessSimulation.Icons.Example;
  // parameters
  parameter Mass m(displayUnit = "g") = 0.25 "Mass of tea in the cup" annotation(Dialog(group = "Specification for hot liquid in the cup"));
  parameter SpecificHeatCapacity c_p = 4181 "Specific heat capacity for liquid water/tea" annotation(Dialog(group = "Specification for hot liquid in the cup"));
  parameter Length d(displayUnit = "cm") = 0.07 "Outer diameter of cup" annotation(Dialog(group = "Specification of cup"));
  parameter Length h(displayUnit = "cm") = 0.09 "Height of cup" annotation(Dialog(group = "Specification of cup"));
  parameter Length t(displayUnit = "mm") = 0.003 "Thickness of cup" annotation(Dialog(group = "Specification of cup"));
  parameter ThermalConductivity k = 1.5 "Thermal conductivity of cup material (e.g., porcelain = 1.5 [W/m.k])" annotation(Dialog(group = "Specification of cup"));
  // components
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor teaCup(T.start = 363.15, C = m * c_p, der_T.start = 0) "Tea cup model" annotation(Placement(visible = true, transformation(origin = {-40, 20}, extent = {{-10, -10}, {10, 10}}, rotation = -360)));
  Modelica.Thermal.HeatTransfer.Celsius.FixedTemperature tempRoom(T = 20) "Room temperature" annotation(Placement(visible = true, transformation(origin = {50, -30}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Celsius.TemperatureSensor tempCup "Temperature of tea in the cup" annotation(Placement(visible = true, transformation(origin = {27.866, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor conduction(G = G_cup) "Conductive heatflow according to the surface, thickness, and conductivity of the cup" annotation(Placement(visible = true, transformation(origin = {0, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
protected
  parameter ThermalConductance G_cup = 2 * pi * k * h / log(d / (d - 2 * t)) "Thermal conductance of cup" annotation(Dialog(group = "Specification of cup", enable = false));
equation
  connect(teaCup.port, tempCup.port) annotation(Line(visible = true, origin = {-24.583, 14.386}, points = {{-15.417, -4.386}, {-15.417, -14.386}, {24.583, -14.386}, {24.583, 15.614}, {42.449, 15.614}}, color = {191, 0, 0}));
  connect(teaCup.port, conduction.port_a) annotation(Line(visible = true, origin = {-30, -16.667}, points = {{-10, 26.667}, {-10, -13.333}, {20, -13.333}}, color = {191, 0, 0}));
  connect(conduction.port_b, tempRoom.port) annotation(Line(visible = true, origin = {25, -30}, points = {{-15, 0}, {15, 0}}, color = {191, 0, 0}));
  annotation(experiment(StopTime = 3600, __Wolfram_DisplayTimeUnit = "min"), Documentation(info = "<html>
<p class=\"aside\">This information is part of the ISDC2022 Workshops package.</p>
<p>
In this component-based version of the <code>TeaCup</code> model we are using components from the <code>Thermal</code> package of the Modelica Standard Library (MSL) to come up with a rather simplified model of a <em>heat capacitator</em>, i.e., the tea in the cup, which is losing heat via <em>conduction</em> to the air in the room. The rate of the heat flow is implicitly determined by the <em>thermal conductance</em> of the cup, which is calculated from elementary properties of the cup. In a physical model we typically need <em>sensors</em> to report quantities and in this model we are using a thermometer to report the <em>intensive quantity</em> <code>tempCup</code>.
</p>
<h4>See also</h4>
<p>
<a href=\"modelica://ISDC2022_Workshops.Examples.TeaCupTextual\">TeaCupTextual</a>,
<a href=\"modelica://ISDC2022_Workshops.Examples.TeaCupComponentBased5\">TeaCupComponentBased5</a>
</p>
</html>", figures = {Figure(title = "Temperature", identifier = "temp", preferred = true, plots = {Plot(curves = {Curve(y = tempCup.T)})}, caption = "The temperature in the cup.")}), Diagram(coordinateSystem(extent = {{-148.5, -105}, {148.5, 105}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5})));
end TeaCupPhysical1;
