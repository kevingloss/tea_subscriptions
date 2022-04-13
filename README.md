# Mod4 Take Home Challenge: Tea Subscriptions

## Table of Contents
- <a href="#project-description">Project Description</a>
- <a href="#getting-started">Getting Started</a>
- <a href="#setup">Setup</a>
- <a href="#testing">Testing</a>
- <a href="#endpoint-request-response-examples">Endpoint Request Response Examples</a>
- <a href="#reference">References</a>
- <a href="#author">Author</a>


## Project Description

Tea Subscriptions simulates a take home challenge that can be expected during the interview process. The project is left fairly open and provides the space to design endpoints in a fashion I thought best and explain those choices.

## Getting Started
### Versions

- Ruby 2.7.2
- Rails 5.2.7

### Setup
1. Fork and/or Clone this Repo from GitHub.
2. In your terminal use `$ git clone <ssh or https path>`
3. Change into the cloned directory using `$ cd tea_subscriptions`
4. Install the gem packages using `$ bundle install`
5. Database Migrations and Seed data can be setup by running:
```shell
$ rails rake db:{drop,create,migrate,seed}
```

## Testing
- Test using the terminal utilizing RSpec
 ```shell
 $ rspec spec/<follow directory path to test specific files>
 ```
   or test the whole suite with `$ rspec`
- Alternatively you can test in the local host
  - Start Server
```shell
$ rails s
```
   - Open Web Broswer and visit `http://localhost:3000/<insert_path>`
   - Please see below endpoints for example request/responses
