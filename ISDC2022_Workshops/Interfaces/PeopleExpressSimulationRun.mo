within ISDC2022_Workshops.Interfaces;

partial model PeopleExpressSimulationRun "Model settings and experiement annotation for basic run"
  inner BusinessSimulation.ModelSettings modelSettings(modelDisplayTimeBase = BusinessSimulation.Types.TimeBases.years, modelTimeHorizon(displayUnit = "yr") = 220752000, dt(displayUnit = "yr") = 7884000) annotation(Placement(visible = true, transformation(origin = {-110, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  annotation(experiment(StartTime = 62472816000, StopTime = 62693568000, __Wolfram_DisplayTimeUnit = "yr"), Diagram(coordinateSystem(extent = {{-150, -90}, {150, 90}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5})), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10, 10}), graphics = {Rectangle(visible = true, fillColor = {255, 255, 255}, pattern = LinePattern.None, extent = {{-100, -100}, {100, 100}})}));
end PeopleExpressSimulationRun;
