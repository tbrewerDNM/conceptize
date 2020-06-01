function changeCategory(id,e) {
    document.getElementById(id).innerHTML = e.innerHTML;
}

/* count the number of divs in an array */
function countDivs(nodes) {
    var count = 0;

    for (var i = 0; i < nodes.length; i++) {
        if (nodes[i].localName === "div")
            count++;
    }

    return count;
}

function addImageToProduct(tid,e) {
    var table = document.getElementById(tid);
    var newPic;

    if (countDivs(e.parentNode.childNodes) >= 4) {
        /* insert new row */

    } else {
        /* insert new element in current row */
        newPic = document.createElement("div");
        newPic.classList.add("col-sm-3");
        newPic.classList.add("add-product-image");
        newPic.addEventListener("onclick", () => { addImageToProduct(tid,newPic) });
        e.parentNode.appendChild(newPic);
    }
}

function profileSwitch(prod) {
    var profile = document.getElementById("profile-info");
    var product = document.getElementById("profile-products");
    profile.style.display = prod ? 'none' : 'block';
    product.style.display = prod ? 'block' : 'none';

    if (prod) {
        if (!profile.classList.contains("btn-secondary")) profile.classList.add("btn-secondary");
        if (profile.classList.contains("btn-light")) profile.classList.remove("btn-light");
        if (product.classList.contains("btn-secondary")) product.classList.remove("btn-secondary");
        if (!product.classList.contains("btn-light")) product.classList.add("btn-light");
    }
}