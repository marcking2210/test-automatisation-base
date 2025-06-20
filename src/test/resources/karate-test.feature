@SQA-2025 @testAPI2025 @MarcoJativa
Feature: Test de API súper simple

  Background: Precondition for all scenaries
      Given url "http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api"
    * configure ssl = true

  @id:1 @getAllCharacters
  Scenario: Consultar todos los personajes
    Given path "characters"
    When method get
    Then status 200
    * print response

  @id:2 @getCharacterById
  Scenario Outline: Consultar personaje por id
    Given path "characters", <id>
    When method get
    Then status 200
    And match response.id == <id>
    * print response
    Examples:
      | id |
      | 2008  |
      | 2009  |
      | 2266  |

  @id:3 @createCharacter
  Scenario: Crear un nuevo personaje
    Given path "characters"
    And request { "name": "Iron Marck85052", "alterego": "Marco Jativa", "description": "Genius billionaire", "powers": ["Armor", "Flight"] }
    When method post
    Then status 201
    * print response

  @id:4 @updateCharacter
  Scenario: Actualizar un personaje existente
    Given path "characters", 637
    And request { "name": "Iron Marck10", "alterego": "Marco Jativa", "description": "Genius Multi billionaire", "powers": ["Armor", "Flight"] }
    When method put
    Then status 200
    * print response

  @id:5 @deleteCharacter
  Scenario: Eliminar un personaje
    Given path "characters", 2266
    When method delete
    Then status 204
    * print response

  @id:6 @getCharacterByIdNotExist
  Scenario Outline: Consultar personaje por id no existente
    Given path "characters", <id>
    When method get
    Then status 404
    * print response
    Examples:
      | id |
      | 9990  |
      | 9980  |
      | 9970  |

  @id:7 @createCharacterAlreadyExist
  Scenario: Crear un nuevo personaje con nombre duplicado
    Given path "characters"
    And request { "name": "Iron Marck", "alterego": "Marco Jativa", "description": "Genius billionaire", "powers": ["Armor", "Flight"] }
    When method post
    Then status 400
    * print response

  @id:8 @createCharacterRequiredFields
  Scenario: Crear un nuevo personaje con datos incompletos
    Given path "characters"
    And request { "name": "", "alterego": "", "description": "", "powers": ["Armor", "Flight"] }
    When method post
    Then status 400
    * print response

  @id:9 @updateCharacterNotExist
  Scenario: Actualizar un personaje no existente
    Given path "characters", 9990
    And request { "name": "Iron Marck10", "alterego": "Marco Jativa", "description": "Genius Multi billionaire", "powers": ["Armor", "Flight"] }
    When method put
    Then status 404
    * print response

  @id:10 @deleteCharacterNotExist
  Scenario: Eliminar un personaje no existente
    Given path "characters", 9990
    When method delete
    Then status 404
    * print response