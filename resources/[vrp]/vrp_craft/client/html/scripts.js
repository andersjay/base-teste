var itemName = null;
var itemAmount = null;
var itemIdname = null;
var dataType = null;
var elements = [];
var invStyle = null;
var sItem = null;
var nome = null;
var receita = [];
var ingredienteOk = null;
$(document).ready(function() {

    setTheme();
    $(".container").hide();
    $(".style-1").hide();
    $(".style-2").hide();
    window.addEventListener('message', function(event) {
        var item = event.data;


        if (item.receita == true) {
            $("#container2").empty()
            $("#container3").empty()

            receitas = Object.values(event.data.receitax);
            x = 0
            receitas.forEach(element => {
                receita.push(element.ingredientes)

                $("#container2").append(`
                <div class="receita" onclick="craftar(this)" data-id="${x}" data-name="${element.item}" data-amount="" data-idname="${element.item}" data-itemWeight="" style="background-image: url('assets/icons/${element.icone}'); background-size: 80px 80px;">
                                    <p class="amount"><span class="peso"></span></p>
                                    <p class="name">${element.nome}</p>
                                </div>`)
                x = x + 1;
            });


        }




        if (item.show == true) {
            dataType = item.dataType;

            invStyle = item.style

            if (item.style == 1) {
                $(".style-1").hide();
                $(".style-2").show();
                $(".style-2 .inv_e_weight .label_1").html(item.p_i_weight + "/" + item.p_i_maxWeight + " kg");

                var tryIt = (item.p_i_weight / item.p_i_maxWeight) * 100
                $(".style-2 .inv_e_weight .progress_1").css("width", tryIt + "%");
            } else {
                $(".style-2").hide();
                $(".style-1").show();
                $(".inv_e_weight .label_1").html(item.p_i_weight + "/" + item.p_i_maxWeight + " kg");
                $(".inv_d_weight .label_1").html(item.i_weight + "/" + item.i_maxWeight + " kg");

                var tryIt = (item.p_i_weight / item.p_i_maxWeight) * 100
                var tryIt2 = (item.i_weight / item.i_maxWeight) * 100
                $(".style-1 .inv_e_weight .progress_1").css("width", tryIt + "%");
                $(".style-1 .inv_d_weight .progress_1").css("width", tryIt2 + "%");
            }


            if (dataType[2] >= 3) {
                $("#sendme").html("COLOCAR");
                $("#sendme2").html("RETIRAR");
                $(".inv_d_label").html("Bau");
                $(".inv_d_weight_l").html("Bau");
            } else if (dataType[2] == 2) {
                $("#sendme").html("COLOCAR");
                $("#sendme2").html("RETIRAR");
                $(".inv_d_label .label_1").html("Porta Malas");
                $(".inv_d_weight_l").html("Porta Malas");
            } else {
                $("#sendme").html("Enviar");
            }
            open();
        }
        if (item.show == false) {
            close();
        }

        if (item.pinventory) {
            $("#container1").empty();
            item.pinventory.forEach(element => {
                $("#container1").append(`
	<div class="inner-items"  data-name="${element.idname}" data-amount="${element.amount}" data-idname="${element.idname}" data-itemWeight="${element.item_peso}" style="background-image: url('assets/icons/${element.icon}'); background-size: 80px 80px;">
			<p class="amount">${element.amount} <span class="peso">${element.item_peso}Kg</span></p>

			<p class="name">${element.name}</p>
        `);
            });
        }

        if (item.inventory && dataType[2] > 1) {
            $(".inv_direita_items").empty();
            item.inventory.forEach(element => {
                $(".inv_direita_items").append(`
			<div class="inner-items"  data-name="${element.name}" data-amount="${element.amount}" data-idname="${element.idname}" data-itemWeight="${element.item_peso}" style="background-image: url('assets/icons/${element.icon}'); background-size: 80px 80px;">
			<p class="amount">${element.amount} <span class="peso">${element.item_peso}Kg</span></p>

			<p class="name">${element.name}</p>
			</div>
			`);
            });
        }

        if (item.inventory && dataType[2] == 1) {
            $(".eq_items").empty();
            item.inventory.forEach(element => {
                $(".eq_items").append(`
			<div class="inner-items" data-name="${element.name}" data-amount="${element.amount}" data-idname="${element.idname}" data-itemWeight="${element.item_peso}" style="background-image: url('assets/icons/${element.icon}'); background-size: 80px 80px;">
			</div>
			`);
            });
        }


        if (item.notification == true) {
            Swal.fire(
                item.title,
                item.message,
                item.type
            )
        }

    });


    document.onkeyup = function(data) {
        if (data.which == 27) {
            $.post('http://vrp_craft/close', JSON.stringify({}));
        }
    };
    $(".btnClose").click(function() {
        $.post('http://vrp_craft/close', JSON.stringify({}));
    });

    dragula([document.getElementById("container1"), document.getElementById("container3")], {
            accepts: function(el, target) {
                return !el.classList.contains('craft')
            },
            moves: function(el, container, handle) {
                return !el.classList.contains('craft')
            }

        })
        .on('drag', function(el) {
            if (el.getAttribute("class") == "craft") {


            }

        }).on('drop', function(el, container) {
            if (container.getAttribute("id") == "container3") {
                var teste = container.querySelectorAll(".craft")
                var ingredientes = []
                for (let index = 0; index < teste.length; index++) {
                    ingredientes.push(teste[index].getAttribute("data-name"))
                    if (teste[index].getAttribute("data-name") == el.getAttribute("data-name")) {
                        teste[index].remove()
                        ingredienteOk++

                    }
                }

                if (!ingredientes.includes(el.getAttribute("data-name"))) {
                    var teste = container.querySelectorAll(".inner-items")
                    for (let index = 0; index < teste.length; index++) {
                        if (teste[index].getAttribute("data-name") == el.getAttribute("data-name")) {
                            $("#container1").append(teste[index]);

                        }
                    }
                }
            }


        }).on('over', function(el, container) {

        }).on('out', function(el, container) {});



});


