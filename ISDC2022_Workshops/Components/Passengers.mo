within ISDC2022_Workshops.Components;

model Passengers "Passenger and market subsystem"
  extends Interfaces.Passengers;
  parameter BusinessSimulation.Units.Time TTP(displayUnit = "yr") = 31536000 "Time to perceive service quality";
  parameter BusinessSimulation.Units.Time ATP(displayUnit = "yr") = 126144000 "Time to adjust costs and fare to peoples";
  parameter Real ICF(unit = "USD/RPM") = 0.25 "Initial fare for competition";
  parameter Real IPF(unit = "USD/RPM") = 0.09 "Initial peoples' fare";
  parameter Real FPF(unit = "USD/RPM") = 0.09 "Final peoples' fare";
  parameter BusinessSimulation.Units.Time PPST(displayUnit = "yr") = 62472816000 "Start time for ramping up or down fares";
  parameter BusinessSimulation.Units.Time PPD(displayUnit = "yr") = 0 "Duration of price adaptation";
  parameter Real MPF(unit = "miles") = 800 "Average distance travelled per passenger and flight";
  parameter Real FPY(unit = "1/yr") = 4 "Average number of flights per passenger and year";
protected
  BusinessSimulation.Stocks.MaterialStock potentialPassengers(redeclare replaceable type OutputType = BusinessSimulation.Units.Amount, initialValue(displayUnit = "thousand") = 180000) "Maximum number of passengers for PEX flights" annotation(Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BusinessSimulation.SourcesOrSinks.ExponentialChange winning "Increase of potential passengers" annotation(Placement(visible = true, transformation(origin = {-60, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BusinessSimulation.SourcesOrSinks.ExponentialDecline losing "Losing potential passengers" annotation(Placement(visible = true, transformation(origin = {60, 0}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  BusinessSimulation.Converters.DiscreteDelay.Smooth serviceReputation(hasConstantDelayTime = false) "Service quality perceived by passengers" annotation(Placement(visible = true, transformation(origin = {20, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BusinessSimulation.Converters.ConstantConverter perceptionTime(value = TTP, redeclare replaceable type OutputType = BusinessSimulation.Units.Time) "Time constant for perception delay" annotation(Placement(visible = true, transformation(origin = {50, 80}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  BusinessSimulation.Converters.Lookup.JanoschekNegative churnRate(convertOutput = true, outputIsRate = true, timeBaseTableOut = BusinessSimulation.Types.TimeBases.years, lowerBound = 0, upperBound = 1, x_ref = 0.5, y_ref = 0.5, growthRate = 6) "Rate of losing passengers to competitors" annotation(Placement(visible = true, transformation(origin = {50, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BusinessSimulation.CausalLoop.InputControl peoplesFare(initialInput = IPF, finalInput = FPF, startTime(displayUnit = "yr") = PPST, duration(displayUnit = "yr") = PPD) "Setting the prive per passenger mile" annotation(Placement(visible = true, transformation(origin = {-122.946, 55}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BusinessSimulation.Converters.DiscreteDelay.Smooth competitorFare(hasConstantDelayTime = false, initialValue = ICF) "Average fare for the competition" annotation(Placement(visible = true, transformation(origin = {-97.946, 55}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BusinessSimulation.Converters.ConstantConverterTime adjustmentTimePrice(value(displayUnit = "yr") = ATP) "Time constant for adapting to peoples express fare" annotation(Placement(visible = true, transformation(origin = {-80, 80}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  BusinessSimulation.Converters.Division relativeFare "Ratio of Peoples' fare to competitors'fare, i.e., less than one is advantageous" annotation(Placement(visible = true, transformation(origin = {-65, 47.73}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BusinessSimulation.Converters.Lookup.JanoschekNegative conversionRate(redeclare replaceable type OutputType = BusinessSimulation.Units.Rate, upperBound = 3, lowerBound = -0.2, growthRate = 3, x_ref = 0.4, y_ref = 1.8, convertOutput = true, outputIsRate = true, timeBaseTableOut = BusinessSimulation.Types.TimeBases.years) "A nonlinear function of the relative fare" annotation(Placement(visible = true, transformation(origin = {-43.102, 26.603}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  BusinessSimulation.Converters.ConstantConverter avgDistanceTraveled(value = MPF) "Miles traveled per passenger and flight" annotation(Placement(visible = true, transformation(origin = {-40, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BusinessSimulation.Converters.ConstantConverter travelFrequency(value = FPY, redeclare replaceable type OutputType = BusinessSimulation.Units.Rate) "Flights per passenger and year" annotation(Placement(visible = true, transformation(origin = {-40, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BusinessSimulation.Converters.Product_3 potentialPassengerMiles(redeclare replaceable type OutputType = BusinessSimulation.Units.Rate) "Potential demand size per year" annotation(Placement(visible = true, transformation(origin = {40, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  // illustration
  BusinessSimulation.CausalLoop.InfoFlowIndicator lab2 annotation(Placement(visible = true, transformation(origin = {-35, 52.192}, extent = {{-10, -10}, {10, 10}}, rotation = -360)));
  BusinessSimulation.CausalLoop.InfoFlowIndicator lab3 annotation(Placement(visible = true, transformation(origin = {-1.722, 42.57}, extent = {{-10, -10}, {10, 10}}, rotation = -270)));
equation
  connect(winning.massPort, potentialPassengers.inflow) annotation(Line(visible = true, origin = {-30, 0}, points = {{-20, 0}, {20, 0}}, color = {128, 0, 128}));
  connect(potentialPassengers.outflow, losing.massPort) annotation(Line(visible = true, origin = {30, 0}, points = {{-20, 0}, {20, 0}}, color = {128, 0, 128}));
  connect(io.serviceQuality, serviceReputation.u) "input service quality" annotation(Line(visible = true, origin = {3.546, 75}, points = {{-3.546, 30}, {-3.546, -15}, {7.092, -15}}, color = {0, 0, 128}, smooth = Smooth.Bezier));
  connect(perceptionTime.y, serviceReputation.u_delayTime) annotation(Line(visible = true, origin = {28, 75}, points = {{16, 5}, {-8, 5}, {-8, -10}}, color = {1, 37, 163}, smooth = Smooth.Bezier));
  connect(churnRate.y, losing.u) annotation(Line(visible = true, origin = {62.667, 30}, points = {{-4.667, 10}, {2.333, 10}, {2.333, -20}}, color = {1, 37, 163}, smooth = Smooth.Bezier));
  connect(serviceReputation.y, churnRate.u) annotation(Line(visible = true, origin = {35.5, 50}, points = {{-5.5, 10}, {-0.5, 10}, {-0.5, -10}, {6.5, -10}}, color = {1, 37, 163}, smooth = Smooth.Bezier));
  connect(peoplesFare.y, competitorFare.u) annotation(Line(visible = true, origin = {-115.127, 55}, points = {{-7.819, 0}, {7.819, 0}}, color = {1, 37, 163}));
  connect(adjustmentTimePrice.y, competitorFare.u_delayTime) annotation(Line(visible = true, origin = {-93.964, 73.333}, points = {{7.964, 6.667}, {-3.982, 6.667}, {-3.982, -13.333}}, color = {1, 37, 163}, smooth = Smooth.Bezier));
  connect(competitorFare.y, relativeFare.u2) annotation(Line(visible = true, origin = {-81.71, 48.865}, points = {{-6.236, 6.135}, {-1.237, 6.135}, {-1.237, -6.135}, {8.71, -6.135}}, color = {1, 37, 163}, smooth = Smooth.Bezier));
  connect(peoplesFare.y, relativeFare.u1) annotation(Line(visible = true, origin = {-94.135, 49.205}, points = {{-28.811, 5.795}, {-20.865, 5.795}, {-20.865, -9.205}, {14.135, -9.205}, {14.135, 3.525}, {21.135, 3.525}}, color = {1, 37, 163}, smooth = Smooth.Bezier));
  connect(relativeFare.y, io.relativeFare) "output relative fare" annotation(Line(visible = true, origin = {-19, 66.82}, points = {{-38, -19.09}, {19, -19.09}, {19, 38.18}}, color = {1, 37, 163}, smooth = Smooth.Bezier));
  connect(conversionRate.y, winning.u) annotation(Line(visible = true, origin = {-60.367, 21.069}, points = {{9.265, 5.534}, {-4.633, 5.534}, {-4.633, -11.069}}, color = {1, 37, 163}, smooth = Smooth.Bezier));
  connect(relativeFare.y, conversionRate.u) annotation(Line(visible = true, origin = {-33.026, 37.166}, points = {{-23.974, 10.564}, {13.026, 10.564}, {13.026, -10.564}, {-2.077, -10.564}}, color = {1, 37, 163}, smooth = Smooth.Bezier));
  connect(travelFrequency.y, potentialPassengerMiles.u3) annotation(Line(visible = true, origin = {-12.482, -72.5}, points = {{-21.518, -7.5}, {12.482, -7.5}, {12.482, 7.5}, {44.482, 7.5}}, color = {1, 37, 163}, smooth = Smooth.Bezier));
  connect(avgDistanceTraveled.y, potentialPassengerMiles.u2) annotation(Line(visible = true, origin = {-12.131, -50}, points = {{-21.869, 10}, {0.199, 10}, {0.199, -10}, {44.131, -10}}, color = {1, 37, 163}, smooth = Smooth.Bezier));
  connect(potentialPassengers.y1, potentialPassengerMiles.u1) annotation(Line(visible = true, origin = {19.004, -30}, points = {{-8.504, 25}, {0.996, 25}, {0.996, -25}, {12.996, -25}}, color = {1, 37, 163}, smooth = Smooth.Bezier));
  connect(potentialPassengerMiles.y, io.potentialPassengerMiles) "output potential passenger miles" annotation(Line(visible = true, origin = {49.6, 5}, points = {{-1.6, -65}, {50.4, -65}, {50.4, 15}, {-49.6, 15}, {-49.6, 100}}, color = {1, 37, 163}, smooth = Smooth.Bezier));
  annotation(Documentation(info = "<html>
<p class=\"aside\">This information is part of the ISDC2022 Workshops package.</p>
<p>
Following John Morecroft's interpretation [<a href=\"modelica://ISDC2022_Workshops.UsersGuide.References\">1</a>], in this stylized model PEX wins and loses passengers by processes of exponential growth and decline, which can be justified by word-of-mouth-like processes in reality.
</p>
<p>
PEX can be seen as a price setter, that is followed by the rest of the industry. Accordingly the fare of competitors' can be modeled as a <em>smooth</em> of Peoples' fare. Relative fare can then be used as an input to a—negatively sloped—s-shaped look-up function (<a href=\"modelica://BusinessSimulation.Converters.Lookup.JanoschekNegative\">→<code>JanoschekNegative</code></a>) to arrive at a fractional rate of winning new passengers (<code>conversionRate</code>). Conversely, existing passengers perceive <code>serviceQuality</code>—again modeled by a smooth—and will decide to abandon PEX. This decision is also modeled using a negatively sloping s-shaped look-up function (<code>churnRate</code>).
</p>
</html>"), Diagram(coordinateSystem(extent = {{-148.5, -105}, {148.5, 105}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5}), graphics = {Text(visible = true, origin = {55, 98.848}, textColor = {0, 0, 128}, extent = {{-34.511, -3.848}, {34.511, 3.848}}, textString = "relativeFare", fontSize = 12, fontName = "Lato", horizontalAlignment = TextAlignment.Left), Text(visible = true, origin = {55, 93.848}, textColor = {0, 0, 128}, extent = {{-34.511, -3.848}, {34.511, 3.848}}, textString = "potentialPassengerMiles", fontSize = 12, fontName = "Lato", horizontalAlignment = TextAlignment.Left), Text(visible = true, origin = {-54.511, 98.848}, textColor = {0, 0, 128}, extent = {{-34.511, -3.848}, {34.511, 3.848}}, textString = "serviceQuality", fontSize = 12, fontName = "Lato", horizontalAlignment = TextAlignment.Right)}));
end Passengers;
