$(document).ready(function(){
	window.addEventListener("message",function(event){
		var html = ""

		if (event.data.mode == 'sucesso') {
			html = "<div id='showitem' style=\"background-image: url('nui://vrp_inventory/nui/images/"+event.data.item+".png'); background-size: 100px;\"><b><sucesso>+</sucesso> "+event.data.mensagem+"</b></div>"
		}

		if (event.data.mode == 'negado') {
			html = "<div id='showitem' style=\"background-image: url('nui://vrp_inventory/nui/images/"+event.data.item+".png'); background-size: 100px;\"><b><negado>-</negado> "+event.data.mensagem+"</b></div>"
		}

		$(html).fadeIn(500).appendTo("#notifyitens").delay(3000).fadeOut(500);
	})
});