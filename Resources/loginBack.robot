*** Settings ***
Library    SeleniumLibrary
Library    RequestsLibrary
Library    DatabaseLibrary
Resource    variables.robot

*** Keywords ***
Verifier que l'utilisateur existe dans la BDD
    Connect To Database Using Custom params    pymysql    database='demo', user='root', password='', host='localhost'
    Row Count Is Equal To X    select id from users where username = '${USERNAME}' and password = md5('${PASSWORD}')    1

Authentifier utilisateur dans application
    Create Session  session3    ${WEBSITE_LINK}
    ${response} =    GET Request    session3    login.php?username=${USERNAME}&password=${PASSWORD}
    ${json} =    Set Variable    ${response.json()}
    Log    ${json}
    Should Be Equal As Strings    ${response.status_code}    200
    Should Be Equal As Strings    ${json['message']}    Successfully Login!

Supprimer utilisateur de la BDD
    Connect To Database Using Custom params    pymysql    database='demo', user='root', password='', host='localhost'
    Execute Sql String    delete from users where username = '${USERNAME}' and password = md5('${PASSWORD}')
    Disconnect from Database

Verifier que l'utilisateur est bien supprimé
   Create Session  session4    ${WEBSITE_LINK}
   ${response} =    GET Request    session4    login.php?username=${USERNAME}&password=${PASSWORD}
   ${json} =    Set Variable    ${response.json()}
   Log    ${json}
   Should Be Equal As Strings    ${response.status_code}    200
   Should Be Equal As Strings    ${json['message']}    Invalid Username or Password!