local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vSERVER = Tunnel.getInterface("routes")
-------------------------------------------------------------------------------------------------
--[ LOCAL ]--------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
local routes = {
	["hackerspace"] = {
		title = "HACKER", 
		startPoints = {
			{ x = 81.89, y = 87.49, z = 78.61 }
		}
	},
	["weapons"] = {
		title = "ARMAMENTOS", 
		startPoints = {
			{ x = 163.95, y = -1001.58, z = 29.35 }, 
			{ x = 1400.05, y = 1142.81, z = 114.34 }
		}
	},
	["vest"] = {
		title = "COLETE", 
		startPoints = {
			{ x = 965.99, y = -104.29, z = 74.46 }
		}
	},
	["ammo"] = {
		title = "MUNIÇÃO", 
		startPoints = {
			{ x = 2889.29, y = 4420.32, z = 44.99 },
			{ x = -3039.14, y = 86.55, z = 8.73 }
		}
	},
	["wash"] = {
		title = "LAVAGEM", 
		startPoints = {
			{ x = -1066.23, y = -241.28, z = 39.74 },
			{ x = -79.89, y = -807.94, z = 243.39 }
		}
	},
	["weed"] = {
		title = "MACONHA", 
		startPoints = {
			{ x = -1182.73, y = -1786.15, z = 4.38 },
			{ x = -2559.33, y = 2309.09, z = 33.23 },
			{ x = 263.27, y = -3066.25, z = 5.89 },
			{ x = -1573.49, y = -924.48, z = 5.79 },
			{ x = 158.35, y = 6365.08, z = 27.92 },
			{ x = -165.46, y = 3204.77, z = 51.8 }
		}
	},
	["dismantle"] = {
		title = "DESMANCHE", 
		startPoints = {
			{ x = 102.2, y = 6615.34, z = 32.44 }
		}
	},
	["cocaine"] = {
		title = "COCAÍNA", 
		startPoints = {
			{ x = 1143.62, y = -1660.87, z = 36.46 },
			{ x = -1121.09, y = -1553.74, z = 0.99 },
			{ x = 469.7, y = -1741.25, z = 25.55 },
			{ x = 425.58, y = -2050.88, z = 18.75 },
			{ x = 227.18, y = -1756.72, z = 25.24 },
			{ x = 107.59, y = -1994.88, z = 14.89 },
			{ x = -195.94, y = -1701.87, z = 29.39 },
			{ x = 1406.94, y = -1539.44, z = 54.71 },
			{ x = -1001.48, y = -1024.09, z = 2.19 },
			{ x = -1832.61, y = 430.84, z = 118.38 }
		}
	},
	["meth"] = {
		title = "METANFETAMINA", 
		startPoints = {
			{ x = -469.68, y = -1741.16, z = -25.55 }
		}
	},
	["lsd"] = {
		title = "LSD", 
		startPoints = {
			{ x = 1508.39, y = -132.39, z = 181.93 }
		}
	},
	["heroine"] = {
		title = "HEROINE", 
		startPoints = {
			{ x = -165.46, y = -3204.77, z = -51.8 }
		}
	},
	["ecstasy"] = {
		title = "ECSTASY", 
		startPoints = {
			{ x = 848.26, y = 1811.31, z = 147.53 }
		}
	},
	["smuggling"] = {
		title = "SMUGGLING", 
		startPoints = {
			{ x = 2562.92, y = 3866.26, z = 37.33 },
			{ x = -617.07, y = -1622.71, z = 33.02 }
		}
	}
}

