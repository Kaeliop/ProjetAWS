var plateau=[];
placeBateaux();
var navires=[0,5,4,3,3,2];
var touches=0;
var finPartie=false;
var nbCoups=0;
var message=[];
message[0]="A l'eau !";
message[1]="Porte-avion touché !";
message[2]="Croiseur touché !";
message[3]="Contre-torpilleur touché !";
message[4]="Sous-marin touché !";
message[5]="Torpilleur touché !";
message[6]="Case déjà jouée !";
message[11]="Porte-avion coulé !";
message[12]="Croiseur coulé !";
message[13]="Contre-torpilleur coulé !";
message[14]="Sous-marin coulé !";
message[15]="Torpilleur coulé !";

function conversion(position){ 
	var colonne=position.charCodeAt(0)-65;
	var ligne=parseInt(position.slice(1))-1;
	return {colonne:colonne, ligne:ligne};	
}
function getCodeCase(position){
	var c=conversion(position);
	return plateau[c.ligne][c.colonne];
}
function setCodeCase(position,valeur){
	var c=conversion(position);
	plateau[c.ligne][c.colonne]=valeur;
}
function majVueJeu(position,situation){
	if(finPartie){
		alert(message[situation]+"\nVous avez coulé tous les navires en "+nbCoups+" coups");
		location.reload();
	}else{	
		//alert(message[situation]);
	}
	var couleur="#FF0000";
	if (getCodeCase(position)==-6){couleur="#BBBBFF";}
	document.getElementById(position).style.backgroundColor=couleur;	
}
function jouerCoup(position){
	nbCoups++;
	var codeCase=getCodeCase(position);
	var situation=codeCase;
	switch(codeCase){
		case 0:
			setCodeCase(position,-6);
		break;
		case 1: case 2: case 3: case 4: case 5:
			navires[codeCase]--;
			if(navires[codeCase]==0){situation+=10;}
			setCodeCase(position,-codeCase);

			touches++;
			if(touches==17){finPartie=true;}			
		break;
		default:
			situation=6;
	}
	majVueJeu(position,situation);
}
function placeBateau(ligneDepart,colonneDepart,vertical,code,longueur){
	var incrementLigne,incrementColonne;	
	var succes=true;
	if(vertical){
		incrementLigne=1;
		incrementColonne=0;
	}else{
		incrementLigne=0;
		incrementColonne=1;
	}
	for(var i=0;i<longueur;i++){
		if(plateau[ligneDepart+i*incrementLigne][colonneDepart+i*incrementColonne]!=0){
			succes=false;
			break;		
		}
	}
	if(succes){
		for(var i=0;i<longueur;i++){
			plateau[ligneDepart+i*incrementLigne][colonneDepart+i*incrementColonne]=code;
		}
	}

	return succes;
}
function positionHasardBateau(code,longueur){
	var departLimite,depart;	
	var succes=false;
	while(!succes){
		departLimite=Math.floor(Math.random()*(11-longueur));
		depart=Math.floor(Math.random()*10);
		if(Math.random()<0.5){
			succes=placeBateau(departLimite,depart,true,code,longueur);
		}else{
			succes=placeBateau(depart,departLimite,false,code,longueur);
		}
	}
}
function placeBateaux(){
	for(var ligne=0;ligne<=9;ligne++){
		plateau[ligne]=[0,0,0,0,0,0,0,0,0,0];
	}
	positionHasardBateau(5,2);	
	positionHasardBateau(3,3);
	positionHasardBateau(4,3);
	positionHasardBateau(2,4);
	positionHasardBateau(1,5);
}