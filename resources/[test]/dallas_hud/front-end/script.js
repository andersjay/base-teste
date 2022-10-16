let cache = 0;

const functions = {
    setTime: (data) => {
        $("#hour").html(data.value)
    },
    setLocation: (data) => {
        $("#adress").html(data.value)
    },
    setHealth: (data) => {
        $(".healthDisplay").css('width', data.value + "%")
    },
    setHunger:(data) =>{
        $(".hungerDisplay").css('height', data.value + "%")

    },
    setThirst:(data) =>{
        $(".thirstDisplay").css('height', data.value + "%")

    },
    setArmour: (data) => {
        $(".armourDisplay").css('width', data.value + "%")
    },
    setMarcha: (data) => {
        $("#marcha").html(data.value)
    },
    setCinto: (data) => {
        if (data.value == false) {
            $(".seatbelt").css('display', "block")
            $(".seatbelt-on").css('display', 'none')
        } else if (data.value == true) {
            $(".seatbelt-on").css('display', "block")
            $(".seatbelt").css('display', "none")
        }
    },
    setFuel: (data) => {
        if(data.value <= 20) {
            $(".item1").addClass("full")
            $(".item2").removeClass("full")
            $(".item3").removeClass("full")
            $(".item4").removeClass("full")
            $(".item5").removeClass("full")
        } else if(data.value <= 40) {
            $(".item1").addClass("full")
            $(".item2").addClass("full")
            $(".item3").removeClass("full")
            $(".item4").removeClass("full")
            $(".item5").removeClass("full")
        } else if(data.value <= 60) {
            $(".item1").addClass("full")
            $(".item2").addClass("full")
            $(".item3").addClass("full")
            $(".item4").removeClass("full")
            $(".item5").removeClass("full")
        } else if(data.value <= 80) {
            $(".item1").addClass("full")
            $(".item2").addClass("full")
            $(".item3").addClass("full")
            $(".item4").addClass("full")
            $(".item5").removeClass("full")
        } else if(data.value <= 100) {
            $(".item1").addClass("full")
            $(".item2").addClass("full")
            $(".item3").addClass("full")
            $(".item4").addClass("full")
            $(".item5").addClass("full")
        }
    },
    setSpeed: (data) => {
        bar.set(
            data.value,
            false
        )
        $("#kmh").html(data.value)
    },
    setArmour: (data) => {
        if (data.value === 0) {
            $(".armour").css("display", "none")
        } else {
            $(".armour").css("display", "flex")
        }
        if (data.value) {
            if (data.value <= 1) {
                setArmour(0);
            } else {
                $(".armourDisplay").css('width', data.value + "%")

            }
        }
    },
    hudChannel: (data) => {
        if(data.value) {
            $(".radio").css("display", "flex")
            $(".radio").addClass("showSpeedometer");
            $(".radio").removeClass("hideSpeedometer")
            $("#frequency").html(data.value)
            $(".styleme").removeClass("toRight")
        } else {
            $(".radio").removeClass("showSpeedometer");
            $(".radio").addClass("hideSpeedometer");
            $(".styleme").addClass("toRight")
            $(".styleme").addClass("showSpeedometer")
        }
    },
    hudMode: (data) => {
        if(data.value == 1){
            $("#mic").html("S")
        } else if(data.value == 2){
            $("#mic").html("N")
        } else if(data.value == 3){
            $("#mic").html("G")
        }
    },  
    setLock: (data) => {
        if(data.value == 1) {
            $("#key").css("color", "#97d05f")
        } else{
            $("#key").css("color", "#d43458")
        }
    },
    micColor: (data) => {
        if(data.value) {
            $("#mic").css("color", "#97d05f")
        } else {
            $("#mic").css("color", "#fff")
        }
    },
    setProgress:(data)=>{
        
            var timeSlamp = data.progressTimer;

            if($("#progress").css("display") === "flex"){
                $(".progressFill").css("stroke-dashoffset","100");
                $("#progress").css("display","none");
                clearInterval(tickInterval);
                tickInterval = undefined;

                return
            } else {
                $("#progress").css("display","flex");
                $(".progressFill").css("stroke-dashoffset","100");
            }

            var tickPerc = 100;
            var tickTimer = (timeSlamp / 100);
            tickInterval = setInterval(tickFrame,tickTimer);

            function tickFrame(){
                tickPerc--;

                if (tickPerc <= 0){
                    clearInterval(tickInterval);
                    tickInterval = undefined;
                    $("#progress").css("display","none");
                } else {
                    timeSlamp = timeSlamp - (timeSlamp / tickPerc);
                }

                $(".progressnumber").html(parseInt(timeSlamp / 1000));
                $(".progressFill").css("stroke-dashoffset",tickPerc);
            }

            return
    },
    talkingRadio: (data) => {
        if(data.value){
            $("#frequency").css("color", "#97d05f")
        } else {
            $("#frequency").css("color", "#fff")
        }
    }
}


window.addEventListener("message", function(event) {
    let action = event.data.action;
    if (functions[action]) functions[action](event.data);
});


window.addEventListener("message", function(event) {
    switch (event.data.action) {
        case "update":
            $(".velocimetro").addClass("hideSpeedometer");
            $(".velocimetro").removeClass("showSpeedometer");
            $(".carDetails").addClass("hideSpeedometer");
            $(".carDetails").removeClass("showSpeedometer");
            $(".bars").removeClass("showSpeedometer");
            break;
        case "inCar":
            $(".bars").addClass("showSpeedometer");
            $(".bars").removeClass("hideSpeedometer");
            $(".velocimetro").addClass("showSpeedometer");
            $(".velocimetro").removeClass("hideSpeedometer");
            $(".carDetails").addClass("showSpeedometer");
            $(".carDetails").removeClass("hideSpeedometer");
            if (cache == 0) {
                $(".seatbelt").css('display', "block");
                $(".seatbelt-on").css('display', "none")
                cache++;
            }
            break;
    }
})