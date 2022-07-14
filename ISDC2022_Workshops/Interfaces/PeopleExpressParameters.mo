within ISDC2022_Workshops.Interfaces;

encapsulated partial model PeopleExpressParameters "Model parameters"
  import BusinessSimulation.Units.{Rate,AmountRate,Time,Fraction,Amount};
  // fleet parameters
  parameter Rate growthTarget(displayUnit = "1/yr") = 2.21968543886352e-08 "Growth rate envisoned by Don Burr" annotation(Dialog(tab = "Fleet Parameters"));
  final parameter Real initialAircraft = 3 "Initial number of aircraft (initAC)" annotation(Dialog(enable = false, tab = "Fleet Parameters"));
  // staff parameters: hiring policy
  parameter Real maxCapacityMultiple(unit = "staff/plane") = 80 "Maximum capapcity multiplier (MCM), i.e., max #staff per plane" annotation(Dialog(tab = "Staff Parameters", group = "Recruitment"));
  parameter Rate recruitingIntensity(displayUnit = "1/yr") = 9.51293759512938e-07 "Recruiting intensity (RI), i.e., job interviews per recruiter per year" annotation(Dialog(tab = "Staff Parameters", group = "Recruitment"));
  parameter Amount acceptanceRatio(displayUnit = "percent") = 0.03 "Fraction of applicants accepted (AR)" annotation(Dialog(tab = "Staff Parameters", group = "Recruitment"));
  parameter Real fractionEnvolvedHiring = 0.15 "Fraction of experienced staff fully envolved in hiring (FHI)" annotation(Dialog(tab = "Staff Parameters", group = "Recruitment"));
  parameter Real trainingRatio = 0.03 "Experienced staff fully envolved in training per recruit (EPR)" annotation(Dialog(tab = "Staff Parameters", group = "Recruitment"));
  // staff parameters: service quality
  parameter AmountRate serviceProductivity(displayUnit = "million/yr") = 0.0475646879756469 "Service productivity (SP), i.e., revenue passenger miles per service staff and year" annotation(Dialog(tab = "Staff Parameters", group = "Service Quality"));
  // staff parameters: stocks
  parameter Real initialNewStaff = 0 "Initial number of new staff (initNS)" annotation(Dialog(enable = false, tab = "Staff Parameters", group = "Initial Values Stocks"));
  parameter Real initialExperiencedStaff = 200 " Initial number of experienced staff (initES)" annotation(Dialog(enable = false, tab = "Staff Parameters", group = "Initial Values Stocks"));
  // passengers parameters
  parameter Real initialFareCompetition(unit = "USD/RPM") = 0.25 "Initial fare for competition (ICF)" annotation(Dialog(tab = "PAX Parameters", group = "Winning Passengers"));
  parameter Real initialPeoplesFare(unit = "USD/RPM") = 0.09 "Initial peoples' fare (IPF)" annotation(Dialog(tab = "PAX Parameters", group = "Winning Passengers"));
  parameter Real finalPeoplesFare(unit = "USD/RPM") = 0.09 "Final peoples' fare (FPF)" annotation(Dialog(tab = "PAX Parameters", group = "Winning Passengers"));
  parameter Time pricePolicyStartTime(displayUnit = "yr") = 62472816000 "Start time for ramping up or down fares (PPST)" annotation(Dialog(tab = "PAX Parameters", group = "Winning Passengers"));
  parameter Time pricePolicyDuration(displayUnit = "yr") = 0 "Duration of price adaptation (PPD)" annotation(Dialog(tab = "PAX Parameters", group = "Winning Passengers"));
  parameter Time adjustmentTimePrice(displayUnit = "yr") = 126144000 "Time to adjust costs and fare to peoples (ATP)" annotation(Dialog(tab = "PAX Parameters", group = "Winning Passengers"));
  parameter Time timeToPerceiveServiceQuality(displayUnit = "yr") = 31536000 "Time to perceive service quality (TTP)" annotation(Dialog(tab = "PAX Parameters", group = "Losing Passengers"));
  parameter Real milesPerFlight(unit = "miles") = 800 "Average distance travelled per passenger and flight (MPF)" annotation(Dialog(tab = "PAX Parameters", group = "Utilization"));
  parameter Rate flightsPerYear(displayUnit = "1/yr") = 1.26839167935058e-07 "Average number of flights per passenger and year (FPY)" annotation(Dialog(tab = "PAX Parameters", group = "Utilization"));
  parameter Amount initialPotentialPassengers(displayUnit = "thousand") = 180e3 "Initial number of potential passengers (initPP)" annotation(Dialog(enable = false, tab = "PAX Parameters", group = "Initial Value Stocks"));
  annotation(experiment(StartTime = 62472816000, StopTime = 62693568000, __Wolfram_DisplayTimeUnit = "yr"), Diagram(coordinateSystem(extent = {{-150, -90}, {150, 90}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5})), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10, 10}), graphics = {Text(visible = true, textColor = {64, 64, 64}, extent = {{-150, 110}, {150, 150}}, textString = "%name"), Rectangle(visible = true, fillColor = {255, 255, 255}, pattern = LinePattern.None, extent = {{-100, -100}, {100, 100}})}));
end PeopleExpressParameters;
