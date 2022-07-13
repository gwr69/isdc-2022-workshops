within ISDC2022_Workshops.Components;

model ServiceQuality "Measuring service reputation onto the unit interval"
  extends BusinessSimulation.Interfaces.PartialConverters.InformationProcessing_SO;
  BusinessSimulation.Interfaces.Connectors.RealInput serviceStaff "Effective number of service staff" annotation(Placement(visible = true, transformation(origin = {-145, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BusinessSimulation.Interfaces.Connectors.RealInput SP "Service productivity" annotation(Placement(visible = true, transformation(origin = {-145, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BusinessSimulation.Interfaces.Connectors.RealInput RPM "Revenue passenger miles per period" annotation(Placement(visible = true, transformation(origin = {-145, -5}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BusinessSimulation.Converters.Product_2 serviceCapacity(redeclare replaceable type OutputType = BusinessSimulation.Units.Rate) "Revenue passenger miles per year that can be served without stretch" annotation(Placement(visible = true, transformation(origin = {-80, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BusinessSimulation.Converters.Division_Guarded serviceRatio(outputIfZero = 1) "Ratio of RPM that can be serviced comfortably to actual RPM" annotation(Placement(visible = true, transformation(origin = {-25, -0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BusinessSimulation.Converters.Clip serviceQuality(minValue = 0, maxValue = 1) "Service quality measured on the unit inveral, i.e., a value of 1 is best" annotation(Placement(visible = true, transformation(origin = {10, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(SP, serviceCapacity.u2) annotation(Line(visible = true, origin = {-118.25, -12.5}, points = {{-26.75, -47.5}, {-1.75, -47.5}, {-1.75, 47.5}, {30.25, 47.5}}, color = {0, 0, 128}, smooth = Smooth.Bezier));
  connect(serviceStaff, serviceCapacity.u1) annotation(Line(visible = true, origin = {-118.25, 52.5}, points = {{-26.75, 7.5}, {-1.75, 7.5}, {-1.75, -7.5}, {30.25, -7.5}}, color = {0, 0, 128}, smooth = Smooth.Bezier));
  connect(RPM, serviceRatio.u2) annotation(Line(visible = true, origin = {-68.25, -2.5}, points = {{-76.75, -2.5}, {13.25, -2.5}, {13.25, -2.5}, {35.25, -2.5}}, color = {0, 0, 128}));
  connect(serviceCapacity.y, serviceRatio.u1) annotation(Line(visible = true, origin = {-54.454, 22.5}, points = {{-17.546, 17.5}, {4.454, 17.5}, {4.454, -17.5}, {21.454, -17.5}}, color = {1, 37, 163}, smooth = Smooth.Bezier));
  connect(serviceRatio.y, serviceQuality.u) annotation(Line(visible = true, origin = {-7.5, -0}, points = {{-9.5, -0}, {9.5, 0}}, color = {1, 37, 163}));
  connect(serviceQuality.y, y) annotation(Line(visible = true, origin = {89, 0}, points = {{-71, 0}, {71, 0}}, color = {1, 37, 163}));
  annotation(Documentation(info = "<html>
<p class=\"aside\">This information is part of the ISDC2022 Workshops package.</p>
<p>Given a comfortable capacity of revenue passenger miles that can be serviced by the available staff, the ratio of the service capacity to the actual revenue passenger miles is clipped to the unit interval, so that a value of one indicates optimal quality, while zero means no service capability whatsoever.</p>
</html>"), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10, 10}), graphics = {Text(visible = true, textColor = {0, 0, 128}, extent = {{-96.456, -12}, {96.456, 12}}, textString = "QUALITY", fontName = "Lato Black", textStyle = {TextStyle.Bold})}));
end ServiceQuality;
