within ISDC2022_Workshops.Interfaces;

expandable connector IO "Information exchange between subsystems"
  import BusinessSimulation.Units.{Time,Rate,AmountRate,Fraction};
  extends BusinessSimulation.Interfaces.Connectors.DataBus;
  AmountRate potentialPassengerMiles "Travel demand";
  Real aircraft "Planes";
  Rate growthRate "Growth rate fleet as proxy for company growth rate";
  AmountRate RPM "Revenue passenger miles";
  Real totalStaff "Total number of staff employed";
  Fraction serviceQuality "Current quality of service";
  Real relativeFare "Ratio Peoples' fare to competitors' fare, i.e., less than one is advantageous";
  annotation(Documentation(info = "<html>
<p class=\"aside\">This information is part of the ISDC2022 Workshops package.</p>
<p>This is an <code>expandable connector</code> for information exchange between subsystems. All variables that will be exchanged will be predeclared as \"potentially present\".</p>
</html>"));
end IO;
