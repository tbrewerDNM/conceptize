class Product {
    uid = "";
    pid = "";
    price = 0;
    title = "";
    negotiable = "";
    category = "";
    description = "";
    img = "";
};

const catTable = ["design", "digital marketing", "original characters", "writing", "inventions", "music", "all"];

function changeCategory(id,e) {
    document.getElementById(id).innerHTML = e.innerHTML;
}

function getCatIndex(cat) {
    var index = 7;

    for (var i = 0; i < catTable.length; i++) {
        if (cat.toLowerCase() === catTable[i]) {
            index = i;
            index++;
            break;
        }
    }

    return index;
}

function loadProfilePage(uid) {
    document.getElementById("uid-input").value = uid;
    document.getElementById("goto-profile").submit();
}

function loadProductPage(pid) {
    document.getElementById("pid-input").value = pid;
    document.getElementById("goto-product-submit").submit();
}

function loadEditProductPage(pid) {
    document.getElementById("pid-input2").value = pid;
    document.getElementById("goto-product-edit").submit();
}

function submitProduct() {
    document.getElementById("submit-title").value = document.getElementById("input-title").value;
    document.getElementById("submit-cat").value = getCatIndex(document.getElementById("create-dropdown").innerHTML.toLowerCase()).toString();
    document.getElementById("submit-price").value = document.getElementById("input-price").value;
    document.getElementById("submit-image").value = document.getElementById("input-image").value;
    
    if (document.getElementById("nego-radio").checked)
        document.getElementById("submit-nego").value = "1";
    else
        document.getElementById("submit-nego").value = "0";
    
    document.getElementById("submit-desc").value = document.getElementById("input-desc").value;
    
    if (document.getElementById("submit-title").value != "" && document.getElementById("input-price").value != "") {
        document.getElementById("create-product-submit").submit();
        document.getElementById("submit-title").value = "";
        document.getElementById("submit-cat").value = "7";
        document.getElementById("submit-price").value = "";
        document.getElementById("submit-image").value = "";        
    }
}

function submitProductEdit() {
    document.getElementById("edit-title").value = document.getElementById("input-title").value;
    document.getElementById("edit-cat").value = getCatIndex(document.getElementById("create-dropdown").innerHTML.toLowerCase()).toString();
    document.getElementById("edit-price").value = document.getElementById("input-price").value;
    document.getElementById("edit-image").value = document.getElementById("input-image").value;
    
    if (document.getElementById("nego-radio").checked)
        document.getElementById("edit-nego").value = "1";
    else
        document.getElementById("edit-nego").value = "0";
    
    document.getElementById("edit-desc").value = document.getElementById("input-desc").value;
    
    if (document.getElementById("edit-title").value != "" && document.getElementById("edit-price").value != "") {
        document.getElementById("edit-product-submit").submit();
        document.getElementById("edit-title").value = "";
        document.getElementById("edit-cat").value = "7";
        document.getElementById("edit-price").value = "";
        document.getElementById("edit-image").value = "";        
    }
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

function searchProd(text,cat) {
    document.getElementById("search-text-input").value = text;
    document.getElementById("search-cat-input").value = cat;
    document.getElementById("change-cat-input").value = "0";
    document.getElementById("goto-search").submit();    
}

function searchProduct() {
    document.getElementById("search-text-input").value = document.getElementById("search-bar").value;
    document.getElementById("search-cat-input").value = getCatIndex(document.getElementById("home-dropdown").innerHTML.toLowerCase()).toString();
    document.getElementById("goto-search").submit();
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