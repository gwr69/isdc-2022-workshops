within ISDC2022_Workshops.Examples;

model TeaCupComponentBased5 "Component-based version of the tea cup model (convective and conductive heat transfer)"
  import Modelica.SIunits.{Mass,SpecificHeatCapacity,Length,ThermalConductivity,ThermalConductance,CoefficientOfHeatTransfer};
  import Modelica.Constants.pi;
  extends BusinessSimulation.Icons.Example;
  // parameters
  parameter Mass m(displayUnit = "g") = 0.25 "Mass of tea in the cup" annotation(Dialog(group = "Specification for hot liquid in the cup"));
  parameter SpecificHeatCapacity c_p = 4181 "Specific heat capacity for liquid water/tea" annotation(Dialog(group = "Specification for hot liquid in the cup"));
  parameter Length d(displayUnit = "cm") = 0.07 "Outer diameter of cup" annotation(Dialog(group = "Specification of cup"));
  parameter Length h(displayUnit = "cm") = 0.09 "Height of cup" annotation(Dialog(group = "Specification of cup"));
  parameter Length t(displayUnit = "mm") = 0.003 "Thickness of cup" annotation(Dialog(group = "Specification of cup"));
  parameter ThermalConductivity k = 1.5 "Thermal conductivity of cup material (e.g., porcelain = 1.5 [W/m.k])" annotation(Dialog(group = "Specification of cup"));
  parameter CoefficientOfHeatTransfer h_tea = 750 "Convective heat transfer coefficient for tea" annotation(Dialog(group = "Specficiation of convective heat transfer"));
  parameter CoefficientOfHeatTransfer h_air = 10 "Convective heat transfer coefficient for free air, i.e., not forced" annotation(Dialog(group = "Specficiation of convective heat transfer"));
  // components
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor teaCup(T.start = 363.15, C = m * c_p, der_T.start = 0) "Tea cup model" annotation(Placement(visible = true, transformation(origin = {-60, 20}, extent = {{-10, -10}, {10, 10}}, rotation = -360)));
  Modelica.Thermal.HeatTransfer.Celsius.FixedTemperature tempRoom(T = 20) "Room temperature" annotation(Placement(visible = true, transformation(origin = {80, -30}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Celsius.TemperatureSensor tempCup "Temperature of tea in the cup" annotation(Placement(visible = true, transformation(origin = {10, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor conduction_cup(R = 1 / G_cup) "Condictive resistance of cup walls" annotation(Placement(visible = true, transformation(origin = {0, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.ConvectiveResistor convection_tea "Convective resistance of tea" annotation(Placement(visible = true, transformation(origin = {-40, -30}, extent = {{10, 10}, {-10, -10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.ConvectiveResistor convection_air "Convective resistance of air" annotation(Placement(visible = true, transformation(origin = {40, -30}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant Rc_tea(k = 1 / Gc_tea) "Thermal resistance for hot liquid" annotation(Placement(visible = true, transformation(origin = {-70, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant Rc_air(k = 1 / Gc_air) "Thermal resistance for air" annotation(Placement(visible = true, transformation(origin = {10, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
protected
  parameter ThermalConductance G_cup = 2 * pi * k * h / log(d / (d - t)) "Thermal conductance of cup" annotation(Dialog(group = "Specification of cup", enable = false));
  parameter ThermalConductance Gc_tea = 2 * pi * (d - t) * h * h_tea "Convective thermal conductance of tea" annotation(Dialog(enable = false, group = "Specficiation of convective heat transfer"));
  parameter ThermalConductance Gc_air = 2 * pi * d * h * h_air "Convective thermal conductance of air" annotation(Dialog(enable = false, group = "Specficiation of convective heat transfer"));
equation
  connect(teaCup.port, tempCup.port) annotation(Line(visible = true, origin = {-44.583, 14.386}, points = {{-15.417, -4.386}, {-15.417, -14.386}, {24.583, -14.386}, {24.583, 15.614}, {44.583, 15.614}}, color = {191, 0, 0}));
  connect(teaCup.port, convection_tea.fluid) annotation(Line(visible = true, origin = {-56.667, -16.667}, points = {{-3.333, 26.667}, {-3.333, -13.333}, {6.667, -13.333}}, color = {191, 0, 0}));
  connect(convection_tea.solid, conduction_cup.port_a) annotation(Line(visible = true, origin = {-20, -30}, points = {{-10, 0}, {10, 0}}, color = {191, 0, 0}));
  connect(tempRoom.port, convection_air.fluid) annotation(Line(visible = true, origin = {60, -30}, points = {{10, 0}, {-10, 0}}, color = {191, 0, 0}));
  connect(conduction_cup.port_b, convection_air.solid) annotation(Line(visible = true, origin = {20, -30}, points = {{-10, 0}, {10, 0}}, color = {191, 0, 0}));
  connect(Rc_tea.y, convection_tea.Rc) annotation(Line(visible = true, origin = {-46.333, -60}, points = {{-12.667, -10}, {6.333, -10}, {6.333, 20}}, color = {1, 37, 163}));
  connect(Rc_air.y, convection_air.Rc) annotation(Line(visible = true, origin = {33.667, -60}, points = {{-12.667, -10}, {6.333, -10}, {6.333, 20}}, color = {1, 37, 163}));
  annotation(experiment(StopTime = 3600, __Wolfram_DisplayTimeUnit = "min"), Documentation(info = "<html>
<p class=\"aside\">This information is part of the ISDC2022 Workshops package.</p>
<p>
In this component-based version of the <code>TeaCup</code> model we are using components from the <code>Thermal</code> package of the Modelica Standard Library (MSL) to come up with a more elaborate model of a <em>heat capacitator</em>, i.e., the tea in the cup, which is losing heat via <em>convective and conductive</em> heat transfer to the air in the room.
</p>
<h4>See also</h4>
<p>
<a href=\"modelica://ISDC2022_Workshops.Examples.TeaCupTextual\">TeaCupTextual</a>,
<a href=\"modelica://ISDC2022_Workshops.Examples.TeaCupComponentBased4\">TeaCupComponentBased4</a>
</p>
</html>"), Diagram(coordinateSystem(extent = {{-148.5, -105}, {148.5, 105}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5}), graphics = {Text(visible = true, origin = {0, 65}, textColor = {76, 112, 136}, extent = {{-140, -6}, {140, 6}}, textString = "... using more physical components (MSL)", fontName = "Lato Black", textStyle = {TextStyle.Bold})}));
end TeaCupComponentBased5;
