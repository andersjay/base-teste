local cfg = {}

local surgery_male = { model = "mp_m_freemode_01" }
local surgery_female = { model = "mp_f_freemode_01" }

for i=0,19 do
	surgery_female[i] = { 1,0 }
	surgery_male[i] = { 1,0 }
end

cfg.cloakroom_types = {
	["Personagem"] = {
		["Homem"] = surgery_male,
		["Mulher"] = surgery_female
	}
}

cfg.cloakrooms = {
	{ "Personagem",206.82,-1002.02,29.29 }
}

return cfg