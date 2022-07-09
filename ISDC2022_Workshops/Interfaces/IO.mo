within ISDC2022_Workshops.Interfaces;

expandable connector IO "Information exchange between subsystems"
  import BusinessSimulation.Units.{Time,Rate};
  extends BusinessSimulation.Interfaces.Connectors.DataBus;
  Real potentialPassengerMiles(unit = "RPM/year") "Travel demand";
  annotation(Documentation(info = "<html>
<p class=\"aside\">This information is part of the ISDC2022 Workshops package.</p>
<p>This is an <code>expandable connector</code> for information exchange between subsystems. All variables that will be exchanged will be predeclared as \"potentially present\".</p>
</html>"));
end IO;
