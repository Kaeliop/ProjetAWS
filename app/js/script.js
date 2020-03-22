
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
  response.sendFile('/Users/mac/Desktop/AWS/connexion.html');
});

app.post('/auth', function(request, response) {
	var mail = request.body.email_cnx;
  var password = request.body.mdp_cnx;

	if (mail && password) {
		connection.query('SELECT nickname FROM player WHERE mail = ? AND password = ?', [mail, password], function(error, result, fields) {
			if (result) {
        request.session.loggedin = true;
        console.log(result);
				request.session.username = result[0].nickname;
				response.writeHead(302, {
					'Location': 'accueil.html'
				  });
				  response.end();
						} else {
        console.log(result);
				response.send('Incorrect Username and/or Password!');
			}			
			response.end();
		});
	} else {
		response.send('Please enter Username and Password!');
		response.end();
	}
});

app.get('/home', function(request, response) {
	if (request.session.loggedin) {
		response.send('Welcome back, ' + request.session.username + '!');
	} else {
		response.send('Please login to view this page!');
	}
	response.end();
});


app.listen(3000);