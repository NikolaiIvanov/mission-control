# MissionControl

App which will help to calculate fuel required for the flight. The goal of this application is to calculate fuel to launch from one planet of the Solar system, and to land on another planet of the Solar system, depending on the flight route.

#


## Installation
```bash
git clone https://github.com/NikolaiIvanov/mission-control.git && cd mission-control
mix deps.get
mix compile
iex -S mix
```

## Usage Help
```bash
$ iex -S mix
iex> MissionControll.help
```

## Tests
```bash
$ mix test
```

## Tests Cover
```bash
$ mix test --cover
```

## Code Quality Report
```bash
$ mix credo
```

## **[ExDoc](https://htmlpreview.github.io/?https://github.com/NikolaiIvanov/mission-control/blob/master/doc/MissionControl.html)**
```bash
$ mix docs
```