const formatarNumero = (n) => {
  if (n != 0) {
    var n = n.toString();
    var r = "";
    var x = 0;

    for (var i = n.length; i > 0; i--) {
      r += n.substr(i - 1, 1) + (x == 2 && i != 1 ? "." : "");
      x = x == 2 ? 0 : x + 1;
    }

    return r.split("").reverse().join("");
  }

  return 0;
};

$(function () {
  window.addEventListener("message", function (event) {
    if (event.data.type === "abrirLoja") {
      $(`#shop`).css("display", "unset");
      criarProdutos(event.data.produtos);
    }

    if (event.data.type === "fecharLoja") {
      $(`#shop`).css("display", "none");
    }
  });

  document.onkeyup = function (data) {
    if (data.which == 27) {
      sendData("ButtonClick", { action: "fecharLoja" }, false);
    }
  };
});

$(".close-shop").click(function() {
  sendData("ButtonClick", { action: "fecharLoja" }, false);
})

function criarProdutos(prods) {
  $(".itens").empty();
  $(".qtd-itens").html(Object.values(prods).length);

  Object.values(prods).forEach((prod, i) => {
    var item = JSON.stringify({ item: Object.keys(prods)[i], price: prod.price })

    $(".itens").append(`
      <div class="item">
        <div class="img-and-type">
          <p>${prod.type}</p>
          <img src="${prod.img}" alt="" />
        </div>
        <div class="infos">
          <div class="text">
            <p>${prod.title}</p>
            <p>R$ ${prod.price}</p>
          </div>
          <button data-item='${item}'>
            <span class="material-icons"> shopping_cart </span>
          </button>
        </div>
      </div>
    `);
  });

  $(".item button").click(function() {
    var data = JSON.parse(JSON.stringify($(this).data("item")))
    sendData("ButtonClick", { action: "comprarItem", dataItem: data }, false);
  });
}

function sendData(name, data) {
  $.post("http://zo_carteiras/" + name, JSON.stringify(data), function (datab) {});
}
