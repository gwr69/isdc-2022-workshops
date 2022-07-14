within ISDC2022_Workshops.Components;

model Staff "People express staff"
  extends Interfaces.Staff;
  // parameters
  parameter BusinessSimulation.Units.AmountRate SP(displayUnit = "million/yr") = 0.0475646879756469 "Service productivity, i.e., revenuer passenger miles per service staff and year";
  parameter Real MCM(unit = "people") = 60 "Maximum capapcity multiplier, i.e., max staff per plane (hiringPolicy.MCM)";
  parameter BusinessSimulation.Units.Rate RI(displayUnit = "1/yr") = 9.51293759512938e-07 "Recruiting intensity, i.e., job interviews per recruiter per year (hiringPolicy.RI)";
  parameter BusinessSimulation.Units.Amount AR(displayUnit = "percent") = 0.03 "Fraction of applicants accepted (hiringPolicy.AR)";
  parameter Real FHT = 0.1 "Fraction of experienced staff fully envolved in hiring";
  parameter Real TRI = 0.03 "Experienced staff fully envolved in training per recruit";
protected
  BusinessSimulation.Stocks.MaterialStock experiencedStaff(initialValue = 250) "Experienced personnel" annotation(Placement(visible = true, transformation(origin = {40, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BusinessSimulation.Stocks.DelayN newStaff(hasConstantDelayTime = false) "Freshly recruited personnel" annotation(Placement(visible = true, transformation(origin = {-40, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BusinessSimulation.Flows.Unidirectional.OutflowDynamicStock advancing "New staff becoming experienced" annotation(Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BusinessSimulation.SourcesOrSinks.ExponentialDecline leaving "Personnel leaving the company" annotation(Placement(visible = true, transformation(origin = {80, 0}, extent = {{10, 10}, {-10, -10}}, rotation = 0)));
  BusinessSimulation.SourcesOrSinks.Growth hiring "Recruiting new personnel" annotation(Placement(visible = true, transformation(origin = {-80, 0}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  BusinessSimulation.Converters.ConstantConverterTime timeToGainExperience(value(displayUnit = "yr") = 31536000) "Average time to become experienced staff member" annotation(Placement(visible = true, transformation(origin = {-67.206, 35}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BusinessSimulation.Converters.ConstantConverterRate turnover(timeBaseString = "year", value(displayUnit = "percent") = 0, redeclare replaceable type ValueType = BusinessSimulation.Units.Amount) "Fractional rate of staff leaving, which is not an option in \"the firm\" ;-)" annotation(Placement(visible = true, transformation(origin = {110, -30}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  HiringPolicy hiringPolicy(redeclare replaceable type OutputType = BusinessSimulation.Units.Rate, MCM = MCM, RI = RI, AR = AR) "Setting the rate of hiring" annotation(Placement(visible = true, transformation(origin = {-60, -40}, extent = {{10, 10}, {-10, -10}}, rotation = 0)));
  BusinessSimulation.Converters.Vector.Total totalStaff "Sum of new and experienced staff" annotation(Placement(visible = true, transformation(origin = {-26.713, -25}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  BusinessSimulation.Converters.Gain recruiters(c = FHT) "Experienced staff available for hiring" annotation(Placement(visible = true, transformation(origin = {30, -40}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  BusinessSimulation.Converters.Gain hiddenCoaching(c = TRI) "Experienced staff involved in coaching" annotation(Placement(visible = true, transformation(origin = {-7.231, 28.217}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BusinessSimulation.Converters.Vector.Total unavailableStaff "Experienced staff envolved in hiring and training" annotation(Placement(visible = true, transformation(origin = {40, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BusinessSimulation.Converters.Gap effectiveServiceStaff "Experienced staff effictively serving passengers" annotation(Placement(visible = true, transformation(origin = {80, 30}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  BusinessSimulation.Converters.ConstantConverter serviceProductivity(value = SP) "Revenue passenger miles per service staff per year" annotation(Placement(visible = true, transformation(origin = {110, 90}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  ServiceQuality serviceQuality "Service quality" annotation(Placement(visible = true, transformation(origin = {70, 65}, extent = {{10, 10}, {-10, -10}}, rotation = 0)));
  // illustration
  BusinessSimulation.CausalLoop.InfoFlowIndicator lab2 annotation(Placement(visible = true, transformation(origin = {-2.041, 55}, extent = {{-10, -10}, {10, 10}}, rotation = -450)));
  BusinessSimulation.CausalLoop.InfoFlowIndicator lab3 annotation(Placement(visible = true, transformation(origin = {-23.013, 55}, extent = {{-10, -10}, {10, 10}}, rotation = -270)));
  BusinessSimulation.CausalLoop.InfoFlowIndicator lab4 annotation(Placement(visible = true, transformation(origin = {20, 10}, extent = {{-10, -10}, {10, 10}}, rotation = -270)));
  BusinessSimulation.CausalLoop.InfoFlowIndicator lab5 annotation(Placement(visible = true, transformation(origin = {30, 68.007}, extent = {{-10, -10}, {10, 10}}, rotation = -540)));
  BusinessSimulation.CausalLoop.InfoFlowIndicator lab6 annotation(Placement(visible = true, transformation(origin = {47.85, 52.195}, extent = {{10, -10}, {-10, 10}}, rotation = 540)));
equation
  connect(hiring.massPort, newStaff.inflow) annotation(Line(visible = true, origin = {-60, 0}, points = {{-10, 0}, {10, 0}}, color = {128, 0, 128}));
  connect(newStaff.outflow, advancing.portA) annotation(Line(visible = true, origin = {-20, 0}, points = {{-10, 0}, {10, 0}}, color = {255, 0, 0}));
  connect(advancing.portB, experiencedStaff.inflow) annotation(Line(visible = true, origin = {20, 0}, points = {{-10, 0}, {10, 0}}, color = {128, 0, 128}));
  connect(experiencedStaff.outflow, leaving.massPort) annotation(Line(visible = true, origin = {60, 0}, points = {{-10, 0}, {10, 0}}, color = {128, 0, 128}));
  connect(timeToGainExperience.y, newStaff.u) annotation(Line(visible = true, origin = {-50.402, 26.667}, points = {{-10.804, 8.333}, {5.402, 8.333}, {5.402, -16.667}}, color = {1, 37, 163}, smooth = Smooth.Bezier));
  connect(leaving.u, turnover.y) annotation(Line(visible = true, origin = {91.333, -23.333}, points = {{-6.333, 13.333}, {-6.333, -6.667}, {12.667, -6.667}}, color = {0, 0, 128}, smooth = Smooth.Bezier));
  connect(hiringPolicy.y, hiring.u) annotation(Line(visible = true, origin = {-80.333, -30}, points = {{9.333, -10}, {-4.667, -10}, {-4.667, 20}}, color = {1, 37, 163}, smooth = Smooth.Bezier));
  connect(newStaff.y1, totalStaff.u[1]) "input new staff" annotation(Line(visible = true, origin = {-19.16, -15}, points = {{-10.34, 10}, {4.947, 10}, {4.947, -10}, {0.447, -10}}, color = {1, 37, 163}, smooth = Smooth.Bezier));
  connect(experiencedStaff.y2, totalStaff.u[2]) "input experienced staff" annotation(Line(visible = true, origin = {9.375, -22.5}, points = {{20.125, 17.5}, {10.625, 17.5}, {10.625, -2.5}, {-28.088, -2.5}}, color = {1, 37, 163}, smooth = Smooth.Bezier));
  connect(totalStaff.y, hiringPolicy.totalStaff) annotation(Line(visible = true, origin = {-41.785, -30}, points = {{7.072, 5}, {0.072, 5}, {0.072, -5}, {-7.215, -5}}, color = {1, 37, 163}, smooth = Smooth.Bezier));
  connect(io.aircraft, hiringPolicy.planes) "input planes" annotation(Line(visible = true, origin = {-3.8, 19}, points = {{3.8, 86}, {3.8, 21}, {18.8, 21}, {18.8, -64}, {-45.2, -64}}, color = {0, 0, 128}, smooth = Smooth.Bezier));
  connect(recruiters.u, experiencedStaff.y1) annotation(Line(visible = true, origin = {49.875, -22.5}, points = {{-11.875, -17.5}, {5.625, -17.5}, {5.625, 17.5}, {0.625, 17.5}}, color = {0, 0, 128}, smooth = Smooth.Bezier));
  connect(recruiters.y, hiringPolicy.recruiters) annotation(Line(visible = true, origin = {-13.5, -40}, points = {{35.5, 0}, {-35.5, 0}}, color = {1, 37, 163}));
  connect(totalStaff.y, io.totalStaff) "output total staff" annotation(Line(visible = true, origin = {-27.816, 36.429}, points = {{-6.897, -61.429}, {-30.524, -61.429}, {-30.524, -7.999}, {7.816, -7.999}, {7.816, 43.571}, {27.816, 43.571}, {27.816, 68.571}}, color = {1, 37, 163}, smooth = Smooth.Bezier));
  connect(newStaff.y, hiddenCoaching.u) annotation(Line(visible = true, origin = {-28.41, 22.278}, points = {{-6.59, -11.878}, {-6.59, 5.939}, {13.179, 5.939}}, color = {1, 37, 163}, smooth = Smooth.Bezier));
  connect(hiddenCoaching.y, unavailableStaff.u[1]) annotation(Line(visible = true, origin = {12.077, 34.108}, points = {{-11.308, -5.892}, {-4.308, -5.892}, {-4.308, 5.892}, {19.923, 5.892}}, color = {1, 37, 163}, smooth = Smooth.Bezier));
  connect(recruiters.y, unavailableStaff.u[2]) annotation(Line(visible = true, origin = {21.4, 0}, points = {{0.6, -40}, {-4.801, -40}, {-4.801, 40}, {10.6, 40}}, color = {1, 37, 163}, smooth = Smooth.Bezier));
  connect(unavailableStaff.y, effectiveServiceStaff.u2) annotation(Line(visible = true, origin = {57.879, 37.5}, points = {{-9.879, 2.5}, {2.121, 2.5}, {2.121, -2.5}, {14.121, -2.5}}, color = {1, 37, 163}, smooth = Smooth.Bezier));
  connect(experiencedStaff.y, effectiveServiceStaff.u1) annotation(Line(visible = true, origin = {54, 20.133}, points = {{-9, -9.733}, {-9, 4.867}, {18, 4.867}}, color = {1, 37, 163}, smooth = Smooth.Bezier));
  connect(serviceProductivity.y, serviceQuality.SP) annotation(Line(visible = true, origin = {93.347, 80}, points = {{10.653, 10}, {0.041, 10}, {0.041, -10}, {-12.347, -10}}, color = {1, 37, 163}, smooth = Smooth.Bezier));
  connect(serviceQuality.y, io.serviceQuality) "output service quality" annotation(Line(visible = true, origin = {19.667, 78.333}, points = {{39.333, -13.333}, {-19.667, -13.333}, {-19.667, 26.667}}, color = {1, 37, 163}, smooth = Smooth.Bezier));
  connect(io.RPM, serviceQuality.RPM) "input revenue passenger miles" annotation(Line(visible = true, origin = {56.2, 67}, points = {{-56.2, 38}, {-56.2, -17}, {43.8, -17}, {43.8, -2}, {24.8, -2}}, color = {0, 0, 128}, smooth = Smooth.Bezier));
  connect(effectiveServiceStaff.y, serviceQuality.serviceStaff) annotation(Line(visible = true, origin = {90.134, 45}, points = {{-2.134, -15}, {14.866, -15}, {14.866, 15}, {-9.134, 15}}, color = {1, 37, 163}, smooth = Smooth.Bezier));
  annotation(Diagram(coordinateSystem(extent = {{-148.5, -105}, {148.5, 105}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5}), graphics = {Text(visible = true, origin = {-54.511, 98.848}, textColor = {0, 0, 128}, extent = {{-34.511, -3.848}, {34.511, 3.848}}, textString = "planes", fontSize = 12, fontName = "Lato", horizontalAlignment = TextAlignment.Right), Text(visible = true, origin = {54.511, 98.848}, textColor = {0, 0, 128}, extent = {{-34.511, -3.848}, {34.511, 3.848}}, textString = "totalStaff", fontSize = 12, fontName = "Lato", horizontalAlignment = TextAlignment.Left), Text(visible = true, origin = {54.511, 93.848}, textColor = {0, 0, 128}, extent = {{-34.511, -3.848}, {34.511, 3.848}}, textString = "serviceQuality", fontSize = 12, fontName = "Lato", horizontalAlignment = TextAlignment.Left), Text(visible = true, origin = {-54.511, 93.848}, textColor = {0, 0, 128}, extent = {{-34.511, -3.848}, {34.511, 3.848}}, textString = "revenuePassengerMiles", fontSize = 12, fontName = "Lato", horizontalAlignment = TextAlignment.Right)}), Documentation(info = "<html>
<p class=\"aside\">This information is part of the ISDC2022 Workshops package.</p>
<p>PEX has two types of employees in this model: newly hired staff and experienced staff. The latter is also responsible for recruiting, e.g., interviewing candidates. Assuming sufficient numbers of applicants at all times, the growth of staff is completely dependent upon the number of experienced staff (<a href=\"modelica://ISDC2022_Workshops.Components.HiringPolicy\">→<code>hiringPolicy</code></a>). During the simulation period we will make the simplifying assumption that there is no staff turnover as all are excited to be part of this exciting startup.</p>
<p>
The effective number of service staff is calculated from the number of experienced staff after deducing those, that are envolved in recruitment and coaching of newly hired personnell. The number of effective service staff and its service productivity are main drivers for <a href=\"modelica://ISDC2022_Workshops.Components.ServiceQuality\">→<code>serviceQuality</code></a>.
</p>
</html>"));
end Staff;
