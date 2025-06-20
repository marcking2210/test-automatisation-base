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
      | 443  |
      | 444  |
      | 445  |

  @id:3 @createCharacter
  Scenario: Crear un nuevo personaje
    Given path "characters"
    And request { "name": "Iron Marck14", "alterego": "Marco Jativa", "description": "Genius billionaire", "powers": ["Armor", "Flight"] }
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
    Given path "characters", 644
    When method delete
    Then status 204
    * print response

  @id:6 @getCharacterByIdNotFound
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