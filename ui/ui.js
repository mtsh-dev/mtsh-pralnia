
window.addEventListener('message', function (event) {
    var data = event.data;

    if (data.openPraniePieniedzy === true) {
        document.getElementById('praniePieniedzy').style.display = 'block';
    } else if (data.openPraniePieniedzy === false) {
        document.getElementById('praniePieniedzy').style.display = 'none';
    }

    if (data.test) {
        console.log(data.test);
    }

    if (data.type === 'close') {
        closeUI();
    }

    if (data.praniePieniedzyPotwierdzenie) {
        if (data.praniePieniedzyPotwierdzenie.success) {
            console.log(data.praniePieniedzyPotwierdzenie.message);
        } else {
            console.error(data.praniePieniedzyPotwierdzenie.message);
        }
    }
});

const container = document.getElementById("praniePieniedzy");

document.getElementById("closeButton").addEventListener("click", function (e) {
    closeUI();
    fetch(`https://${GetParentResourceName()}/close`, {
        method: "POST",
        headers: {
            "Content_type": "application/json; charset=UTF-8"
        },
        body: JSON.stringify({})
    });
});

function closeUI() {
    container.style.display = 'none';
}

window.addEventListener("message", function (event) {
    let e = event.data;
    if (e.action == "show") {
        openUI();
    }
});

function toggleUI() {
    container.classList.toggle("hidden");
}

function openUI() {
    container.style.display = 'flex';
}

function praniePieniedzy() {
    const amountInput = document.getElementById('amount');
    const amount = parseInt(amountInput.value);

    if (isNaN(amount) || amount <= 0) {
        console.error('Nieprawidłowa ilość pieniędzy do wyprania.');
        return;
    }

    fetch(`https://${GetParentResourceName()}/praniePieniedzy`, {
        method: "POST",
        headers: {
            "Content_type": "application/json; charset=UTF-8"
        },
        body: JSON.stringify({
            amount: amount
        })
    }).then(response => response.json())
        .then(data => {
            if (data.success) {
                console.log(data.message);
            } else {
                console.error(data.message);
            }
        })
        .catch(error => {
            console.error('Wystąpił błąd podczas prania pieniędzy:', error);
        });
}
