//script written by Katy to attempt to highlight sentences based on the html class attribute

function highlightWords() {

    console.log(this.getAttribute('class'));
    
    // 0th step: clear existing highlighting
    /* 
    var lis = document.getElementsByTagName("li");
    
    for (i = 0; i < lis.length; i++) {
        lis[i].style.backgroundColor=document.body.style.backgroundColor; // change this
    }
    */
    
    // first step: get the class of a moused over element (and highlight that element)
    // listen for mouseover on <li> 
    //var class = this. // might be an array
    
    // second step: find all other elements, in all other languages, that match that class
    //for (i = 0; i < class.length; i++) { 
        //var same = document.getElementsByClassName(class[i])
       // for (j = 0; j < class.length; j++) {
            // third step: highlight them!
            //same[j].style.backgroundColor='green';
     //   }
        
   // } */

}

function toggle() {
    console.log("Hello, World");
}

function init() {
    //add event listeners
    var lis = document.getElementsByTagName("li");
    
    for (var i = 0; i < lis.length; i++) {
        lis[i].addEventListener('mouseover', highlightWords, false);
    }   
    
}

window.addEventListener('DOMContentLoaded', init, false);