local routesPath = {
	["vest"] = {
		[1] = { ['x'] = 746.9, ['y'] = -1399.68, ['z'] = 26.6 },
		[2] = { ['x'] = -156.08, ['y'] = -1348.32, ['z'] = 29.93 },
		[3] = { ['x'] = 124.43, ['y'] = -1488.23, ['z'] = 29.15 },
		[4] = { ['x'] = 151.99, ['y'] = -1823.38, ['z'] = 27.86 },
		[5] = { ['x'] = 783.44, ['y'] = -2254.08, ['z'] = 29.48 },
		[6] = { ['x'] = 978.13, ['y'] = -2227.12, ['z'] = 31.55 },
		[7] = { ['x'] = 1269.84, ['y'] = -1906.81, ['z'] = 39.43 },
		[8] = { ['x'] = 1450.73, ['y'] = -1720.9, ['z'] = 68.7 },
		[9] = { ['x'] = 1145.18, ['y'] = -1008.4, ['z'] = 44.92 },
		[10] = { ['x'] = 1083.62, ['y'] = -351.41, ['z'] = 67.12 },
		[11] = { ['x'] = 1219.31, ['y'] = -1509.53, ['z'] = 34.85 },
		[12] = { ['x'] = 978.12, ['y'] = -1466.21, ['z'] = 31.51 },
		[13] = { ['x'] = 537.49, ['y'] = -1651.63, ['z'] = 29.27 },
		[14] = { ['x'] = 474.66, ['y'] = -1903.56, ['z'] = 25.68 },
		[15] = { ['x'] = 194.87, ['y'] = -1820.45, ['z'] = 28.7 },
		[16] = { ['x'] = -63.97, ['y'] = -1449.62, ['z'] = 32.53 },
		[17] = { ['x'] = 327.11, ['y'] = -1258.57, ['z'] = 32.11 },
		[18] = { ['x'] = -591.58, ['y'] = -1153.58, ['z'] = 22.33 },
		[19] = { ['x'] = -697.35, ['y'] = -675.76, ['z'] = 30.76 },
		[20] = { ['x'] = -582.62, ['y'] = -1743.66, ['z'] = 22.45 },
		[21] = { ['x'] = 95.06, ['y'] = -1809.98, ['z'] = 27.09 },
		[22] = { ['x'] = 446.18, ['y'] = -1235.43, ['z'] = 29.97 },
		[23] = { ['x'] = 334.91, ['y'] = -1094.73, ['z'] = 29.41 },
		[24] = { ['x'] = -1254.78, ['y'] = -671.07, ['z'] = 26.0 },
		[25] = { ['x'] = -1329.65, ['y'] = -580.26, ['z'] = 29.58 },
		[26] = { ['x'] = -1229.27, ['y'] = -1035.65, ['z'] = 8.28 },
		[27] = { ['x'] = -1265.68, ['y'] = -1109.15, ['z'] = 7.75 },
		[28] = { ['x'] = -1235.86, ['y'] = -1237.93, ['z'] = 11.03 },
		[29] = { ['x'] = -1653.02, ['y'] = -371.9, ['z'] = 45.33 },
		[30] = { ['x'] = -1488.28, ['y'] = -325.87, ['z'] = 46.95 }
    },
	["dismantle"] = {
		[1] = { ['x'] = 746.9, ['y'] = -1399.68, ['z'] = 26.6 },
		[2] = { ['x'] = -156.08, ['y'] = -1348.32, ['z'] = 29.93 },
		[3] = { ['x'] = 124.43, ['y'] = -1488.23, ['z'] = 29.15 },
		[4] = { ['x'] = 151.99, ['y'] = -1823.38, ['z'] = 27.86 },
		[5] = { ['x'] = 783.44, ['y'] = -2254.08, ['z'] = 29.48 },
		[6] = { ['x'] = 978.13, ['y'] = -2227.12, ['z'] = 31.55 },
		[7] = { ['x'] = 1269.84, ['y'] = -1906.81, ['z'] = 39.43 },
		[8] = { ['x'] = 1450.73, ['y'] = -1720.9, ['z'] = 68.7 },
		[9] = { ['x'] = 1145.18, ['y'] = -1008.4, ['z'] = 44.92 },
		[10] = { ['x'] = 1083.62, ['y'] = -351.41, ['z'] = 67.12 },
		[11] = { ['x'] = 1219.31, ['y'] = -1509.53, ['z'] = 34.85 },
		[12] = { ['x'] = 978.12, ['y'] = -1466.21, ['z'] = 31.51 },
		[13] = { ['x'] = 537.49, ['y'] = -1651.63, ['z'] = 29.27 },
		[14] = { ['x'] = 474.66, ['y'] = -1903.56, ['z'] = 25.68 },
		[15] = { ['x'] = 194.87, ['y'] = -1820.45, ['z'] = 28.7 },
		[16] = { ['x'] = -63.97, ['y'] = -1449.62, ['z'] = 32.53 },
		[17] = { ['x'] = 327.11, ['y'] = -1258.57, ['z'] = 32.11 },
		[18] = { ['x'] = -591.58, ['y'] = -1153.58, ['z'] = 22.33 },
		[19] = { ['x'] = -697.35, ['y'] = -675.76, ['z'] = 30.76 },
		[20] = { ['x'] = -582.62, ['y'] = -1743.66, ['z'] = 22.45 },
		[21] = { ['x'] = 95.06, ['y'] = -1809.98, ['z'] = 27.09 },
		[22] = { ['x'] = 446.18, ['y'] = -1235.43, ['z'] = 29.97 },
		[23] = { ['x'] = 334.91, ['y'] = -1094.73, ['z'] = 29.41 },
		[24] = { ['x'] = -1254.78, ['y'] = -671.07, ['z'] = 26.0 },
		[25] = { ['x'] = -1329.65, ['y'] = -580.26, ['z'] = 29.58 },
		[26] = { ['x'] = -1229.27, ['y'] = -1035.65, ['z'] = 8.28 },
		[27] = { ['x'] = -1265.68, ['y'] = -1109.15, ['z'] = 7.75 },
		[28] = { ['x'] = -1235.86, ['y'] = -1237.93, ['z'] = 11.03 },
		[29] = { ['x'] = -1653.02, ['y'] = -371.9, ['z'] = 45.33 },
		[30] = { ['x'] = -1488.28, ['y'] = -325.87, ['z'] = 46.95 }
    },
	["smuggling"] = {
		[1] = { ['x'] = 746.9, ['y'] = -1399.68, ['z'] = 26.6 },
		[2] = { ['x'] = -156.08, ['y'] = -1348.32, ['z'] = 29.93 },
		[3] = { ['x'] = 124.43, ['y'] = -1488.23, ['z'] = 29.15 },
		[4] = { ['x'] = 151.99, ['y'] = -1823.38, ['z'] = 27.86 },
		[5] = { ['x'] = 783.44, ['y'] = -2254.08, ['z'] = 29.48 },
		[6] = { ['x'] = 978.13, ['y'] = -2227.12, ['z'] = 31.55 },
		[7] = { ['x'] = 1269.84, ['y'] = -1906.81, ['z'] = 39.43 },
		[8] = { ['x'] = 1450.73, ['y'] = -1720.9, ['z'] = 68.7 },
		[9] = { ['x'] = 1145.18, ['y'] = -1008.4, ['z'] = 44.92 },
		[10] = { ['x'] = 1083.62, ['y'] = -351.41, ['z'] = 67.12 },
		[11] = { ['x'] = 1219.31, ['y'] = -1509.53, ['z'] = 34.85 },
		[12] = { ['x'] = 978.12, ['y'] = -1466.21, ['z'] = 31.51 },
		[13] = { ['x'] = 537.49, ['y'] = -1651.63, ['z'] = 29.27 },
		[14] = { ['x'] = 474.66, ['y'] = -1903.56, ['z'] = 25.68 },
		[15] = { ['x'] = 194.87, ['y'] = -1820.45, ['z'] = 28.7 },
		[16] = { ['x'] = -63.97, ['y'] = -1449.62, ['z'] = 32.53 },
		[17] = { ['x'] = 327.11, ['y'] = -1258.57, ['z'] = 32.11 },
		[18] = { ['x'] = -591.58, ['y'] = -1153.58, ['z'] = 22.33 },
		[19] = { ['x'] = -697.35, ['y'] = -675.76, ['z'] = 30.76 },
		[20] = { ['x'] = -582.62, ['y'] = -1743.66, ['z'] = 22.45 },
		[21] = { ['x'] = 95.06, ['y'] = -1809.98, ['z'] = 27.09 },
		[22] = { ['x'] = 446.18, ['y'] = -1235.43, ['z'] = 29.97 },
		[23] = { ['x'] = 334.91, ['y'] = -1094.73, ['z'] = 29.41 },
		[24] = { ['x'] = -1254.78, ['y'] = -671.07, ['z'] = 26.0 },
		[25] = { ['x'] = -1329.65, ['y'] = -580.26, ['z'] = 29.58 },
		[26] = { ['x'] = -1229.27, ['y'] = -1035.65, ['z'] = 8.28 },
		[27] = { ['x'] = -1265.68, ['y'] = -1109.15, ['z'] = 7.75 },
		[28] = { ['x'] = -1235.86, ['y'] = -1237.93, ['z'] = 11.03 },
		[29] = { ['x'] = -1653.02, ['y'] = -371.9, ['z'] = 45.33 },
		[30] = { ['x'] = -1488.28, ['y'] = -325.87, ['z'] = 46.95 }
    },
	["wash"] = {
		[1] = { ['x'] = 746.9, ['y'] = -1399.68, ['z'] = 26.6 },
		[2] = { ['x'] = -156.08, ['y'] = -1348.32, ['z'] = 29.93 },
		[3] = { ['x'] = 124.43, ['y'] = -1488.23, ['z'] = 29.15 },
		[4] = { ['x'] = 151.99, ['y'] = -1823.38, ['z'] = 27.86 },
		[5] = { ['x'] = 783.44, ['y'] = -2254.08, ['z'] = 29.48 },
		[6] = { ['x'] = 978.13, ['y'] = -2227.12, ['z'] = 31.55 },
		[7] = { ['x'] = 1269.84, ['y'] = -1906.81, ['z'] = 39.43 },
		[8] = { ['x'] = 1450.73, ['y'] = -1720.9, ['z'] = 68.7 },
		[9] = { ['x'] = 1145.18, ['y'] = -1008.4, ['z'] = 44.92 },
		[10] = { ['x'] = 1083.62, ['y'] = -351.41, ['z'] = 67.12 },
		[11] = { ['x'] = 1219.31, ['y'] = -1509.53, ['z'] = 34.85 },
		[12] = { ['x'] = 978.12, ['y'] = -1466.21, ['z'] = 31.51 },
		[13] = { ['x'] = 537.49, ['y'] = -1651.63, ['z'] = 29.27 },
		[14] = { ['x'] = 474.66, ['y'] = -1903.56, ['z'] = 25.68 },
		[15] = { ['x'] = 194.87, ['y'] = -1820.45, ['z'] = 28.7 },
		[16] = { ['x'] = -63.97, ['y'] = -1449.62, ['z'] = 32.53 },
		[17] = { ['x'] = 327.11, ['y'] = -1258.57, ['z'] = 32.11 },
		[18] = { ['x'] = -591.58, ['y'] = -1153.58, ['z'] = 22.33 },
		[19] = { ['x'] = -697.35, ['y'] = -675.76, ['z'] = 30.76 },
		[20] = { ['x'] = -582.62, ['y'] = -1743.66, ['z'] = 22.45 },
		[21] = { ['x'] = 95.06, ['y'] = -1809.98, ['z'] = 27.09 },
		[22] = { ['x'] = 446.18, ['y'] = -1235.43, ['z'] = 29.97 },
		[23] = { ['x'] = 334.91, ['y'] = -1094.73, ['z'] = 29.41 },
		[24] = { ['x'] = -1254.78, ['y'] = -671.07, ['z'] = 26.0 },
		[25] = { ['x'] = -1329.65, ['y'] = -580.26, ['z'] = 29.58 },
		[26] = { ['x'] = -1229.27, ['y'] = -1035.65, ['z'] = 8.28 },
		[27] = { ['x'] = -1265.68, ['y'] = -1109.15, ['z'] = 7.75 },
		[28] = { ['x'] = -1235.86, ['y'] = -1237.93, ['z'] = 11.03 },
		[29] = { ['x'] = -1653.02, ['y'] = -371.9, ['z'] = 45.33 },
		[30] = { ['x'] = -1488.28, ['y'] = -325.87, ['z'] = 46.95 }
    },
	["lsd"] = {
		[1] = { ['x'] = 746.9, ['y'] = -1399.68, ['z'] = 26.6 },
		[2] = { ['x'] = -156.08, ['y'] = -1348.32, ['z'] = 29.93 },
		[3] = { ['x'] = 124.43, ['y'] = -1488.23, ['z'] = 29.15 },
		[4] = { ['x'] = 151.99, ['y'] = -1823.38, ['z'] = 27.86 },
		[5] = { ['x'] = 783.44, ['y'] = -2254.08, ['z'] = 29.48 },
		[6] = { ['x'] = 978.13, ['y'] = -2227.12, ['z'] = 31.55 },
		[7] = { ['x'] = 1269.84, ['y'] = -1906.81, ['z'] = 39.43 },
		[8] = { ['x'] = 1450.73, ['y'] = -1720.9, ['z'] = 68.7 },
		[9] = { ['x'] = 1145.18, ['y'] = -1008.4, ['z'] = 44.92 },
		[10] = { ['x'] = 1083.62, ['y'] = -351.41, ['z'] = 67.12 },
		[11] = { ['x'] = 1219.31, ['y'] = -1509.53, ['z'] = 34.85 },
		[12] = { ['x'] = 978.12, ['y'] = -1466.21, ['z'] = 31.51 },
		[13] = { ['x'] = 537.49, ['y'] = -1651.63, ['z'] = 29.27 },
		[14] = { ['x'] = 474.66, ['y'] = -1903.56, ['z'] = 25.68 },
		[15] = { ['x'] = 194.87, ['y'] = -1820.45, ['z'] = 28.7 },
		[16] = { ['x'] = -63.97, ['y'] = -1449.62, ['z'] = 32.53 },
		[17] = { ['x'] = 327.11, ['y'] = -1258.57, ['z'] = 32.11 },
		[18] = { ['x'] = -591.58, ['y'] = -1153.58, ['z'] = 22.33 },
		[19] = { ['x'] = -697.35, ['y'] = -675.76, ['z'] = 30.76 },
		[20] = { ['x'] = -582.62, ['y'] = -1743.66, ['z'] = 22.45 },
		[21] = { ['x'] = 95.06, ['y'] = -1809.98, ['z'] = 27.09 },
		[22] = { ['x'] = 446.18, ['y'] = -1235.43, ['z'] = 29.97 },
		[23] = { ['x'] = 334.91, ['y'] = -1094.73, ['z'] = 29.41 },
		[24] = { ['x'] = -1254.78, ['y'] = -671.07, ['z'] = 26.0 },
		[25] = { ['x'] = -1329.65, ['y'] = -580.26, ['z'] = 29.58 },
		[26] = { ['x'] = -1229.27, ['y'] = -1035.65, ['z'] = 8.28 },
		[27] = { ['x'] = -1265.68, ['y'] = -1109.15, ['z'] = 7.75 },
		[28] = { ['x'] = -1235.86, ['y'] = -1237.93, ['z'] = 11.03 },
		[29] = { ['x'] = -1653.02, ['y'] = -371.9, ['z'] = 45.33 },
		[30] = { ['x'] = -1488.28, ['y'] = -325.87, ['z'] = 46.95 }
	},
	["heroine"] = {
		[1] = { ['x'] = 746.9, ['y'] = -1399.68, ['z'] = 26.6 },
		[2] = { ['x'] = -156.08, ['y'] = -1348.32, ['z'] = 29.93 },
		[3] = { ['x'] = 124.43, ['y'] = -1488.23, ['z'] = 29.15 },
		[4] = { ['x'] = 151.99, ['y'] = -1823.38, ['z'] = 27.86 },
		[5] = { ['x'] = 783.44, ['y'] = -2254.08, ['z'] = 29.48 },
		[6] = { ['x'] = 978.13, ['y'] = -2227.12, ['z'] = 31.55 },
		[7] = { ['x'] = 1269.84, ['y'] = -1906.81, ['z'] = 39.43 },
		[8] = { ['x'] = 1450.73, ['y'] = -1720.9, ['z'] = 68.7 },
		[9] = { ['x'] = 1145.18, ['y'] = -1008.4, ['z'] = 44.92 },
		[10] = { ['x'] = 1083.62, ['y'] = -351.41, ['z'] = 67.12 },
		[11] = { ['x'] = 1219.31, ['y'] = -1509.53, ['z'] = 34.85 },
		[12] = { ['x'] = 978.12, ['y'] = -1466.21, ['z'] = 31.51 },
		[13] = { ['x'] = 537.49, ['y'] = -1651.63, ['z'] = 29.27 },
		[14] = { ['x'] = 474.66, ['y'] = -1903.56, ['z'] = 25.68 },
		[15] = { ['x'] = 194.87, ['y'] = -1820.45, ['z'] = 28.7 },
		[16] = { ['x'] = -63.97, ['y'] = -1449.62, ['z'] = 32.53 },
		[17] = { ['x'] = 327.11, ['y'] = -1258.57, ['z'] = 32.11 },
		[18] = { ['x'] = -591.58, ['y'] = -1153.58, ['z'] = 22.33 },
		[19] = { ['x'] = -697.35, ['y'] = -675.76, ['z'] = 30.76 },
		[20] = { ['x'] = -582.62, ['y'] = -1743.66, ['z'] = 22.45 },
		[21] = { ['x'] = 95.06, ['y'] = -1809.98, ['z'] = 27.09 },
		[22] = { ['x'] = 446.18, ['y'] = -1235.43, ['z'] = 29.97 },
		[23] = { ['x'] = 334.91, ['y'] = -1094.73, ['z'] = 29.41 },
		[24] = { ['x'] = -1254.78, ['y'] = -671.07, ['z'] = 26.0 },
		[25] = { ['x'] = -1329.65, ['y'] = -580.26, ['z'] = 29.58 },
		[26] = { ['x'] = -1229.27, ['y'] = -1035.65, ['z'] = 8.28 },
		[27] = { ['x'] = -1265.68, ['y'] = -1109.15, ['z'] = 7.75 },
		[28] = { ['x'] = -1235.86, ['y'] = -1237.93, ['z'] = 11.03 },
		[29] = { ['x'] = -1653.02, ['y'] = -371.9, ['z'] = 45.33 },
		[30] = { ['x'] = -1488.28, ['y'] = -325.87, ['z'] = 46.95 }
	},
	["ecstasy"] = {
		[1] = { ['x'] = 746.9, ['y'] = -1399.68, ['z'] = 26.6 },
		[2] = { ['x'] = -156.08, ['y'] = -1348.32, ['z'] = 29.93 },
		[3] = { ['x'] = 124.43, ['y'] = -1488.23, ['z'] = 29.15 },
		[4] = { ['x'] = 151.99, ['y'] = -1823.38, ['z'] = 27.86 },
		[5] = { ['x'] = 783.44, ['y'] = -2254.08, ['z'] = 29.48 },
		[6] = { ['x'] = 978.13, ['y'] = -2227.12, ['z'] = 31.55 },
		[7] = { ['x'] = 1269.84, ['y'] = -1906.81, ['z'] = 39.43 },
		[8] = { ['x'] = 1450.73, ['y'] = -1720.9, ['z'] = 68.7 },
		[9] = { ['x'] = 1145.18, ['y'] = -1008.4, ['z'] = 44.92 },
		[10] = { ['x'] = 1083.62, ['y'] = -351.41, ['z'] = 67.12 },
		[11] = { ['x'] = 1219.31, ['y'] = -1509.53, ['z'] = 34.85 },
		[12] = { ['x'] = 978.12, ['y'] = -1466.21, ['z'] = 31.51 },
		[13] = { ['x'] = 537.49, ['y'] = -1651.63, ['z'] = 29.27 },
		[14] = { ['x'] = 474.66, ['y'] = -1903.56, ['z'] = 25.68 },
		[15] = { ['x'] = 194.87, ['y'] = -1820.45, ['z'] = 28.7 },
		[16] = { ['x'] = -63.97, ['y'] = -1449.62, ['z'] = 32.53 },
		[17] = { ['x'] = 327.11, ['y'] = -1258.57, ['z'] = 32.11 },
		[18] = { ['x'] = -591.58, ['y'] = -1153.58, ['z'] = 22.33 },
		[19] = { ['x'] = -697.35, ['y'] = -675.76, ['z'] = 30.76 },
		[20] = { ['x'] = -582.62, ['y'] = -1743.66, ['z'] = 22.45 },
		[21] = { ['x'] = 95.06, ['y'] = -1809.98, ['z'] = 27.09 },
		[22] = { ['x'] = 446.18, ['y'] = -1235.43, ['z'] = 29.97 },
		[23] = { ['x'] = 334.91, ['y'] = -1094.73, ['z'] = 29.41 },
		[24] = { ['x'] = -1254.78, ['y'] = -671.07, ['z'] = 26.0 },
		[25] = { ['x'] = -1329.65, ['y'] = -580.26, ['z'] = 29.58 },
		[26] = { ['x'] = -1229.27, ['y'] = -1035.65, ['z'] = 8.28 },
		[27] = { ['x'] = -1265.68, ['y'] = -1109.15, ['z'] = 7.75 },
		[28] = { ['x'] = -1235.86, ['y'] = -1237.93, ['z'] = 11.03 },
		[29] = { ['x'] = -1653.02, ['y'] = -371.9, ['z'] = 45.33 },
		[30] = { ['x'] = -1488.28, ['y'] = -325.87, ['z'] = 46.95 }
	},
	["weapons"] = {
		[1] = { ['x'] = 746.9, ['y'] = -1399.68, ['z'] = 26.6 },
		[2] = { ['x'] = -156.08, ['y'] = -1348.32, ['z'] = 29.93 },
		[3] = { ['x'] = 124.43, ['y'] = -1488.23, ['z'] = 29.15 },
		[4] = { ['x'] = 151.99, ['y'] = -1823.38, ['z'] = 27.86 },
		[5] = { ['x'] = 783.44, ['y'] = -2254.08, ['z'] = 29.48 },
		[6] = { ['x'] = 978.13, ['y'] = -2227.12, ['z'] = 31.55 },
		[7] = { ['x'] = 1269.84, ['y'] = -1906.81, ['z'] = 39.43 },
		[8] = { ['x'] = 1450.73, ['y'] = -1720.9, ['z'] = 68.7 },
		[9] = { ['x'] = 1145.18, ['y'] = -1008.4, ['z'] = 44.92 },
		[10] = { ['x'] = 1083.62, ['y'] = -351.41, ['z'] = 67.12 },
		[11] = { ['x'] = 1219.31, ['y'] = -1509.53, ['z'] = 34.85 },
		[12] = { ['x'] = 978.12, ['y'] = -1466.21, ['z'] = 31.51 },
		[13] = { ['x'] = 537.49, ['y'] = -1651.63, ['z'] = 29.27 },
		[14] = { ['x'] = 474.66, ['y'] = -1903.56, ['z'] = 25.68 },
		[15] = { ['x'] = 194.87, ['y'] = -1820.45, ['z'] = 28.7 },
		[16] = { ['x'] = -63.97, ['y'] = -1449.62, ['z'] = 32.53 },
		[17] = { ['x'] = 327.11, ['y'] = -1258.57, ['z'] = 32.11 },
		[18] = { ['x'] = -591.58, ['y'] = -1153.58, ['z'] = 22.33 },
		[19] = { ['x'] = -697.35, ['y'] = -675.76, ['z'] = 30.76 },
		[20] = { ['x'] = -582.62, ['y'] = -1743.66, ['z'] = 22.45 },
		[21] = { ['x'] = 95.06, ['y'] = -1809.98, ['z'] = 27.09 },
		[22] = { ['x'] = 446.18, ['y'] = -1235.43, ['z'] = 29.97 },
		[23] = { ['x'] = 334.91, ['y'] = -1094.73, ['z'] = 29.41 },
		[24] = { ['x'] = -1254.78, ['y'] = -671.07, ['z'] = 26.0 },
		[25] = { ['x'] = -1329.65, ['y'] = -580.26, ['z'] = 29.58 },
		[26] = { ['x'] = -1229.27, ['y'] = -1035.65, ['z'] = 8.28 },
		[27] = { ['x'] = -1265.68, ['y'] = -1109.15, ['z'] = 7.75 },
		[28] = { ['x'] = -1235.86, ['y'] = -1237.93, ['z'] = 11.03 },
		[29] = { ['x'] = -1653.02, ['y'] = -371.9, ['z'] = 45.33 },
		[30] = { ['x'] = -1488.28, ['y'] = -325.87, ['z'] = 46.95 }
	},
	["cocaine"] = {
		[1] = { ['x'] = 746.9, ['y'] = -1399.68, ['z'] = 26.6 },
		[2] = { ['x'] = -156.08, ['y'] = -1348.32, ['z'] = 29.93 },
		[3] = { ['x'] = 124.43, ['y'] = -1488.23, ['z'] = 29.15 },
		[4] = { ['x'] = 151.99, ['y'] = -1823.38, ['z'] = 27.86 },
		[5] = { ['x'] = 783.44, ['y'] = -2254.08, ['z'] = 29.48 },
		[6] = { ['x'] = 978.13, ['y'] = -2227.12, ['z'] = 31.55 },
		[7] = { ['x'] = 1269.84, ['y'] = -1906.81, ['z'] = 39.43 },
		[8] = { ['x'] = 1450.73, ['y'] = -1720.9, ['z'] = 68.7 },
		[9] = { ['x'] = 1145.18, ['y'] = -1008.4, ['z'] = 44.92 },
		[10] = { ['x'] = 1083.62, ['y'] = -351.41, ['z'] = 67.12 },
		[11] = { ['x'] = 1219.31, ['y'] = -1509.53, ['z'] = 34.85 },
		[12] = { ['x'] = 978.12, ['y'] = -1466.21, ['z'] = 31.51 },
		[13] = { ['x'] = 537.49, ['y'] = -1651.63, ['z'] = 29.27 },
		[14] = { ['x'] = 474.66, ['y'] = -1903.56, ['z'] = 25.68 },
		[15] = { ['x'] = 194.87, ['y'] = -1820.45, ['z'] = 28.7 },
		[16] = { ['x'] = -63.97, ['y'] = -1449.62, ['z'] = 32.53 },
		[17] = { ['x'] = 327.11, ['y'] = -1258.57, ['z'] = 32.11 },
		[18] = { ['x'] = -591.58, ['y'] = -1153.58, ['z'] = 22.33 },
		[19] = { ['x'] = -697.35, ['y'] = -675.76, ['z'] = 30.76 },
		[20] = { ['x'] = -582.62, ['y'] = -1743.66, ['z'] = 22.45 },
		[21] = { ['x'] = 95.06, ['y'] = -1809.98, ['z'] = 27.09 },
		[22] = { ['x'] = 446.18, ['y'] = -1235.43, ['z'] = 29.97 },
		[23] = { ['x'] = 334.91, ['y'] = -1094.73, ['z'] = 29.41 },
		[24] = { ['x'] = -1254.78, ['y'] = -671.07, ['z'] = 26.0 },
		[25] = { ['x'] = -1329.65, ['y'] = -580.26, ['z'] = 29.58 },
		[26] = { ['x'] = -1229.27, ['y'] = -1035.65, ['z'] = 8.28 },
		[27] = { ['x'] = -1265.68, ['y'] = -1109.15, ['z'] = 7.75 },
		[28] = { ['x'] = -1235.86, ['y'] = -1237.93, ['z'] = 11.03 },
		[29] = { ['x'] = -1653.02, ['y'] = -371.9, ['z'] = 45.33 },
		[30] = { ['x'] = -1488.28, ['y'] = -325.87, ['z'] = 46.95 }
	},
	["weed"] = {
		[1] = { ['x'] = 746.9, ['y'] = -1399.68, ['z'] = 26.6 },
		[2] = { ['x'] = -156.08, ['y'] = -1348.32, ['z'] = 29.93 },
		[3] = { ['x'] = 124.43, ['y'] = -1488.23, ['z'] = 29.15 },
		[4] = { ['x'] = 151.99, ['y'] = -1823.38, ['z'] = 27.86 },
		[5] = { ['x'] = 783.44, ['y'] = -2254.08, ['z'] = 29.48 },
		[6] = { ['x'] = 978.13, ['y'] = -2227.12, ['z'] = 31.55 },
		[7] = { ['x'] = 1269.84, ['y'] = -1906.81, ['z'] = 39.43 },
		[8] = { ['x'] = 1450.73, ['y'] = -1720.9, ['z'] = 68.7 },
		[9] = { ['x'] = 1145.18, ['y'] = -1008.4, ['z'] = 44.92 },
		[10] = { ['x'] = 1083.62, ['y'] = -351.41, ['z'] = 67.12 },
		[11] = { ['x'] = 1219.31, ['y'] = -1509.53, ['z'] = 34.85 },
		[12] = { ['x'] = 978.12, ['y'] = -1466.21, ['z'] = 31.51 },
		[13] = { ['x'] = 537.49, ['y'] = -1651.63, ['z'] = 29.27 },
		[14] = { ['x'] = 474.66, ['y'] = -1903.56, ['z'] = 25.68 },
		[15] = { ['x'] = 194.87, ['y'] = -1820.45, ['z'] = 28.7 },
		[16] = { ['x'] = -63.97, ['y'] = -1449.62, ['z'] = 32.53 },
		[17] = { ['x'] = 327.11, ['y'] = -1258.57, ['z'] = 32.11 },
		[18] = { ['x'] = -591.58, ['y'] = -1153.58, ['z'] = 22.33 },
		[19] = { ['x'] = -697.35, ['y'] = -675.76, ['z'] = 30.76 },
		[20] = { ['x'] = -582.62, ['y'] = -1743.66, ['z'] = 22.45 },
		[21] = { ['x'] = 95.06, ['y'] = -1809.98, ['z'] = 27.09 },
		[22] = { ['x'] = 446.18, ['y'] = -1235.43, ['z'] = 29.97 },
		[23] = { ['x'] = 334.91, ['y'] = -1094.73, ['z'] = 29.41 },
		[24] = { ['x'] = -1254.78, ['y'] = -671.07, ['z'] = 26.0 },
		[25] = { ['x'] = -1329.65, ['y'] = -580.26, ['z'] = 29.58 },
		[26] = { ['x'] = -1229.27, ['y'] = -1035.65, ['z'] = 8.28 },
		[27] = { ['x'] = -1265.68, ['y'] = -1109.15, ['z'] = 7.75 },
		[28] = { ['x'] = -1235.86, ['y'] = -1237.93, ['z'] = 11.03 },
		[29] = { ['x'] = -1653.02, ['y'] = -371.9, ['z'] = 45.33 },
		[30] = { ['x'] = -1488.28, ['y'] = -325.87, ['z'] = 46.95 }
	},
	["ammo"] = {
		[1] = { ['x'] = 746.9, ['y'] = -1399.68, ['z'] = 26.6 },
		[2] = { ['x'] = -156.08, ['y'] = -1348.32, ['z'] = 29.93 },
		[3] = { ['x'] = 124.43, ['y'] = -1488.23, ['z'] = 29.15 },
		[4] = { ['x'] = 151.99, ['y'] = -1823.38, ['z'] = 27.86 },
		[5] = { ['x'] = 783.44, ['y'] = -2254.08, ['z'] = 29.48 },
		[6] = { ['x'] = 978.13, ['y'] = -2227.12, ['z'] = 31.55 },
		[7] = { ['x'] = 1269.84, ['y'] = -1906.81, ['z'] = 39.43 },
		[8] = { ['x'] = 1450.73, ['y'] = -1720.9, ['z'] = 68.7 },
		[9] = { ['x'] = 1145.18, ['y'] = -1008.4, ['z'] = 44.92 },
		[10] = { ['x'] = 1083.62, ['y'] = -351.41, ['z'] = 67.12 },
		[11] = { ['x'] = 1219.31, ['y'] = -1509.53, ['z'] = 34.85 },
		[12] = { ['x'] = 978.12, ['y'] = -1466.21, ['z'] = 31.51 },
		[13] = { ['x'] = 537.49, ['y'] = -1651.63, ['z'] = 29.27 },
		[14] = { ['x'] = 474.66, ['y'] = -1903.56, ['z'] = 25.68 },
		[15] = { ['x'] = 194.87, ['y'] = -1820.45, ['z'] = 28.7 },
		[16] = { ['x'] = -63.97, ['y'] = -1449.62, ['z'] = 32.53 },
		[17] = { ['x'] = 327.11, ['y'] = -1258.57, ['z'] = 32.11 },
		[18] = { ['x'] = -591.58, ['y'] = -1153.58, ['z'] = 22.33 },
		[19] = { ['x'] = -697.35, ['y'] = -675.76, ['z'] = 30.76 },
		[20] = { ['x'] = -582.62, ['y'] = -1743.66, ['z'] = 22.45 },
		[21] = { ['x'] = 95.06, ['y'] = -1809.98, ['z'] = 27.09 },
		[22] = { ['x'] = 446.18, ['y'] = -1235.43, ['z'] = 29.97 },
		[23] = { ['x'] = 334.91, ['y'] = -1094.73, ['z'] = 29.41 },
		[24] = { ['x'] = -1254.78, ['y'] = -671.07, ['z'] = 26.0 },
		[25] = { ['x'] = -1329.65, ['y'] = -580.26, ['z'] = 29.58 },
		[26] = { ['x'] = -1229.27, ['y'] = -1035.65, ['z'] = 8.28 },
		[27] = { ['x'] = -1265.68, ['y'] = -1109.15, ['z'] = 7.75 },
		[28] = { ['x'] = -1235.86, ['y'] = -1237.93, ['z'] = 11.03 },
		[29] = { ['x'] = -1653.02, ['y'] = -371.9, ['z'] = 45.33 },
		[30] = { ['x'] = -1488.28, ['y'] = -325.87, ['z'] = 46.95 }
	},
	["meth"] = {
		[1] = { ['x'] = 746.9, ['y'] = -1399.68, ['z'] = 26.6 },
		[2] = { ['x'] = -156.08, ['y'] = -1348.32, ['z'] = 29.93 },
		[3] = { ['x'] = 124.43, ['y'] = -1488.23, ['z'] = 29.15 },
		[4] = { ['x'] = 151.99, ['y'] = -1823.38, ['z'] = 27.86 },
		[5] = { ['x'] = 783.44, ['y'] = -2254.08, ['z'] = 29.48 },
		[6] = { ['x'] = 978.13, ['y'] = -2227.12, ['z'] = 31.55 },
		[7] = { ['x'] = 1269.84, ['y'] = -1906.81, ['z'] = 39.43 },
		[8] = { ['x'] = 1450.73, ['y'] = -1720.9, ['z'] = 68.7 },
		[9] = { ['x'] = 1145.18, ['y'] = -1008.4, ['z'] = 44.92 },
		[10] = { ['x'] = 1083.62, ['y'] = -351.41, ['z'] = 67.12 },
		[11] = { ['x'] = 1219.31, ['y'] = -1509.53, ['z'] = 34.85 },
		[12] = { ['x'] = 978.12, ['y'] = -1466.21, ['z'] = 31.51 },
		[13] = { ['x'] = 537.49, ['y'] = -1651.63, ['z'] = 29.27 },
		[14] = { ['x'] = 474.66, ['y'] = -1903.56, ['z'] = 25.68 },
		[15] = { ['x'] = 194.87, ['y'] = -1820.45, ['z'] = 28.7 },
		[16] = { ['x'] = -63.97, ['y'] = -1449.62, ['z'] = 32.53 },
		[17] = { ['x'] = 327.11, ['y'] = -1258.57, ['z'] = 32.11 },
		[18] = { ['x'] = -591.58, ['y'] = -1153.58, ['z'] = 22.33 },
		[19] = { ['x'] = -697.35, ['y'] = -675.76, ['z'] = 30.76 },
		[20] = { ['x'] = -582.62, ['y'] = -1743.66, ['z'] = 22.45 },
		[21] = { ['x'] = 95.06, ['y'] = -1809.98, ['z'] = 27.09 },
		[22] = { ['x'] = 446.18, ['y'] = -1235.43, ['z'] = 29.97 },
		[23] = { ['x'] = 334.91, ['y'] = -1094.73, ['z'] = 29.41 },
		[24] = { ['x'] = -1254.78, ['y'] = -671.07, ['z'] = 26.0 },
		[25] = { ['x'] = -1329.65, ['y'] = -580.26, ['z'] = 29.58 },
		[26] = { ['x'] = -1229.27, ['y'] = -1035.65, ['z'] = 8.28 },
		[27] = { ['x'] = -1265.68, ['y'] = -1109.15, ['z'] = 7.75 },
		[28] = { ['x'] = -1235.86, ['y'] = -1237.93, ['z'] = 11.03 },
		[29] = { ['x'] = -1653.02, ['y'] = -371.9, ['z'] = 45.33 },
		[30] = { ['x'] = -1488.28, ['y'] = -325.87, ['z'] = 46.95 }
	},
	["hackerspace"] = {
		[1] = { ['x'] = 746.9, ['y'] = -1399.68, ['z'] = 26.6 },
		[2] = { ['x'] = -156.08, ['y'] = -1348.32, ['z'] = 29.93 },
		[3] = { ['x'] = 124.43, ['y'] = -1488.23, ['z'] = 29.15 },
		[4] = { ['x'] = 151.99, ['y'] = -1823.38, ['z'] = 27.86 },
		[5] = { ['x'] = 783.44, ['y'] = -2254.08, ['z'] = 29.48 },
		[6] = { ['x'] = 978.13, ['y'] = -2227.12, ['z'] = 31.55 },
		[7] = { ['x'] = 1269.84, ['y'] = -1906.81, ['z'] = 39.43 },
		[8] = { ['x'] = 1450.73, ['y'] = -1720.9, ['z'] = 68.7 },
		[9] = { ['x'] = 1145.18, ['y'] = -1008.4, ['z'] = 44.92 },
		[10] = { ['x'] = 1083.62, ['y'] = -351.41, ['z'] = 67.12 },
		[11] = { ['x'] = 1219.31, ['y'] = -1509.53, ['z'] = 34.85 },
		[12] = { ['x'] = 978.12, ['y'] = -1466.21, ['z'] = 31.51 },
		[13] = { ['x'] = 537.49, ['y'] = -1651.63, ['z'] = 29.27 },
		[14] = { ['x'] = 474.66, ['y'] = -1903.56, ['z'] = 25.68 },
		[15] = { ['x'] = 194.87, ['y'] = -1820.45, ['z'] = 28.7 },
		[16] = { ['x'] = -63.97, ['y'] = -1449.62, ['z'] = 32.53 },
		[17] = { ['x'] = 327.11, ['y'] = -1258.57, ['z'] = 32.11 },
		[18] = { ['x'] = -591.58, ['y'] = -1153.58, ['z'] = 22.33 },
		[19] = { ['x'] = -697.35, ['y'] = -675.76, ['z'] = 30.76 },
		[20] = { ['x'] = -582.62, ['y'] = -1743.66, ['z'] = 22.45 },
		[21] = { ['x'] = 95.06, ['y'] = -1809.98, ['z'] = 27.09 },
		[22] = { ['x'] = 446.18, ['y'] = -1235.43, ['z'] = 29.97 },
		[23] = { ['x'] = 334.91, ['y'] = -1094.73, ['z'] = 29.41 },
		[24] = { ['x'] = -1254.78, ['y'] = -671.07, ['z'] = 26.0 },
		[25] = { ['x'] = -1329.65, ['y'] = -580.26, ['z'] = 29.58 },
		[26] = { ['x'] = -1229.27, ['y'] = -1035.65, ['z'] = 8.28 },
		[27] = { ['x'] = -1265.68, ['y'] = -1109.15, ['z'] = 7.75 },
		[28] = { ['x'] = -1235.86, ['y'] = -1237.93, ['z'] = 11.03 },
		[29] = { ['x'] = -1653.02, ['y'] = -371.9, ['z'] = 45.33 },
		[30] = { ['x'] = -1488.28, ['y'] = -325.87, ['z'] = 46.95 }
	}
}

