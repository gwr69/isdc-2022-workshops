within ISDC2022_Workshops.Components;

model Passengers "Passenger and market subsystem"
  extends Interfaces.Passengers;
  parameter BusinessSimulation.Units.Time TTP(displayUnit = "yr") = 31536000 "Time to perceive service quality";
  BusinessSimulation.Stocks.MaterialStock potentialPassengers(redeclare replaceable type OutputType = BusinessSimulation.Units.Amount, initialValue(displayUnit = "thousand") = 180000) "Maximum number of passengers for PEX flights" annotation(Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BusinessSimulation.SourcesOrSinks.ExponentialChange winning "Increase of potential passengers" annotation(Placement(visible = true, transformation(origin = {-60, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BusinessSimulation.SourcesOrSinks.ExponentialDecline losing "Losing potential passengers" annotation(Placement(visible = true, transformation(origin = {60, 0}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  BusinessSimulation.Converters.DiscreteDelay.Smooth serviceReputation(hasConstantDelayTime = false) "Service quality perceived by passengers" annotation(Placement(visible = true, transformation(origin = {20, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BusinessSimulation.Converters.ConstantConverter perceptionTime(value = TTP) "Time constant for perception delay" annotation(Placement(visible = true, transformation(origin = {50, 80}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  BusinessSimulation.Converters.Lookup.JanoschekNegative churnRate(convertOutput = true, outputIsRate = true, timeBaseTableOut = BusinessSimulation.Types.TimeBases.years, lowerBound = 0, upperBound = 1) "Rate of losing passengers to competitors" annotation(Placement(visible = true, transformation(origin = {50, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(winning.massPort, potentialPassengers.inflow) annotation(Line(visible = true, origin = {-30, 0}, points = {{-20, 0}, {20, 0}}, color = {128, 0, 128}));
  connect(potentialPassengers.outflow, losing.massPort) annotation(Line(visible = true, origin = {30, 0}, points = {{-20, 0}, {20, 0}}, color = {128, 0, 128}));
  connect(io.serviceQuality, serviceReputation.u) "input service quality" annotation(Line(visible = true, origin = {3.546, 75}, points = {{-3.546, 30}, {-3.546, -15}, {7.092, -15}}, color = {0, 0, 128}, smooth = Smooth.Bezier));
  connect(perceptionTime.y, serviceReputation.u_delayTime) annotation(Line(visible = true, origin = {28, 75}, points = {{16, 5}, {-8, 5}, {-8, -10}}, color = {1, 37, 163}, smooth = Smooth.Bezier));
  connect(churnRate.y, losing.u) annotation(Line(visible = true, origin = {62.667, 30}, points = {{-4.667, 10}, {2.333, 10}, {2.333, -20}}, color = {1, 37, 163}, smooth = Smooth.Bezier));
  connect(serviceReputation.y, churnRate.u) annotation(Line(visible = true, origin = {35.5, 50}, points = {{-5.5, 10}, {-0.5, 10}, {-0.5, -10}, {6.5, -10}}, color = {1, 37, 163}, smooth = Smooth.Bezier));
end Passengers;
