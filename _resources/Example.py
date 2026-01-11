import fastf1
import fastf1.plotting
import matplotlib.pyplot as plt
from matplotlib.ticker import FuncFormatter
from matplotlib.widgets import Cursor
import json

fastf1.plotting.setup_mpl(mpl_timedelta_support=True, color_scheme='fastf1')

# Load session
year = 2025
event = "Abu Dhabi"
sessionName = "R"
session = fastf1.get_session(year, event, sessionName)
session.load(telemetry=True, laps=True, weather=True)

# Circuit info
circuit_info = session.get_circuit_info()
# print(circuit_info)

# Pick the fastest lap in the session
fastest_lap = session.laps.pick_fastest()  # FastF1 Laps helper :contentReference[oaicite:0]{index=0}
driver = fastest_lap["Driver"]
style = fastf1.plotting.get_driver_style(identifier=driver,
                                      style=['color', 'linestyle'],
                                      session=session)

# get_weather_data is a Laps method; ensure we call it on a 1-row Laps object
# fastest_lap_laps = session.laps.loc[[fastest_lap.name]]
# w = fastest_lap_laps.get_weather_data().iloc[0]

# print("Fastest lap:", fastest_lap["Driver"], fastest_lap["LapTime"])
# print(f"Wind {w['WindSpeed']:.0f} m/s @ {int(w['WindDirection'])}°")

lap_time = fastest_lap["LapTime"]

# Get car telemetry for that lap (contains Time + Speed among others) :contentReference[oaicite:1]{index=1}
tel = fastest_lap.get_telemetry()
data = {
    "year": year,
    "event": event,
    "session": sessionName,
    "driver": driver,
    "lap_time": fastest_lap["LapTime"].total_seconds(),
    "speed": tel["Speed"].tolist(),
    "throttle": tel["Throttle"].tolist(),
    "brake": tel["Brake"].tolist(),
    "position": {
        "x": tel["X"].tolist(),
        "y": tel["Y"].tolist()
    },
    "time": tel["Time"].dt.total_seconds().tolist()
}
json_str = json.dumps(data)
print(json_str)

# Keep only what we need and drop missing rows
tel = tel[["Time", "Speed"]].dropna()

# Convert lap-relative timedelta to float seconds for plotting
t_seconds = tel["Time"].dt.total_seconds()

# Formatter: seconds -> mm:ss.SSS
def mmss_ms(x, pos=None):
    m = int(x // 60)
    s = x - 60 * m
    return f"{m:02d}:{s:06.3f}"

fig, ax = plt.subplots(figsize=(10, 4))
ax.plot(t_seconds, tel["Speed"], **style, label=driver)

ax.xaxis.set_major_formatter(FuncFormatter(mmss_ms))
ax.set_xlabel("Lap Time (mm:ss.SSS)")
ax.set_ylabel("Speed (km/h)")
ax.set_title(f"Fastest Lap Telemetry — {driver} — LapTime {lap_time}")

ax.grid(True, alpha=0.3)

cursor = Cursor(ax, color='green', linewidth=2, horizOn=False)

#plt.legend()
# plt.show()
