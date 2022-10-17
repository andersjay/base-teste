local cfg = {}

cfg.groups = {
	["Owner"] = {
		"owner.permissao",
		"admin.permissao",
		"mod.permissao",
		"suporte.permissao",
		"polpar.permissao",
		"staff.permissao",

		
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

	----- Orgs -----
	["Armas"] = {
		_config = {
			title = "Armas",
			gtype = "job"
		},
		"weapons.permissao"
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
	
	['lidercv'] = { -- maconha 
		_config = {
			title = 'Chefe C.V',
			gtype = 'job'
		},
		-- 'vermelhos.permissao',  
		-- 'turquia.permissao',
		-- 'lidervermelhos.permissao',
		'ilegal.permissao',
		'cvlider.permissao',
		'cv.permissao',
		'contratar.permissao',
		'weed.permissao'
	},
	['cv'] = {
		_config = {
			title = 'Membro C.V',
			gtype = 'job'
		},
		-- 'turquia.permissao'
		'ilegal.permissao',
		'cv.permissao',
		'weed.permissao'
	},

	['pcc-lider'] = { -- ecstasy 
	    _config = {
		    title = 'Chefe P.C.C',
		    gtype = 'job'
	    },
	    -- 'cinza.permissao',
	    'ilegal.permissao',
		'pcclider.permissao',
	    'pcc.permissao',
        'contratar.permissao',
		'ecstasy.permissao'
    },
	['pcc'] = {
	    _config = {
		    title = 'Membro P.C.C',
		    gtype = 'job'
	    },
	    -- 'cinza.permissao',
	    'ilegal.permissao',
	    'pcc.permissao',
		'ecstasy.permissao'
    },

	['tcp-lider'] = { -- lsd
	    _config = {
		    title = 'Chefe T.C.P',
		    gtype = 'job'
	    },
	    -- 'roxos.permissao',
	    'ilegal.permissao',
		'tcplider.permissao',
	    'tcp.permissao',
	    'contratar.permissao',
		'lsd.permissao'
	},
	['tcp'] = {
	    _config = {
		    title = 'Membro T.C.P',
		    gtype = 'job'
	    },
	    -- 'roxos.permissao'
	    'ilegal.permissao',
	    'tcp.permissao',
		'lsd.permissao'
	},

	['ada-lider'] = { -- cocaína
	    _config = {
		    title = 'Chefe A.D.A',
		    gtype = 'job'
	    },
		-- 'verdes.permissao',
		-- 'israel.permissao',
	    'ilegal.permissao',
		'adalider.permissao',
	    'ada.permissao',
	    'contratar.permissao',
		'cocaine.permissao'
    },
	['ada'] = {
		_config = {
			title = 'Membro A.D.A',
			gtype = 'job'
		},
		-- 'verdes.permissao',
		-- 'israel.permissao',
		'ilegal.permissao',
		'ada.permissao',
		'cocaine.permissao'
	},

	['cartel-lider'] = { -- metanfetamina
	    _config = {
		    title = 'Chefe Cartel',
		    gtype = 'job'
	    },
		-- 'azul.permissao',
	    'ilegal.permissao',
		'cartellider.permissao',
		'cartel.permissao',
	    'contratar.permissao',
		'meth.permissao'
    },
	['cartel'] = {
		_config = {
			title = 'Membro Cartel',
			gtype = 'job'
		},
		-- 'azul.permissao',
		'ilegal.permissao',
		'cartel.permissao',
		'meth.permissao'
	},
	
	----- Ilegal | Armamentos & Munições -----
	
	['milicia-lider'] = { -- armas
	_config = {
		title = 'Chefe Milícia',
		gtype = 'job'
	},
	'ilegal.permissao',
	'milicialider.permissao',
	'milicia.permissao',
	'contratar.permissao',
	'weapons.permissao'
    },
	['milicia'] = {
		_config = {
			title = 'Membro Milícia',
			gtype = 'job'
		},
		'ilegal.permissao',
		'milicia.permissao',
		'weapons.permissao'
	},

	['Yakuza-lider'] = { -- armas
	    _config = {
		    title = 'Chefe Yakuza',
		    gtype = 'job'
	    },
	    'ilegal.permissao',
	    'yakuzalider.permissao',
	    'yakuza.permissao',
		'contratar.permissao',
	    'weapons.permissao'
    },
	['Yakuza'] = {
		_config = {
			title = 'Membro Yakuza',
			gtype = 'job'
		},
		'ilegal.permissao',
		'yakuza.permissao',
		'weapons.permissao'
	},

	['canada-lider'] = { -- munição
	    _config = {
		    title = 'Chefe T.D.C',
		    gtype = 'job'
	    },
		-- 'lockpick.permissao',
	    -- 'ballas.permissao',
	    'ilegal.permissao',
		'canadalider.permissao',
	    'canada.permissao',
	    'contratar.permissao',
	    'ammo.permissao'
    },
	['canada'] = { 
		_config = {
			title = 'Membro T.D.C',
			gtype = 'job'
		},
		-- 'ballas.permissao',
		-- 'lockpick.permissao',
		'ilegal.permissao',
		'canada.permissao',
		'ammo.permissao'
	},

	['Motoclub-lider'] = { -- munição
		_config = {
			title = 'Chefe Motoclub',
			gtype = 'job'
		},
		-- 'lockpick.permissao',
		-- 'groove.permissao',
		'ilegal.permissao',
		'motoclublider.permissao',
		'motoclub.permissao',
		'contratar.permissao',
		'ammo.permissao'
	},
	['Motoclub'] = {
		_config = {
			title = 'Membro Motoclub',
			gtype = 'job'
		},
		-- 'lockpick.permissao',
		-- 'groove.permissao',
		'ilegal.permissao',
		'motoclub.permissao',
		'ammo.permissao'
	},
	
	----- Ilegal | Desmanche & Itens ilegais -----

	['furious-lider'] = { -- desmanche
	    _config = {
		    title = 'Chefe Furious',
		    gtype = 'job'
	    },
	    'ilegal.permissao',
	    'furiouslider.permissao',
	    'furious.permissao',
	    'contratar.permissao',
	    'desmanche.permissao'
    },
	['furious'] = {
		_config = {
			title = 'Membro Furious',
			gtype = 'job'
		},
		'ilegal.permissao',
		'furious.permissao',
		'desmanche.permissao'
	},

	['dk-lider'] = { -- desmanche
	    _config = {
		    title = 'Chefe Drift King',
		    gtype = 'job'
	    },
	    'ilegal.permissao',
	    'dklider.permissao',
	    'dk.permissao',
		'contratar.permissao',
		'desmanche.permissao'
    },
	['dk'] = {
		_config = {
			title = 'Membro Drift King',
			gtype = 'job'
		},
		'ilegal.permissao',
		'dk.permissao',
		'desmanche.permissao'
	},

	['tdl-lider'] = { -- itens ilegais
		_config = {
			title = 'Chefe T.D.L',
			gtype = 'job'
		},
		--'vagos.permissao',
		'ilegal.permissao',
		'tdllider.permissao',
		'tdl.permissao',
		'contratar.permissao',
		'lockpick.permissao',
		'smuggling.permissao'
	},
	['tdl'] = {
		_config = {
			title = 'Membro T.D.L',
			gtype = 'job'
		},
		--'vagos.permissao',
		'ilegal.permissao',
		'tdl.permissao',
		'lockpick.permissao',
		'smuggling.permissao'
	},
	
	----- Ilegal | Lavagem de dinheiro sujo -----
	
	['Vanilla-lider'] = {  -- lavagem
	    _config = {
		    title = 'Chefe Cassino',
		    gtype = 'job'
	    },
	    'ilegal.permissao',
		'vanillalider.permissao',
	    'vanilla.permissao',
		'contratar.permissao',
	    'wash.permissao'
    },
	['Vanilla'] = {
		_config = {
			title = 'Membro Cassino',
			gtype = 'job'
		},
		'ilegal.permissao',
		'vanilla.permissao',
		'wash.permissao'
	},

	['Bahamas-lider'] = { -- lavagem
	    _config = {
		    title = 'Chefe Bahamas',
		    gtype = 'job'
	    },
	    'ilegal.permissao',
		'bahamaslider.permissao',
		'bahamas.permissao',
	    'contratar.permissao',
	    'wash.permissao'
    },
	['Bahamas'] = {
		_config = {
			title = 'Membro Bahamas',
			gtype = 'job'
		},
		'ilegal.permissao',
		'bahamas.permissao',
		'wash.permissao'
    },
}

cfg.users = {
	[1] = { "Owner" }
}

cfg.selectors = {}

return cfg