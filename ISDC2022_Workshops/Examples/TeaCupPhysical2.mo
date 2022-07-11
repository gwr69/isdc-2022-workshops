within ISDC2022_Workshops.Examples;

model TeaCupPhysical2 "More elaborate physical version of the tea cup model"
  import Modelica.SIunits.{Mass,SpecificHeatCapacity,Length,ThermalConductivity,ThermalConductance,CoefficientOfHeatTransfer};
  import Modelica.Constants.pi;
  extends BusinessSimulation.Icons.Example;
  // parameters
  parameter Boolean hasInsideConvection = false "= true, if convective heat flow is to be assumed for the liquid in the cup" annotation(Evaluate = true, Dialog(group = "Structural Parameters"));
  parameter Boolean hasTopConvection = false "= true, if convective heat flow is to be assumed for the liquid at the top" annotation(Evaluate = true, Dialog(group = "Structural Parameters"));
  parameter Boolean hasBodyRadiation = true "= true, if body radiation is to be accounted for" annotation(Evaluate = true, Dialog(group = "Structural Parameters"));
  parameter Mass m(displayUnit = "g") = 0.25 "Mass of tea in the cup" annotation(Dialog(group = "Specification for hot liquid in the cup"));
  parameter SpecificHeatCapacity c_p = 4181 "Specific heat capacity for liquid water/tea" annotation(Dialog(group = "Specification for hot liquid in the cup"));
  parameter Length d(displayUnit = "cm") = 0.07 "Outer diameter of cup" annotation(Dialog(group = "Specification of cup"));
  parameter Length h(displayUnit = "cm") = 0.09 "Height of cup" annotation(Dialog(group = "Specification of cup"));
  parameter Length t(displayUnit = "mm") = 0.003 "Thickness of cup" annotation(Dialog(group = "Specification of cup"));
  parameter ThermalConductivity k = 1.5 "Thermal conductivity of cup material (e.g., porcelain = 1.5 [W/m.k])" annotation(Dialog(group = "Specification of cup"));
  parameter CoefficientOfHeatTransfer h_tea = 750 "Convective heat transfer coefficient for tea" annotation(Dialog(group = "Specficiation of convective heat transfer"));
  parameter CoefficientOfHeatTransfer h_air = 10 "Convective heat transfer coefficient for free air, i.e., not forced" annotation(Dialog(group = "Specficiation of convective heat transfer"));
  parameter Real epsilon = 0.9 "Emission value for cup material" annotation(Dialog(group = "Specficiation of body radiation"));
  // components
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor teaCup(T.start = 363.15, C = m * c_p, der_T.start = 0) "Tea cup model" annotation(Placement(visible = true, transformation(origin = {-60, 20}, extent = {{-10, -10}, {10, 10}}, rotation = -360)));
  Modelica.Thermal.HeatTransfer.Celsius.FixedTemperature tempRoom(T = 20) "Room temperature" annotation(Placement(visible = true, transformation(origin = {100, 20}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Celsius.TemperatureSensor tempCup "Temperature of tea in the cup" annotation(Placement(visible = true, transformation(origin = {-100, -10}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor conduction_cup(R = 1 / G_cup) "Condictive resistance of cup walls" annotation(Placement(visible = true, transformation(origin = {10, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.ConvectiveResistor convection_tea if hasInsideConvection "Convective resistance of tea" annotation(Placement(visible = true, transformation(origin = {-30, -30}, extent = {{10, 10}, {-10, -10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.ConvectiveResistor convection_air "Convective resistance of air" annotation(Placement(visible = true, transformation(origin = {50, -30}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant Rc_tea(k = 1 / Gc_tea) if hasInsideConvection "Thermal resistance for hot liquid" annotation(Placement(visible = true, transformation(origin = {-60, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant Rc_air(k = 1 / Gc_air) "Thermal resistance for air" annotation(Placement(visible = true, transformation(origin = {20, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ZeroResistanceConductor zeroResistanceConduction if not hasInsideConvection "Simple connection for heat conduction without resistance" annotation(Placement(visible = true, transformation(origin = {-30, -30}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.ConvectiveResistor convection_air_from_top if hasTopConvection "Convective resistance of air" annotation(Placement(visible = true, transformation(origin = {10, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant Rc_air_top(k = 1 / Gc_air_top) if hasTopConvection "Thermal resistance for air at top" annotation(Placement(visible = true, transformation(origin = {50, 50}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.BodyRadiation bodyRadiation(Gr = Gr) if hasBodyRadiation "Heat loss due to body radiation" annotation(Placement(visible = true, transformation(origin = {10, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
protected
  parameter ThermalConductance G_cup = 2 * pi * k * h / log(d / (d - 2 * t)) "Thermal conductance of cup" annotation(Dialog(group = "Specification of cup", enable = false));
  parameter ThermalConductance Gc_tea = pi * (d - 2 * t) * h * h_tea "Convective thermal conductance of tea" annotation(Dialog(enable = false, group = "Specficiation of convective heat transfer"));
  parameter ThermalConductance Gc_air = pi * d * h * h_air "Convective thermal conductance of air" annotation(Dialog(enable = false, group = "Specficiation of convective heat transfer"));
  parameter ThermalConductance Gc_air_top = pi * d ^ 2 * 0.25 * h_air "Convective thermal conductance at top" annotation(Dialog(enable = false, group = "Specficiation of convective heat transfer"));
  parameter ThermalConductance Gr = epsilon * pi * (d / 2) ^ 2 "Thermal conductance for body radiation" annotation(Dialog(enable = false, group = "Specficiation of body radiation"));

  model ZeroResistanceConductor "Dummy element to establish a switchable connection"
    extends Modelica.Thermal.HeatTransfer.Interfaces.Element1D;
  equation
    dT = 0;
    annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10, 10}), graphics = {Line(visible = true, points = {{-100, 0}, {100, 0}}, color = {255, 0, 0}, thickness = 3)}));
  end ZeroResistanceConductor;
equation
  connect(teaCup.port, convection_tea.fluid) annotation(Line(visible = true, origin = {-53.333, -16.667}, points = {{-6.667, 26.667}, {-6.667, -13.333}, {13.333, -13.333}}, color = {191, 0, 0}));
  connect(convection_tea.solid, conduction_cup.port_a) annotation(Line(visible = true, origin = {-10, -30}, points = {{-10, 0}, {10, 0}}, color = {191, 0, 0}));
  connect(tempRoom.port, convection_air.fluid) annotation(Line(visible = true, origin = {79.526, -5}, points = {{10.474, 25}, {0.474, 25}, {0.474, -25}, {-19.526, -25}}, color = {191, 0, 0}));
  connect(conduction_cup.port_b, convection_air.solid) annotation(Line(visible = true, origin = {30, -30}, points = {{-10, 0}, {10, 0}}, color = {191, 0, 0}));
  connect(Rc_tea.y, convection_tea.Rc) annotation(Line(visible = true, origin = {-36.333, -60}, points = {{-12.667, -10}, {6.333, -10}, {6.333, 20}}, color = {1, 37, 163}));
  connect(Rc_air.y, convection_air.Rc) annotation(Line(visible = true, origin = {43.667, -60}, points = {{-12.667, -10}, {6.333, -10}, {6.333, 20}}, color = {1, 37, 163}));
  connect(teaCup.port, zeroResistanceConduction.port_b) annotation(Line(visible = true, origin = {-53.333, -16.667}, points = {{-6.667, 26.667}, {-6.667, -13.333}, {13.333, -13.333}}, color = {191, 0, 0}));
  connect(zeroResistanceConduction.port_a, conduction_cup.port_a) annotation(Line(visible = true, origin = {-10, -30}, points = {{-10, 0}, {10, 0}}, color = {191, 0, 0}));
  connect(tempCup.port, teaCup.port) annotation(Line(visible = true, origin = {-70, -3.333}, points = {{-20, -6.667}, {10, -6.667}, {10, 13.333}}, color = {191, 0, 0}));
  connect(Rc_air_top.y, convection_air_from_top.Rc) annotation(Line(visible = true, origin = {19.667, 43.333}, points = {{19.333, 6.667}, {-9.667, 6.667}, {-9.667, -13.333}}, color = {1, 37, 163}));
  connect(convection_air_from_top.fluid, tempRoom.port) annotation(Line(visible = true, origin = {55, 20}, points = {{-35, 0}, {35, 0}}, color = {191, 0, 0}));
  connect(teaCup.port, convection_air_from_top.solid) annotation(Line(visible = true, origin = {-37.074, 8}, points = {{-22.926, 2}, {-22.926, -18}, {2.074, -18}, {2.074, 12}, {37.074, 12}}, color = {191, 0, 0}));
  connect(bodyRadiation.port_b, tempRoom.port) annotation(Line(visible = true, origin = {65.852, 50}, points = {{-45.852, 30}, {14.148, 30}, {14.148, -30}, {24.148, -30}}, color = {191, 0, 0}));
  connect(teaCup.port, bodyRadiation.port_a) annotation(Line(visible = true, origin = {-31.667, 39.643}, points = {{-28.333, -29.643}, {-28.333, -49.643}, {-3.333, -49.643}, {-3.333, 40.357}, {31.667, 40.357}}, color = {191, 0, 0}));
  annotation(experiment(StopTime = 3600, __Wolfram_DisplayTimeUnit = "min"), Documentation(info = "<html>
<p class=\"aside\">This information is part of the ISDC2022 Workshops package.</p>
<p>
In this component-based version of the <code>TeaCup</code> model we are using components from the <code>Thermal</code> package of the Modelica Standard Library (MSL) to come up with a more elaborate model of a <em>heat capacitator</em>, i.e., the tea in the cup, which is losing heat via <em>convective and conductive</em> heat transfer to the air in the room.
</p>
<p>
The model uses <em>structural parameters</em> to switch on/off model components, i.e., convective heat flow in the cup, convective heat flow at the top, and body radiation may be accounted for.
</p>
<h4>See also</h4>
<p>
<a href=\"modelica://ISDC2022_Workshops.Examples.TeaCupTextual\">TeaCupTextual</a>,
<a href=\"modelica://ISDC2022_Workshops.Examples.TeaCupComponentBased4\">TeaCupComponentBased4</a>
</p>
</html>"), Diagram(coordinateSystem(extent = {{-148.5, -105}, {148.5, 105}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5})));
end TeaCupPhysical2;
