cfg = {}

cfg.comandoXenon = "xenon"
cfg.comandoNeon = "neon"
cfg.comandoSuspensao = "suspe"

cfg.apenasDonoAcessaXenon = false
cfg.apenasDonoAcessaNeon = false
cfg.apenasDonoAcessaSuspensao = false

cfg.permissaoParaInstalar = { existePermissao = true, permissoes = { "mecanico.permissao" } }

cfg.blipsShopMec = {
    { loc = { x = 141.71, y = 6643.66, z = 19.1 }, perms = { "mecanico.permissao" } }
}

cfg.valores = {
	{ item = "suspensaoar", quantidade = 1, compra = 100000 },
	{ item = "moduloneon", quantidade = 1, compra = 80000 },
	{ item = "moduloxenon", quantidade = 1, compra = 80000 },
}