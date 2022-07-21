within ISDC2022_Workshops.Components;

block HiringPolicy "Setting the hiring rate"
  extends BusinessSimulation.Interfaces.PartialConverters.Policy_SO;
  parameter Real MCM(unit = "people") = 60 "Maximum capapcity multiplier, i.e., max staff per plane";
  parameter BusinessSimulation.Units.Rate RI(displayUnit = "1/yr") = 9.51293759512938e-07 "Recruiting intensity, i.e., job interviews per recruiter per year";
  parameter BusinessSimulation.Units.Amount AR(displayUnit = "percent") = 0.03 "Fraction of applicants accepted";
  BusinessSimulation.Interfaces.Connectors.RealInput planes "Number of aircraft in the fleet" annotation(Placement(visible = true, transformation(origin = {-145, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BusinessSimulation.Interfaces.Connectors.RealInput recruiters "Staff available for screening candidates" annotation(Placement(visible = true, transformation(origin = {-145, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BusinessSimulation.Interfaces.Connectors.RealInput totalStaff "Total staff currently employed" annotation(Placement(visible = true, transformation(origin = {-145, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BusinessSimulation.Converters.Product_2 maxCapacity "Maximum capacity for staff" annotation(Placement(visible = true, transformation(origin = {-60, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BusinessSimulation.Converters.ConstantConverter maxStaffPerPlane(value = MCM) "Maximum staff per plane" annotation(Placement(visible = true, transformation(origin = {-110, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BusinessSimulation.Converters.Logical.Less belowLimitQ "True, if total staff below limit on staff" annotation(Placement(visible = true, transformation(origin = {40, 20}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  BusinessSimulation.Converters.ConstantConverterRate noHiring(timeBaseString = "year", value = 0) "Zero hiring rate" annotation(Placement(visible = true, transformation(origin = {40, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BusinessSimulation.Converters.Logical.Switch hiringRate(redeclare replaceable type OutputType = BusinessSimulation.Units.Rate) annotation(Placement(visible = true, transformation(origin = {80, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -360)));
  BusinessSimulation.Converters.ConstantConverter recruitingLoad(value = RI) "Job interview rate per recruiter" annotation(Placement(visible = true, transformation(origin = {-120, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BusinessSimulation.Converters.Product_2 interviewRate(redeclare replaceable type OutputType = BusinessSimulation.Units.Rate) "Job interviews per period" annotation(Placement(visible = true, transformation(origin = {-80, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BusinessSimulation.Converters.ConstantConverter acceptedFraction(value = AR) "Fraction of applicants accepted" annotation(Placement(visible = true, transformation(origin = {-70, 15}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BusinessSimulation.Converters.Product_2 unrestrictedHiringRate(redeclare replaceable type OutputType = BusinessSimulation.Units.Rate) "Hiring rate before taking capacity restrictions into account" annotation(Placement(visible = true, transformation(origin = {-32.465, 5}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(planes, maxCapacity.u1) annotation(Line(visible = true, origin = {-118.494, 50}, points = {{-26.506, 10}, {15.636, 10}, {15.636, -5}, {50.494, -5}}, color = {0, 0, 128}, smooth = Smooth.Bezier));
  connect(maxStaffPerPlane.y, maxCapacity.u2) annotation(Line(visible = true, origin = {-90.045, 27.5}, points = {{-13.955, -7.5}, {5.045, -7.5}, {5.045, 7.5}, {22.045, 7.5}}, color = {1, 37, 163}, smooth = Smooth.Bezier));
  connect(totalStaff, belowLimitQ.u1) annotation(Line(visible = true, origin = {-18.25, -12.5}, points = {{-126.75, -47.5}, {5.103, -47.5}, {5.103, 27.5}, {50.25, 27.5}}, color = {0, 0, 128}, smooth = Smooth.Bezier));
  connect(maxCapacity.y, belowLimitQ.u2) annotation(Line(visible = true, origin = {-5, 32.5}, points = {{-47, 7.5}, {5, 7.5}, {5, -7.5}, {37, -7.5}}, color = {1, 37, 163}, smooth = Smooth.Bezier));
  connect(hiringRate.y, y) annotation(Line(visible = true, origin = {124, 0}, points = {{-36, 0}, {36, -0}}, color = {1, 37, 163}));
  connect(belowLimitQ.y, hiringRate.u_cond) annotation(Line(visible = true, origin = {69.341, 15.996}, points = {{-21.341, 4.004}, {10.671, 4.004}, {10.671, -8.008}}, color = {190, 52, 178}, smooth = Smooth.Bezier));
  connect(noHiring.y, hiringRate.u2) annotation(Line(visible = true, origin = {62, -17.5}, points = {{-16, -12.5}, {-2, -12.5}, {-2, 12.5}, {10, 12.5}}, color = {1, 37, 163}, smooth = Smooth.Bezier));
  connect(recruiters, interviewRate.u1) annotation(Line(visible = true, origin = {-113.25, -7.5}, points = {{-31.75, 7.5}, {3.25, 7.5}, {3.25, -7.5}, {25.25, -7.5}}, color = {0, 0, 128}, smooth = Smooth.Bezier));
  connect(recruitingLoad.y, interviewRate.u2) annotation(Line(visible = true, origin = {-103, -32.5}, points = {{-11, -7.5}, {-2, -7.5}, {-2, 7.5}, {15, 7.5}}, color = {1, 37, 163}, smooth = Smooth.Bezier));
  connect(acceptedFraction.y, unrestrictedHiringRate.u1) annotation(Line(visible = true, origin = {-53.616, 12.5}, points = {{-10.384, 2.5}, {-1.384, 2.5}, {-1.384, -2.5}, {13.151, -2.5}}, color = {1, 37, 163}, smooth = Smooth.Bezier));
  connect(interviewRate.y, unrestrictedHiringRate.u2) annotation(Line(visible = true, origin = {-59.609, -12.5}, points = {{-12.391, -7.5}, {-0.391, -7.5}, {-0.391, 12.5}, {19.144, 12.5}}, color = {1, 37, 163}, smooth = Smooth.Bezier));
  connect(unrestrictedHiringRate.y, hiringRate.u1) annotation(Line(visible = true, origin = {22.5, 2.5}, points = {{-46.965, 2.5}, {-2.5, 2.5}, {-2.5, 2.5}, {49.5, 2.5}}, color = {1, 37, 163}, smooth = Smooth.Bezier));
  annotation(Documentation(info = "<html>
<p class=\"aside\">This information is part of the ISDC2022 Workshops package.</p>
<p>Hiring in People Express is almost entirely driven by the size of the experienced workforce, which needs to interview candidates. PEX prides itself not to fire staff—unless proven incompetent—and will not hire more than needed, which here is checked with regard to a multiple of the current fleet size.</p>
<h4>See also</h4>
<p>
<a href=\"modelica://ISDC2022_Workshops.Components.Staff\">Staff</a>
</p>
</html>"), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10, 10}), graphics = {Text(visible = true, textColor = {0, 0, 128}, extent = {{-96.456, -12}, {96.456, 12}}, textString = "RECRUITING", fontName = "Lato Black", textStyle = {TextStyle.Bold})}));
end HiringPolicy;
