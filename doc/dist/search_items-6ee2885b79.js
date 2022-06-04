searchNodes=[{"doc":"Documentation for MissionControl . MissionControl calculate fuel required for the flight: launch from one planet of the Solar system, and to land on another planet of the Solar system, depending on the flight route.","ref":"MissionControl.html","title":"MissionControl","type":"module"},{"doc":"MissionControl.calculate/2 Calculate fuel required for whole Mission: Launch and Land on each Planet in list Examples iex&gt; MissionControl . calculate ( 28801 , [ { :launch , 9.807 } , { :land , 1.62 } , { :launch , 1.62 } , { :land , 9.807 } ] ) 51898","ref":"MissionControl.html#calculate/2","title":"MissionControl.calculate/2","type":"function"},{"doc":"MissionControl.calculate/3 Calculate fuel required to perform single Stage of Mission: Launch or Land Examples iex&gt; MissionControl . calculate ( 28801 , :land , 9.807 ) 13447 iex&gt; MissionControl . calculate ( 28801 , :land , :earth ) 13447","ref":"MissionControl.html#calculate/3","title":"MissionControl.calculate/3","type":"function"},{"doc":"MissionControl.help() Returns help for the module. Examples iex&gt; MissionControl . help ( ) %{ methods : [ mission : &quot;MissionControl.calculate(integer, list(tuple))&quot; , mission_stage : &quot;MissionControl.calculate(integer(), atom(), float())&quot; ] , requirenments : [ weight : [ type : &quot;Integer. Example: 28801&quot; , limitations : &quot;Greather than 0&quot; ] , mission_stages : [ type : &quot;Keyword List[Atom, Float | Atom], Example: [{:launch, 9.807}, {:land, 1.62}]&quot; , ] , planets_available : [ earth : 9.807 , moon : 1.62 , mars : 3.711 ] ] , examples : [ mission : &quot;MissionControl.calculate(28801, [{:launch, 9.807}, {:land, 1.62}, {:launch, :moon}, {:land, :earth}])&quot; , mission_stage : &quot;MissionControl.calculate(28801, :land, 9.807) or MissionControl.calculate(28801, :land, :earth)&quot; ] }","ref":"MissionControl.html#help/0","title":"MissionControl.help/0","type":"function"},{"doc":"Documentation for Stage .","ref":"MissionControl.Stage.html","title":"MissionControl.Stage","type":"module"},{"doc":"calc/3 Calculate basic fuel requirements for Mission Stages: Launch and Land Formula launch: mass gravity 0.042 - 33 land: mass gravity 0.033 - 42 Examples iex&gt; MissionControl.Stage . calc ( :land , 28801 , 1.62 ) 1497 iex&gt; MissionControl.Stage . calc ( :land , 28801 , :moon ) 1497","ref":"MissionControl.Stage.html#calc/3","title":"MissionControl.Stage.calc/3","type":"function"},{"doc":"extra_fuel/3 Calculate fuel requirements for a Mission round trip, including extra fuel for itself Examples iex&gt; MissionControl.Stage . extra_fuel ( :land , 28801 , 9.807 ) 13447 iex&gt; MissionControl.Stage . extra_fuel ( :land , 28801 , :earth ) 13447","ref":"MissionControl.Stage.html#extra_fuel/3","title":"MissionControl.Stage.extra_fuel/3","type":"function"},{"doc":"get_gravity/1 Get Planet gravity value Examples iex&gt; MissionControl.Stage.get_gravity(:earth) 9.807 iex&gt; MissionControl.Stage.get_gravity(9.807) 9.807","ref":"MissionControl.Stage.html#get_gravity/1","title":"MissionControl.Stage.get_gravity/1","type":"function"},{"doc":"Documentation for Validation .","ref":"MissionControl.Validation.html","title":"MissionControl.Validation","type":"module"},{"doc":"check/2 Check the Mission Stage inputs is valid? Examples iex&gt; MissionControl.Validation . check ( 28801 , &quot;fake&quot; ) { :error , &quot;Invalid Mission Stages.&quot; } iex&gt; MissionControl.Validation . check ( 1.23 , [ { :land , :earth } ] ) { :error , &quot;Ship weight must be an integer.&quot; } iex&gt; MissionControl.Validation . check ( 28801 , [ { :land , :earth } ] ) { :ok , [ { :land , :earth } ] }","ref":"MissionControl.Validation.html#check/2","title":"MissionControl.Validation.check/2","type":"function"},{"doc":"","ref":"MissionControl.Validation.html#check_single/1","title":"MissionControl.Validation.check_single/1","type":"function"},{"doc":"App which will help to calculate fuel required for the flight. The goal of this application is to calculate fuel to launch from one planet of the Solar system, and to land on another planet of the Solar system, depending on the flight route. #","ref":"readme.html","title":"MissionControl","type":"extras"},{"doc":"git clone https://github.com/NikolaiIvanov/mission-control.git &amp;&amp; cd mission-control mix deps.get mix compile iex -S mix","ref":"readme.html#installation","title":"MissionControl - Installation","type":"extras"},{"doc":"$ iex -S mix iex&gt; MissionControll.help","ref":"readme.html#usage-help","title":"MissionControl - Usage Help","type":"extras"},{"doc":"$ mix test","ref":"readme.html#tests","title":"MissionControl - Tests","type":"extras"},{"doc":"$ mix test --cover","ref":"readme.html#tests-cover","title":"MissionControl - Tests Cover","type":"extras"},{"doc":"$ mix credo","ref":"readme.html#code-quality-report","title":"MissionControl - Code Quality Report","type":"extras"},{"doc":"$ mix docs","ref":"readme.html#exdoc","title":"MissionControl - ExDoc","type":"extras"}]