//ENVIA PARA O CRAFT 
function craftou() {
    qtproduzir = document.getElementById("qtProduzir").value
    qtproduzir = parseInt(qtproduzir)
    if (recipe.length == ingredienteOk) {
        ingredienteOk = 0;
        $.post('http://vrp_craft/craftar', JSON.stringify({ nomeitem: receitas[idItem].item, nome: receitas[idItem].nome, ingredientes: receitas[idItem].ingredientes, producaominima: qtproduzir }));
        $("#container3").empty();
    }

}

function craftar(item) {
    ingredienteOk = 0;
    idItem = item.getAttribute("data-id")
    recipe = receita[idItem]
    console.log(idItem)
    var itens = document.getElementById("container3").querySelectorAll(".inner-items")
    for (let index = 0; index < itens.length; index++) {
        $("#container1").append(itens[index]);
    }
    $("#container3").empty()
    for (let index = 0; index < recipe.length; index++) {
        ingrediente = recipe[index].nome
        qt = recipe[index].qt
        icone = `${ingrediente}.png`
        itemCraft = `
        <div style="opacity:100%" class="craft" data-name="${ingrediente}" data-amount="${qt}" data-idname="ferro" data-itemWeight="52" style="background-image: url(''); background-size: 80px 80px;">
        <p class="amount">${qt}<span class="peso"></span></p>
        <p class="name">${ingrediente}</p>
    </div>`;

        $("#container3").append(itemCraft);
    }

}



// -------------------------------------------------------


function open() {
    $(".container").fadeIn();
    clearSelectedItem();
}

function close() {
    $(".container").fadeOut();
    clearSelectedItem();
}



function setTheme() {
    if (configs.theme.primary_color && configs.theme.secondary_color) {
        let primary_color = `--primary-color: ${configs.theme.primary_color}; `;
        let secondary_color = `--secondary-color: ${configs.theme.secondary_color}; `;
        $(":root").attr("style", primary_color + secondary_color);
    }
}

function clearSelectedItem() {
    itemName = null;
    itemAmount = null;
    itemIdname = null;
    $(sItem).css("background-color", "rgba(0,0,0,.2)");
    $(sItem).removeClass("pulse");
}




function open() {
    $(".container").fadeIn();
    clearSelectedItem();
}

function close() {
    $(".container").fadeOut();
    clearSelectedItem();
}



function setTheme() {
    if (configs.theme.primary_color && configs.theme.secondary_color) {
        let primary_color = `--primary-color: ${configs.theme.primary_color}; `;
        let secondary_color = `--secondary-color: ${configs.theme.secondary_color}; `;
        $(":root").attr("style", primary_color + secondary_color);
    }
}

function clearSelectedItem() {
    itemName = null;
    itemAmount = null;
    itemIdname = null;
    $(sItem).css("background-color", "rgba(0,0,0,.2)");
    $(sItem).removeClass("pulse");
}