- The endpoints can also be [![Run in Postman](https://run.pstmn.io/button.svg)](https://app.getpostman.com/run-collection/95b1ddea1de99d5917d3?action=collection%2Fimport)

## Endpoint Request Response Examples
### Create Customer Tea Subscription
<details>
  <summary> Request </summary>
  ```shell
   POST /api/v1/customers/1/subscriptions
   Content-Type: application/json
   Accept: application/json
   body
   {
    "order": [{"tea_id": "1", "qty": "40"}, {"tea_id": "2", "qty": "80"}, {"tea_id": "3", "qty": "16"}]
    }
  ```
</details>
<details>
  <summary> Response </summary>
  ```shell
    {
    "data": {
        "id": "10",
        "type": "subscription",
        "attributes": {
            "status": "active",
            "frequency": "monthly",
            "total_price": 719096,
            "teas": [
                {
                    "id": 1,
                    "title": "Da Hong Pao",
                    "description": "Oolong",
                    "temperature": 216.87,
                    "brew_time": 450,
                    "created_at": "2022-04-13T17:58:32.966Z",
                    "updated_at": "2022-04-13T17:58:32.966Z",
                    "price": 8367
                },
                {
                    "id": 2,
                    "title": "Kangra",
                    "description": "Green",
                    "temperature": 241.14,
                    "brew_time": 551,
                    "created_at": "2022-04-13T17:58:32.969Z",
                    "updated_at": "2022-04-13T17:58:32.969Z",
                    "price": 3023
                },
                {
                    "id": 3,
                    "title": "Darjeeling",
                    "description": "Black",
                    "temperature": 189.09,
                    "brew_time": 409,
                    "created_at": "2022-04-13T17:58:32.972Z",
                    "updated_at": "2022-04-13T17:58:32.972Z",
                    "price": 8911
                }
            ]
        }
    }
  }
  ```
</details>

### Updates a Customer Tea Subscription:
<details>
  <summary> Request </summary>
  ```shell
   PATCH /api/v1/customers/1/subscriptions/1
   Content-Type: application/json
   Accept: application/json
   body
   {
    "status": "cancelled"
   }
  ```
</details>
<details>
  <summary> Response </summary>
  ```shell
  {
    "data": {
        "id": "1",
        "type": "subscription",
        "attributes": {
            "status": "cancelled",
            "frequency": "bi_weekly",
            "total_price": 662151,
            "teas": [
                {
                    "id": 1,
                    "title": "Da Hong Pao",
                    "description": "Oolong",
                    "temperature": 216.87,
                    "brew_time": 450,
                    "created_at": "2022-04-13T17:58:32.966Z",
                    "updated_at": "2022-04-13T17:58:32.966Z",
                    "price": 8367
                },
                {
                    "id": 2,
                    "title": "Kangra",
                    "description": "Green",
                    "temperature": 241.14,
                    "brew_time": 551,
                    "created_at": "2022-04-13T17:58:32.969Z",
                    "updated_at": "2022-04-13T17:58:32.969Z",
                    "price": 3023
                }
            ]
        }
    }
  }
  ```
</details>

### Get Customers Active/Pending Subscriptions:

<details>
  <summary> Request </summary>
  ```shell
   GET /api/v1/customers/1/subscriptions
  ```
</details>
<details>
  <summary> Response </summary>
  ```shell
  {
    "data": [
        {
            "id": "1",
            "type": "subscription",
            "attributes": {
                "status": "active",
                "frequency": "bi_weekly",
                "total_price": 778845,
                "teas": [
                    {
                        "id": 1,
                        "title": "Lapsang Souchong",
                        "description": "White",
                        "temperature": 277.22,
                        "brew_time": 588,
                        "created_at": "2022-04-12T22:30:27.053Z",
                        "updated_at": "2022-04-12T22:30:27.053Z",
                        "price": 7127
                    },
                    {
                        "id": 2,
                        "title": "Vietnamese",
                        "description": "Herbal",
                        "temperature": 255.94,
                        "brew_time": 392,
                        "created_at": "2022-04-12T22:30:27.059Z",
                        "updated_at": "2022-04-12T22:30:27.059Z",
                        "price": 7322
                    }
                ]
            }
        },
        {
            "id": "2",
            "type": "subscription",
            "attributes": {
                "status": "cancelled",
                "frequency": "bi_weekly",
                "total_price": 394659,
                "teas": [
                    {
                        "id": 3,
                        "title": "Kuzuyu",
                        "description": "Herbal",
                        "temperature": 181.62,
                        "brew_time": 376,
                        "created_at": "2022-04-12T22:30:27.062Z",
                        "updated_at": "2022-04-12T22:30:27.062Z",
                        "price": 9345
                    },
                    {
                        "id": 4,
                        "title": "Kukicha",
                        "description": "Green",
                        "temperature": 286.81,
                        "brew_time": 290,
                        "created_at": "2022-04-12T22:30:27.069Z",
                        "updated_at": "2022-04-12T22:30:27.069Z",
                        "price": 6844
                    }
                ]
            }
        }
    ]
  }
  ```
</details>

## References
- [Turing Prompt](https://mod4.turing.edu/projects/take_home/take_home_be)
- [Turing Rubric](https://mod4.turing.edu/projects/take_home/take_home_rubric)
## Author
<!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->
[![All Contributors](https://img.shields.io/badge/all_contributors-1-orange.svg?style=flat-square)](#contributors-)
<!-- ALL-CONTRIBUTORS-BADGE:END -->

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tr>
    <td align="center"><a href="https://github.com/kevingloss"><img src="https://avatars.githubusercontent.com/u/83426676?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Kevin Gloss</b></sub></a><br /><a href="https://github.com/kevingloss/tea_subscriptions/commits?author=kevingloss" title="Code">💻</a> <a href="https://github.com/kevingloss/tea_subscriptions/commits?author=kevingloss" title="Documentation">📖</a> <a href="#design-kevingloss" title="Design">🎨</a> <a href="#ideas-kevingloss" title="Ideas, Planning, & Feedback">🤔</a> <a href="#infra-kevingloss" title="Infrastructure (Hosting, Build-Tools, etc)">🚇</a> <a href="https://github.com/kevingloss/tea_subscriptions/pulls?q=is%3Apr+reviewed-by%3Akevingloss" title="Reviewed Pull Requests">👀</a> <a href="#projectManagement-kevingloss" title="Project Management">📆</a></td>
  </tr>
</table>

([emoji key](https://allcontributors.org/docs/en/emoji-key))

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification.