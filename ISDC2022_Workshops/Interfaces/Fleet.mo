within ISDC2022_Workshops.Interfaces;

partial model Fleet "Aircraft used in operations"
  extends Interfaces.Subsystem;
  extends Icons.Plane;
  annotation(Documentation(info = "<html>
<p class=\"aside\">This information is part of the ISDC2022 Workshops package.</p>
<p>Partial model for fleet subsystem.</p>
</html>"));
end Fleet;
