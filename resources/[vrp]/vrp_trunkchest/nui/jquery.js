let disabled = false;
let disabledFunction = null;

function Interval(time){
	var timer = false
	this.start = function(){
		if (this.isRunning()){
			clearInterval(timer)
			timer = false
		}

		timer = setInterval(function(){
			disabled = false
		},time)
	}

	this.stop = function(){
		clearInterval(timer)
		timer = false
	}

	this.isRunning = function(){
		return timer !== false
	}
}

const disableInventory = ms => {
	disabled = true

	if (disabledFunction === null){
		disabledFunction = new Interval(ms)
		disabledFunction.start()
	} else {
		if (disabledFunction.isRunning()){
			disabledFunction.stop()
		}
		disabledFunction.start()
	}
}

$(document).ready(function(){
	let actionContainer = $("#actionmenu");

	window.addEventListener("message",function(event){
		let item = event.data;
		switch(item.action){
			case "showMenu":
				updateMochila();
				actionContainer.fadeIn(500);
			break;

			case "hideMenu":
				actionContainer.fadeOut(500);
			break;

			case "updateMochila":
				updateMochila();
			break;
		}
	});

	document.onkeyup = function(data){
		if (data.which == 27){
			$.post("http://vrp_trunkchest/invClose");
		}
	};
});

const updateDrag = () => {
	$('.item').draggable({
		helper: 'clone',
		appendTo: 'body',
		zIndex: 99999,
		revert: 'invalid',
		opacity: 0.5,
		start: function(event,ui){
			if (disabled) return false;

			$(this).children().children('img').hide();
			itemData = { key: $(this).data('item-key'), vehname: $(this).data('vehname-key') };

			if (itemData.key === undefined || itemData.vehname === undefined) return;

			let $el = $(this);
			$el.addClass("active");
		},
		stop: function(){
			$(this).children().children('img').show();

			let $el = $(this);
			$el.removeClass("active");
		}
	})

	$('.item2').draggable({
		helper: 'clone',
		appendTo: 'body',
		zIndex: 99999,
		revert: 'invalid',
		opacity: 0.5,
		start: function(event,ui){
			if (disabled) return false;

			$(this).children().children('img').hide();
			itemData = { key: $(this).data('item-key') };

			if (itemData.key === undefined) return;

			let $el = $(this);
			$el.addClass("active");
		},
		stop: function(){
			$(this).children().children('img').show();

			let $el = $(this);
			$el.removeClass("active");
		}
	})

	$('.esquerda').droppable({
		hoverClass: 'hoverControl',
		accept: '.item2',
		drop: function(event,ui){
			itemData = { key: ui.draggable.data('item-key') };

			if (itemData.key === undefined) return;

			disableInventory(500);

			$.post("http://vrp_trunkchest/takeItem", JSON.stringify({
				item: itemData.key,
				amount: Number($("#amount").val())
			}))

			document.getElementById("amount").value = "";
		}
	})

	$('.direita').droppable({
		hoverClass: 'hoverControl',
		accept: '.item',
		drop: function(event,ui){
			itemData = { key: ui.draggable.data('item-key'), vehname: ui.draggable.data('vehname-key') };

			if (itemData.key === undefined || itemData.vehname === undefined) return;

			disableInventory(500);

			$.post("http://vrp_trunkchest/storeItem", JSON.stringify({
				item: itemData.key,
				vehname: itemData.vehname,
				amount: Number($("#amount").val())
			}))

			document.getElementById("amount").value = "";
		}
	})
}

const formatarNumero = (n) => {
	var n = n.toString();
	var r = '';
	var x = 0;

	for (var i = n.length; i > 0; i--) {
		r += n.substr(i - 1, 1) + (x == 2 && i != 1 ? '.' : '');
		x = x == 2 ? 0 : x + 1;
	}

	return r.split('').reverse().join('');
}

const updateMochila = () => {
	$.post("http://vrp_trunkchest/requestMochila",JSON.stringify({}),(data) => {
		const nameList = data.inventario.sort((a,b) => (a.name > b.name) ? 1: -1);
		const nameList2 = data.inventario2.sort((a,b) => (a.name > b.name) ? 1: -1);
		$('#inventory').html(`
			<div class="peso"><b>OCUPADO:</b>  ${(data.peso).toFixed(2)}    <s>|</s>    <b>LIVRE:</b>  ${(data.maxpeso-data.peso).toFixed(2)}    <s>|</s>    <b>TAMANHO:</b>  ${(data.maxpeso).toFixed(2)}</div>
			<div class="peso2"><b>OCUPADO:</b>  ${(data.peso2).toFixed(2)}    <s>|</s>    <b>LIVRE:</b>  ${(data.maxpeso2-data.peso2).toFixed(2)}    <s>|</s>    <b>TAMANHO:</b>  ${(data.maxpeso2).toFixed(2)}</div>
			<div class="esquerda">
				${nameList2.map((item) => (`
					<div class="item" style="background-image: url('images/${item.index}.png');" data-item-key="${item.key}" data-vehname-key="${item.vehname}">
						<div id="peso">${(item.peso*item.amount).toFixed(2)}</div>
						<div id="quantity">${formatarNumero(item.amount)}x</div>
						<div id="itemname">${item.name}</div>
					</div>
				`)).join('')}
			</div>

			<div class="meio">
				<input id="amount" class="qtd" maxlength="9" spellcheck="false" value="" placeholder="QTD">
			</div>

			<div class="direita">
				${nameList.map((item) => (`
					<div class="item2" style="background-image: url('images/${item.index}.png');" data-item-key="${item.key}" data-vehname-key="${item.vehname}">
						<div id="peso">${(item.peso*item.amount).toFixed(2)}</div>
						<div id="quantity">${formatarNumero(item.amount)}x</div>
						<div id="itemname">${item.name}</div>
					</div>
				`)).join('')}
			</div>
		`);
		updateDrag();
	});
}