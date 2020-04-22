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
app.get('/home', function(request, response) {
	if (request.session.loggedin) {
		response.send('Welcome back, ' + request.session.username + '!');
	} else {
		response.send('Please login to view this page!');
	}
	response.end();
});

var id = 1;


connection.connect(function(err) {
	if (err) throw err;
	connection.query("SELECT * FROM friends WHERE id_a = ? or id_b = ?",[id, id], function (err, result, fields) {
	  if (err) throw err;
	  var j = result.length;
	  let friends = [];
	  for( i = 0; i<j; i++){
		  if(result[i].id_a == 1)
			  friends.push(result[i].id_b);
		  else
		  	friends.push(result[i].id_a);
	  }
	  	// console.log(friends);
	});
});


function get_info(parm, callback){

	var sql = "SELECT * FROM friends WHERE id_a = ? or id_b = ?";

	connection.query(sql,[parm, parm], function(err, result){
		  if (err){ 
			throw err;
		  }
		
	
		  return callback(result);
  }
	)};

const friendsList = document.getElementById('send-container')
messageForm.addEventListener('submit', e => {
  e.preventDefault()
  const message = messageInput.value
  appendMessage(`You: ${message}`)
  socket.emit('send-chat-message', message)
  messageInput.value = ''
})

function appendMessage(message) {
  const messageElement = document.createElement('div')
  messageElement.className('friend')
  messageElement.innerText = get_info()
  messageContainer.append(messageElement)
} 
//usage


// get_info(1, function(result){
//   stuff_i_want = result;
// console.log(stuff_i_want);
//   //rest of your code goes in here
// });


//Chat part
// const socket = io('http://localhost:3000')
// const messageContainer = document.getElementById('message-container')
// const messageForm = document.getElementById('send-container')
// const messageInput = document.getElementById('message-input')

// const name = prompt('What is your name?')
// appendMessage('You joined')
// socket.emit('new-user', name)

// socket.on('chat-message', data => {
//   appendMessage(`${data.name}: ${data.message}`)
// })

// socket.on('user-connected', name => {
//   appendMessage(`${name} connected`)
// })

// socket.on('user-disconnected', name => {
//   appendMessage(`${name} disconnected`)
// })

// messageForm.addEventListener('submit', e => {
//   e.preventDefault()
//   const message = messageInput.value
//   appendMessage(`You: ${message}`)
//   socket.emit('send-chat-message', message)
//   messageInput.value = ''
// })

// function appendMessage(message) {
//   const messageElement = document.createElement('div')
//   messageElement.innerText = message
//   messageContainer.append(messageElement)
// }    
// ****** End of chat


app.listen(3000);

