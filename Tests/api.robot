*** Settings ***
Resource    ../Resources/signupBack.robot
Resource    ../Resources/loginBack.robot
Resource    ../Resources/variables.robot

*** Test Cases ***
Inscrire Un Utilisateur dans la BDD
    [Tags]    First
    signupBack.Verifier si l'utilisateur n'existe pas dans la BDD
    signupBack.Inscription utilisateur par une requete Http POST
    signupBack.Verifier que l'utilisateur est ajoute dans la BDD

Inscire le meme utilisateur dans la BDD
    [Tags]    Second
    signupBack.Inscription meme utilisateur par une requete Http POST
    signupBack.Verifier que l'utilisateur n'est pas dupliquer dans la BDD

Authentifier utilisateur dans application
    [Tags]    Third
    loginBack.Verifier que l'utilisateur existe dans la BDD
    loginBack.Authentifier utilisateur dans application

Supprimer Utilisateur
    [Tags]    Fourth
    loginBack.Supprimer utilisateur de la BDD
    loginBack.Verifier que l'utilisateur est bien supprimé