local currentRoute = nil
local currentBlip = nil
local position = 0
local currentPathPosition = 1
-------------------------------------------------------------------------------------------------
--[ MENU ]---------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
local menuactive = false

function ToggleActionMenu()
	menuactive = not menuactive
    if menuactive then
		SetNuiFocus(true,true)
		SendNUIMessage({ action = "open", title = "Rotas para "..routes[currentRoute].title, items = vSERVER.getItems(currentRoute) })
    else
		SetNuiFocus(false)
		SendNUIMessage({ action = "exit" })
	end
end
-------------------------------------------------------------------------------------------------
--[ BOTÕES ]-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
RegisterNUICallback("selectRoute", function(data,cb)
    if data.code then
			position = data.code
	    TriggerServerEvent("routes:selectRoute", currentRoute, data.code)
    end
end)

RegisterNUICallback("exit", function(data,cb)
    ToggleActionMenu()
end)

RegisterNetEvent("routes:exit")
AddEventHandler("routes:exit", function()
	ToggleActionMenu()
end)

RegisterNetEvent("routes:startRoute")
AddEventHandler("routes:startRoute", function(route, item)
    if currentBlip then
			RemoveBlip(currentBlip)
	end

	currentRoute = route
	currentPathPosition = 1
    createBlip(routes[currentRoute].title, routesPath[currentRoute][currentPathPosition])
	TriggerEvent("Notify","default","Iniciando rota de <b>"..item.."</b>.",5000)
end)
-------------------------------------------------------------------------------------------------
--[ AÇÃO ]---------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local AE = 500

		for routeCode, route in pairs(routes) do
			for k, v in pairs(route.startPoints) do
				local ped = PlayerPedId()
				local x,y,z = table.unpack(GetEntityCoords(ped))
				local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
				local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
				AE = 4
				if distance <= 1.5 then
					DrawText3D(v.x, v.y, v.z, "~p~E~w~   ABRIR")
					if IsControlJustPressed(0,38) then
						if vSERVER.checkPermission(routeCode) then
							currentRoute = routeCode
							ToggleActionMenu()
						end
					end
				end
			end
		end
        
		Citizen.Wait(AE)
	end
