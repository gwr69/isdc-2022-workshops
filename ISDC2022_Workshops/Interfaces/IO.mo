within ISDC2022_Workshops.Interfaces;

expandable connector IO "Information exchange between subsystems"
  import BusinessSimulation.Units.{Time,Rate,AmountRate,Fraction,Amount};
  extends BusinessSimulation.Interfaces.Connectors.DataBus;
  // fleet output
  Real aircraft "Planes";
  Rate growthRate(displayUnit = "1/yr") "Growth rate fleet as proxy for company growth rate";
  // staff output
  Real totalStaff "Total number of staff employed";
  Fraction serviceQuality "Current quality of service";
  // passengers output
  AmountRate potentialPassengerMiles(displayUnit = "billion/yr") "Travel demand";
  AmountRate RPM(displayUnit = "billion/yr") "Revenue passenger miles";
  Real relativeFare "Ratio Peoples' fare to competitors' fare, i.e., less than one is advantageous";
  Amount potentialPassengers(displayUnit = "thousand") "Potential PEX passengers";
  Rate travelFrequency(displayUnit = "1/yr") "Flights per passenger per year";
  Real peoplesFare(unit = "USD/RPM") "USD per revenue passenger mile";
  annotation(Documentation(info = "<html>
<p class=\"aside\">This information is part of the ISDC2022 Workshops package.</p>
<p>This is an <code>expandable connector</code> for information exchange between subsystems. All variables that will be exchanged will be predeclared as \"potentially present\".</p>
</html>"));
end IO;
