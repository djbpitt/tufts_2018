


// highlight sentences w the same class as a moused-over sentence
function highlightWords() {
       
    // 0th step: clear existing highlighting
    var lis = document.getElementsByTagName("li");
    
    for (i = 0; i < lis.length; i++) {
        lis[i].style.backgroundColor=document.body.style.backgroundColor;
    }
    
    // first step: get the class of a moused over element (and highlight that element)
    var classes = this.getAttribute('class').split(" ");
    
    // second step: find all other elements, in all other languages, that match that class
    for (i = 0; i < classes.length; i++) { 
        var same = document.getElementsByClassName(classes[i])
        for (j = 0; j < same.length; j++) {
            //third step: highlight them!
            same[j].style.backgroundColor='pink';
        }
        
    }

}

// display corpus and document meta-data when the language is moused-over
function showMD(event) {
    //http://answers.oreilly.com/topic/1823-adding-a-page-overlay-in-javascript/
    /*
     * id: unique id that can be used to close one popup while leaving others open
     * text: plain text body of popup
     */
    var popupId = this.dataset.id;
    if (document.getElementById(popupId)) {
        // delete exisiting pop up with a second click
        document.body.removeChild(document.getElementById(popupId));
        return; 
    } 
    var definition = this.dataset.definition;
    // text processing to make it pretty
    var table = "<table>";
    
    var attrs = definition.split(" ");
    for (var i = 0; i < attrs.length; i++) {
        var h = attrs[i].split("=")[0];
        h = h.replace("-", " ");
        var d = attrs[i].split("=")[1];
        table += "<tr><th>" + h + "</th><td>" + d + "</td></tr>";     
    }
    
    table += "</table>";
    
    var overlay = document.createElement("div");
    var XMousePos = event.clientX;
    var Ypos = event.clientY + window.pageYOffset;
    var windowWidth = window.innerWidth;
    if (windowWidth - XMousePos > 300) {
        var Xpos = XMousePos
    } else {
        var Xpos = windowWidth - 310
    };
    overlay.setAttribute("id", popupId);
    overlay.setAttribute("style", "z-index: 10; background-color: white; position: absolute; left: " + Xpos + "px; top: " + Ypos + "px; border: 2px solid black; width: 300px; padding: 2px; margin: 0;")
    overlay.setAttribute("onclick", "document.body.removeChild(document.getElementById('" + popupId + "'))");
    overlay.setAttribute("class", "overlay");
    overlay.innerHTML = "<div>" + table + "</div>";
    document.body.appendChild(overlay);
}


function init() {
    //add event listeners
    var lis = document.getElementsByTagName("li");
    
    for (var i = 0; i < lis.length; i++) {
        lis[i].addEventListener('mouseover', highlightWords, false);
    }   
    
    var spans = document.getElementsByTagName("span");
    
    for (var i = 0; i < spans.length; i++) {
        spans[i].addEventListener('click', showMD, false);
    }   
    
}

window.addEventListener('DOMContentLoaded', init, false);