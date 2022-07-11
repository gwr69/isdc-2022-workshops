within ISDC2022_Workshops.Interfaces;

partial model Subsystem "Partial subsystem model"
  import BusinessSimulation.ModelSettings;
  extends BusinessSimulation.Icons.SubsystemTransceiver;
  IO io "Information exchange" annotation(Placement(visible = true, transformation(origin = {-0, 105}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BusinessSimulation.CausalLoop.InfoFlowIndicator lab annotation(Placement(visible = true, transformation(origin = {10, 97.53}, extent = {{-10, -10}, {10, 10}}, rotation = -270)));
  BusinessSimulation.CausalLoop.InfoFlowIndicator lab1 annotation(Placement(visible = true, transformation(origin = {-10, 98.416}, extent = {{-10, -10}, {10, 10}}, rotation = -450)));
  annotation(Documentation(info = "<html>
<p class=\"aside\">This information is part of the ISDC2022 Workshops package.</p>
<p>Partial subsystem class for extension.</p>
</html>"));
end Subsystem;
