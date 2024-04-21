@clockify
Feature: Workspaces and projects Clockify api tests



  Background:
    And header Content-Type = application/json
    And header Accept = */*
    And header x-api-key = M2ViNWIxYTgtNjhiMS00YzcxLTgyZDQtN2RmYzU5OWZjYzcx

  @ListWorkSpaces
  Scenario: List worckspaces
    Given base url env.base_url_clockify
    And endpoint /v1/workspaces
    When execute method GET
    Then the status code should be 200
    * define idWorkspace = $.[0].id

  @ListClients
  Scenario: Obtain worckspaces clients
    Given call Clockify.feature@ListWorkSpaces
    And base url env.base_url_clockify
    And endpoint /v1/workspaces/{{idWorkspace}}/clients
    When execute method GET
    Then the status code should be 200

  @AddClientToWorkSpace
  Scenario Outline: Add clients to worckspaces
    Given call Clockify.feature@ListWorkSpaces
    And base url env.base_url_clockify
    And endpoint /v1/workspaces/{{idWorkspace}}/clients
    And body addClient.json
    When execute method POST
    Then the status code should be 201
    And response should be email = <email>
    Examples:
      | email               |
      | emai1l26@prueba.com |


  @AddProject
  Scenario: Add project
    Given call Clockify.feature@ListWorkSpaces
    And base url env.base_url_clockify
    And endpoint /v1/workspaces/{{idWorkspace}}/projects
    And body addProject.json
    When execute method POST
    Then the status code should be 201

  @ListProjects
  Scenario: List projects
    Given call Clockify.feature@ListWorkSpaces
    And base url env.base_url_clockify
    And endpoint /v1/workspaces/{{idWorkspace}}/projects
    When execute method GET
    Then the status code should be 200
    * define projectId = $[0].id









