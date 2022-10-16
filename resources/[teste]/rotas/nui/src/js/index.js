const imagesUrl = "http://localhost/imagens/itens/";

const Routes = {
    load: function(title, items) {

   
      $.each(items, function(index, element) {
          $(".craft-items").append(`
           <div class="item list-item"> 
              <div class="item-photo" style="
              -webkit-mask-image: linear-gradient(to left, transparent 25%, black 100%);"><img src="${imagesUrl + (element.image ? element.image : index)}.png"></div>
              <div class="item-desc">
                <small>Item</small>
                <span>${element.name}</span>
              </div>
              <p>Farm Gratuito</p>
              <button onclick="Routes.selectRoute('${index}')"><i class="fas fa-play-circle icon"></i> iniciar</button>
          </div>
      `);
      });
    },
    selectRoute: function(code) {
      Routes.callServer("selectRoute", { code });
    },
    callServer: function(endpoint, data, callback) {
      $.post("http://rotas/" + endpoint, JSON.stringify(data), callback);
    }
};

document.onkeyup = function(data) {
  if (data.which == 27) {
    Routes.callServer("exit", {});
  }
};

$('.close').on('click', function() {
    Routes.callServer("exit", {});
});
    
window.addEventListener("message", function(event) {
    var action = event.data.action;
 
    switch(action) {
      case "open":
        Routes.load(event.data.title, event.data.items);
        console.log('abriu')
        $("body").show();

      break;
      case "exit":
        console.log('fechou')
        $("body").hide();
      break;
    }
});