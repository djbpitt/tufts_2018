


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
/* function showMD() {
    
    // assumed document-level metadata is in the page source in a <div id="language_meta">
    // also assumed that we make it look nice in some other script somewhere
    
    var lang = this.innerHTML;
    var meta = document.getElementById(lang + "_meta");
    meta.style.display = block;
    
    console.log("mouse in");
}


function hideMD() {
    var lang = this.innerHTML;
    var meta = document.getElementById(lang + "_meta");
    meta.style.display = none;
    console.log("mouse out");
}

*/
function init() {
    //add event listeners
    var lis = document.getElementsByTagName("li");
    
    for (var i = 0; i < lis.length; i++) {
        lis[i].addEventListener('mouseover', highlightWords, false);
    }   
    
    var h2s = document.getElementsByTagName("h2");
    
    for (var i = 0; i < h2s.length; i++) {
        h2s[i].addEventListener('mouseover', showMD, false);
    }   
    
    for (var i = 0; i < h2s.length; i++) {
        h2s[i].addEventListener('mouseout', hideMD, false);
    }   
}

window.addEventListener('DOMContentLoaded', init, false);