end)

Citizen.CreateThread(function()
	while true do
		local AE = 500

		if currentRoute then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local distance = GetDistanceBetweenCoords(routesPath[currentRoute][currentPathPosition].x,routesPath[currentRoute][currentPathPosition].y,routesPath[currentRoute][currentPathPosition].z,x,y,z,true)

			AE = 4
			if distance <= 1.5 then
				DrawText3D(routesPath[currentRoute][currentPathPosition].x,routesPath[currentRoute][currentPathPosition].y,routesPath[currentRoute][currentPathPosition].z, "~p~E~w~   COLETAR")
				
				if not IsPedInAnyVehicle(ped) then
					if IsControlJustPressed(0,38) then
						vSERVER.checkPayment(currentRoute, position)
												
						RemoveBlip(currentBlip)
						currentPathPosition = currentPathPosition + 1

						if currentPathPosition > 30 then
							currentPathPosition = 1
						end

						createBlip(routes[currentRoute].title, routesPath[currentRoute][currentPathPosition])
					end
				end
			end
		end

		Citizen.Wait(AE)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if currentRoute then
			if IsControlJustPressed(0, 168) then
				currentRoute = nil
				currentPathPosition = 1
				RemoveBlip(currentBlip)
				TriggerServerEvent("routes:endRoute")
				TriggerEvent("Notify","default","Rota encerrada",10000)
			end
		end
	end
end)
-------------------------------------------------------------------------------------------------
--[ FUNÇÃO ]-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
function DrawText3D(x,y,z,text)
	SetTextFont(4)
	SetTextCentre(1)
	SetTextEntry("STRING")
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,150)
	AddTextComponentString(text)
	SetDrawOrigin(x,y,z,0)
	DrawText(0.0,0.0)
	local factor = (string.len(text) / 450) + 0.01
	DrawRect(0.0,0.0125,factor,0.03,40,36,52,240)
	ClearDrawOrigin()
end

function createBlip(name, pos)
	currentBlip = AddBlipForCoord(pos.x, pos.y, pos.z)
	SetBlipSprite(currentBlip,12)
	SetBlipColour(currentBlip,27)
	SetBlipScale(currentBlip,0.9)
	SetBlipAsShortRange(currentBlip,false)
	SetBlipRoute(currentBlip,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Rotas de "..name)
	EndTextCommandSetBlipName(currentBlip)
end