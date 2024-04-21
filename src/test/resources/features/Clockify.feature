@TP
Feature: Sample

  Background:
    And header Content-Type = application/json
    And header Accept = */*
    And header x-api-key = M2ViNWIxYTgtNjhiMS00YzcxLTgyZDQtN2RmYzU5OWZjYzcx

  @ListarWorkSpace
    Scenario:Listar los espacios de trabajo
    Given base url env.base_url_clockify
    And endpoint /v1/workspaces
    When execute method GET
    Then the status code should be 200
    * define idWorkspace = $.[0].id

    @ListarClientes
      Scenario: Obtener clientes de un espacio de trabajo
      Given call Clockify.feature@ListarWorkSpace
      And base url env.base_url_clockify
      And endpoint /v1/workspaces/{{idWorkspace}}/clients
      When execute method GET
      Then the status code should be 200

  @AddClientToWorkSpace
  Scenario Outline: Agregar Clientes a un espacio de trabajo
    Given call Clockify.feature@ListarWorkSpace
    And base url env.base_url_clockify
    And endpoint /v1/workspaces/{{idWorkspace}}/clients
    And body addClient.json
    When execute method POST
    Then the status code should be 201
    And response should be email = <email>
    Examples:
      | email             |
      | emai1l24@prueba.com |


    @AñadirProyecto
      Scenario: Añadir Proyecto a un workspace
      Given call Clockify.feature@ListarWorkSpace
      And base url env.base_url_clockify
      And endpoint /v1/workspaces/{{idWorkspace}}/projects
      And body addProject.json
      When execute method POST
      Then the status code should be 201

  @ListarProyectos
  Scenario: Listar Proyecto
    Given call Clockify.feature@ListarWorkSpace
    And base url env.base_url_clockify
    And endpoint /v1/workspaces/{{idWorkspace}}/projects
    When execute method GET
    Then the status code should be 200
    * define projectId = $[0].id









