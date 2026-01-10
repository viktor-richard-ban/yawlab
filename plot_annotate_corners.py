"""Draw a track map
=========================================

Use the position data of a single lap to draw a track map.
"""
##############################################################################
# Import FastF1 and load the data. Use the telemetry from the fastest for the
# track map. (You could also use any other lap instead.)

import matplotlib.pyplot as plt
import numpy as np

import fastf1


session = fastf1.get_session(2025, 'Abu Dhabi', 'R')
session.load()

lap = session.laps.pick_fastest()
pos = lap.get_pos_data()

circuit_info = session.get_circuit_info()

track = pos.loc[:, ('X', 'Y')].to_numpy()
print(track)
plt.plot(track[:, 0], track[:, 1])
plt.axis('equal')
plt.show()
