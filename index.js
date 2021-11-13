// index.js

import { Elm } from './src/Main.elm'

var app = Elm.Main.init({
    node: document.querySelector('main')
})

app.ports.requestFilter.subscribe(function () {
    var m = localStorage.getItem('filter') || '[]' ;
    app.ports.responseFilter.send(m);
});

app.ports.setFilter.subscribe(function (newValue) {
    localStorage.setItem('filter', newValue);
});