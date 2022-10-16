local cfg = {}

cfg.groups = {
	["Owner"] = {
		"owner.permissao",
		"admin.permissao",
		"mod.permissao",
		"suporte.permissao",
		"polpar.permissao",
		"staff.permissao",
		"weapons.permissao"
		
	},
	["Admin"] = {
		"admin.permissao",
		"mod.permissao",
		"suporte.permissao",
		"polpar.permissao",
		"staff.permissao"
	},
	["Mod"] = {
		"mod.permissao",
		"suporte.permissao",
		"polpar.permissao",
		"staff.permissao",
		"chamado.staff"
	},
	["Suporte"] = {
		"suporte.permissao",
		"staff.permissao"
	},
	
	----- VIPS -----
	
	["Platina"] = {
		_config = {
			title = "Platina",
			gtype = "vip"
		},
		"platina.permissao",
		"mochila.permissao"
	},
	["Ouro"] = {
		_config = {
			title = "Ouro",
			gtype = "vip"
		},
		"ouro.permissao",
		"mochila.permissao"
	},
	["Prata"] = {
		_config = {
			title = "Prata",
			gtype = "vip"
		},
		"prata.permissao"
	},
	["Bronze"] = {
		_config = {
			title = "Bronze",
			gtype = "vip"
		},
		"bronze.permissao"
	},
	
	----- Jurídico -----
	
	["Juiz"] = {
		_config = {
			title = "Juiz",
			gtype = "job"
		},
		"juiz.permissao"
	},
	["Advogado"] = {
		_config = {
			title = "Advogado",
			gtype = "job"
		},
		"advogado.permissao"
	},
	
	----- Policia -----
	
	["Policia3"] = {
		_config = {
			title = "Policia-3",
			gtype = "job"
		},
		"policia.permissao",
		"policia3.permissao",
		"polpar.permissao"
	},
	["Policia3-ForaDeServico"] = {
		_config = {
			title = "Policia-3: Fora de Serviço",
			gtype = "job"
		},
		"policia3-foradeservico.permissao"
	},
	
	["Policia2"] = {
		_config = {
			title = "Policia-2",
			gtype = "job"
		},
		"policia.permissao",
		"policia2.permissao",
		"polpar.permissao"
	},
	["Policia2-ForaDeServico"] = {
		_config = {
			title = "Policia-2: Fora de Serviço",
			gtype = "job"
		},
		"policia2-foradeservico.permissao"
	},
	
	["Policia1"] = {
		_config = {
			title = "Policia-1",
			gtype = "job"
		},
		"policia.permissao",
		"policia1.permissao",
		"polpar.permissao"
	},
	["Policia1-ForaDeServico"] = {
		_config = {
			title = "Policia-1: Fora de Serviço",
			gtype = "job"
		},
		"policia1-foradeservico.permissao"
	},
	
	----- Hospital -----
	
	["Paramedico3"] = {
		_config = {
			title = "Paramédico-3",
			gtype = "job"
		},
		"paramedico.permissao",
		"paramedico3.permissao",
		"polpar.permissao"
	},
	["Paramedico3-ForaDeServico"] = {
		_config = {
			title = "Paramédico-3: Fora de Serviço",
			gtype = "job"
		},
		"paramedico3-foradeservico.permissao"
	},
	["Paramedico2"] = {
		_config = {
			title = "Paramédico-2",
			gtype = "job"
		},
		"paramedico.permissao",
		"paramedico2.permissao",
		"polpar.permissao"
	},
	["Paramedico2-ForaDeServico"] = {
		_config = {
			title = "Paramédico-2: Fora de Serviço",
			gtype = "job"
		},
		"paramedico2-foradeservico.permissao"
	},
	["Paramedico1"] = {
		_config = {
			title = "Paramédico-1",
			gtype = "job"
		},
		"paramedico.permissao",
		"paramedico1.permissao",
		"polpar.permissao"
	},
	["Paramedico1-ForaDeServico"] = {
		_config = {
			title = "Paramédico-1: Fora de Serviço",
			gtype = "job"
		},
		"paramedico1-foradeservico.permissao"
	},
	
	----- Mecânico -----
	
	["Mecanico3"] = {
		_config = {
			title = "Mecânico-3",
			gtype = "job"
		},
		"mecanico.permissao",
		"mecanico3.permissao"
	},
	["Mecanico3-ForaDeServico"] = {
		_config = {
			title = "Mecânico-3: Fora de Serviço",
			gtype = "job"
		},
		"mecanico3-foradeservico.permissao"
	},
	["Mecanico2"] = {
		_config = {
			title = "Mecânico-2",
			gtype = "job"
		},
		"mecanico.permissao",
		"mecanico2.permissao"
	},
	["Mecanico2-ForaDeServico"] = {
		_config = {
			title = "Mecânico-2: Fora de Serviço",
			gtype = "job"
		},
		"mecanico2-foradeservico.permissao"
	},
	["Mecanico1"] = {
		_config = {
			title = "Mecânico-1",
			gtype = "job"
		},
		"mecanico.permissao",
		"mecanico1.permissao"
	},
	["Mecanico1-ForaDeServico"] = {
		_config = {
			title = "Mecânico-1: Fora de Serviço",
			gtype = "job"
		},
		"mecanico1-foradeservico.permissao"
	},
	
	----- Ilegal | Drogas -----
	
	["Grove"] = {
		_config = {
			title = "Grove",
			gtype = "job"
		},
		"grove.permissao"
	},
	["Ballas"] = {
		_config = {
			title = "Ballas",
			gtype = "job"
		},
		"ballas.permissao"
	},
	["Vagos"] = {
		_config = {
			title = "Vagos",
			gtype = "job"
		},
		"vagos.permissao"
	},
	
	----- Ilegal | Armamentos & Munições -----
	
	["Bratva"] = {
		_config = {
			title = "Bratva",
			gtype = "job"
		},
		"bratva.permissao"
	},
	["CosaNostra"] = {
		_config = {
			title = "CosaNostra",
			gtype = "job"
		},
		"cosanostra.permissao"
	},
	
	----- Ilegal | Desmanche & Corridas Ilegais -----
	
	["TheLost"] = {
		_config = {
			title = "TheLost",
			gtype = "job"
		},
		"thelost.permissao",
		"corridas.ilegal"
	},
	["Corredores"] = {
		_config = {
			title = "Corredores",
			gtype = "job"
		},
		"corredores.permissao",
		"corridas.ilegal"
	},
	
	----- Ilegal | Lavagem de dinheiro sujo -----
	
	["Tequila"] = {
		_config = {
			title = "Tequi-la-la",
			gtype = "job"
		},
		"tequila.permissao",
		"tequila.lavagem"
	},
	["Vanilla"] = {
		_config = {
			title = "Vanilla",
			gtype = "job"
		},
		"vanilla.permissao",
		"vanilla.lavagem"
	},
}

cfg.users = {
	[1] = { "Owner" }
}

cfg.selectors = {}

return cfg