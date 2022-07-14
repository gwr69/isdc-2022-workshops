within ISDC2022_Workshops.Examples.PeopleExpress;

model BaseRun "Basic model for PEX dynamics"
  extends ISDC2022_Workshops.Interfaces.PeopleExpressSimulationRun;
  extends ISDC2022_Workshops.Interfaces.PeopleExpressParameters;
  extends BusinessSimulation.Icons.SimulationModel;
  Interfaces.IO dataExchange "Hub for exchanging information between subsystems" annotation(Placement(visible = true, transformation(origin = {-3.037, 82.915}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Components.Fleet fleet(growthTarget = growthTarget, initAC = initialAircraft) "PEX fleet subsystem" annotation(Placement(visible = true, transformation(origin = {-92.639, 65}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Components.Staff staff(initNS = initialNewStaff, initES = initialExperiencedStaff, SP = serviceProductivity, MCM = maxCapacityMultiple, RI = recruitingIntensity, AR = acceptanceRatio, FHI = fractionEnvolvedHiring, EPR = trainingRatio) "PEX staff subsystem" annotation(Placement(visible = true, transformation(origin = {-3.037, -6.963}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Components.Passengers passengers(initPP = initialPotentialPassengers, TTP = timeToPerceiveServiceQuality, ATP = adjustmentTimePrice, ICF = initialFareCompetition, IPF = initialPeoplesFare, FPF = finalPeoplesFare, PPST = pricePolicyStartTime, PPD = pricePolicyDuration, MPF = milesPerFlight, FPY = flightsPerYear) "PEX passenger subsystem" annotation(Placement(visible = true, transformation(origin = {95, 66.902}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(dataExchange, staff.io) annotation(Line(visible = true, origin = {-3.037, 42.976}, points = {{0, 39.939}, {0, -39.939}}, color = {0, 0, 128}));
  connect(dataExchange, passengers.io) annotation(Line(visible = true, origin = {62.321, 80.911}, points = {{-65.358, 2.004}, {32.679, 2.004}, {32.679, -4.009}}, color = {0, 0, 128}));
  connect(dataExchange, fleet.io) annotation(Line(visible = true, origin = {-62.772, 80.277}, points = {{59.735, 2.638}, {-29.867, 2.638}, {-29.867, -5.277}}, color = {0, 0, 128}));
  annotation(Documentation(info = "<html>
<p class=\"aside\">This information is part of the ISDC2022 Workshops package.</p>
<p>
This stylized interpretation of the People Express model by John Morecroft [<a href=\"modelica://ISDC2022_Workshops.UsersGuide.References\">1</a>] [<a href=\"modelica://ISDC2022_Workshops.UsersGuide.References\">2</a>] consists of three subsystems: a <a href =\"modelica://ISDC2022_Workshops.Components.Fleet\">fleet</a>, a <a href =\"modelica://ISDC2022_Workshops.Components.Staff\">staff</a>, and a <a href =\"modelica://ISDC2022_Workshops.Components.Passengers\">passengers subsystem</a>.
</p>
<h4>Notes</h4>
<p>
Unlike the subsystem-diagram shown in the background, the model uses a central <code>expandable connector</code> as a <em>hub</em> or <em>data bus</em> for information exchange between subsystems. Unlike typical subsystem diagrams there are accordingly no dircted edges used in any connections. There are some reasons to prefer this structure in building large models: 
</p>
<ul>
<li>While directed edges clearly indicate <em>causality</em>, they may mislead model users to also believe that a loop between subsystems means that there is a feedback loop with regard to the <em>flattened model</em>. But a causal link between subsystems is <em>no reliable indicator with regard to a feedback loop</em>, as we cannot say anything about the further path not visible at the scope of the diagram we are looking at.</li><br>
<li>For any pair of subsystems that exchange information <em>both ways</em>, we will need two directed edges—quickly cluttering a diagram.</li><br>
<li>Having to connect all <em>n</em> subsystems with each other to establish information exchange may in the worst case (each subsystem is connected to all the others) grow proportional to the number of subsystems squared, e.g., in the worst case we need to draw <code>n (n - 1)</code> connections. This is clearly not advantageous and using a central hub means that we simply have to draw as many connections as there are subsystems and all subsystems will be connected to each other.</li><br>
<li>To do feedback loop related analyses we will have to look at the <em>flattened</em> structure of the model. This can be done <em>algorithmically</em> and thus we do not forfeit analytical options while enjoying the benefits of object-orientation for building larger models.</li>
</ul>
<h4>Acknowledgements</h4>
<p>
The <a href=\"https://de.wikipedia.org/wiki/People_Express#/media/Datei:People_Express_Boeing_747_at_London_Gatwick_in_June_1983.jpg\">background image</a> cpoyright © 1983 by Eduart Marmet shows a People Express Boing 747 at London Gatwick in June 1983 and is licensed <a href=\"https://creativecommons.org/licenses/by-sa/3.0/\"><span style=\"white-space: nowrap\">CC BY-SA 3.0</span></a>. 
</p>
</html>", figures = {Figure(title = "Revenue Passenger Miles (RPM)", identifier = "rpm", preferred = true, plots = {Plot(curves = {Curve(y = dataExchange.RPM, legend = "RPM")})}, caption = "People Express Revenue Passenger Miles p.a.")}), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10, 10})), Diagram(coordinateSystem(extent = {{-147.5, -83}, {147.5, 83}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5}), graphics = {Bitmap(visible = true, fileName = "modelica://ISDC2022_Workshops/Resources/Images/Examples/PeopleExpress/BaseRun/ModelSketch.png", imageSource = "", extent = {{-147.5, -83}, {147.5, 83}})}));
end BaseRun;
