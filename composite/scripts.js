//script written by Katy to attempt to highlight sentences based on the html class attribute

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

function init() {
    //add event listeners
    var lis = document.getElementsByTagName("li");
    
    for (var i = 0; i < lis.length; i++) {
        lis[i].addEventListener('mouseover', highlightWords, false);
    }   
    
}

window.addEventListener('DOMContentLoaded', init, false);