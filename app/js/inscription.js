var mysql = require('mysql');
var express = require('express');
var session = require('express-session');
var bodyParser = require('body-parser');
var path = require('path');


var connection = mysql.createConnection({
	host     : 'localhost',
	user     : 'root',
	password : '',
	database : 'TRY1'
});


var app = express();

app.use(session({
	secret: 'secret',
	resave: true,
	saveUninitialized: true
}));
app.use(bodyParser.urlencoded({extended : true}));
app.use(bodyParser.json());
app.use(express.static('/Users/mac/Desktop/AWS'));



app.get('/', function(request, response) {
  response.sendFile('/Users/mac/Desktop/AWS/inscription.html');
});



app.post('/auth2', function(request, response) {
	var mail = request.body.email;
  var password = request.body.password;
  var nickname= request.body.fname + request.body.lname;
	console.log("Connected!");
	connection.query('INSERT INTO player (nickname, mail, password) VALUES (?, ?, ?)',[nickname, mail, password], function (err, result) {
	  if (err) throw err;
      {console.log("1 record inserted");
      response.writeHead(302, {
        'Location': 'connexion.html'
      });
      response.end();
    }
	});

});
app.listen(3000);
