# Rails Engine

### Introduction
This project is a Rails API app that provides data in json format related to an ecommerce marketplace site and responds to different queries and requests.

The Rails Engine project is part of the back end engineering curriculum at the Turing School for Software and Design. Information related to this project can be found here: http://backend.turing.io/module3/projects/rails_engine

### Tech Stack 
Ruby 2.4.1  
Rails 5.2.1  
RSpec  
Active Model Serializers  

### Setup
- You can run this app on your machine by following the instructions below:   
  `git clone git@github.com:clairebvs/rails_engine.git`
  
- Navigate to that folder and run:  
  `$ bundle install` and `$ bundle update`
  
- To create and seed database:  
  `$ rake db:{create,migrate}`
  `$ rake import:all`
  
- If you would like to run the test suite:  
  `$ rspec`
  
- Finally you can take a look at our app content by running:  
  `$ rails s`  
  `Open your browser to localhost:3000`
  
### Database Schema 

<img width="1051" alt="Screen Shot 2018-08-14 at 12 52 48 PM" src="https://user-images.githubusercontent.com/34726107/56533262-92e8ea80-6514-11e9-9c4c-1ccb324d015a.png">  

### Endpoints 

#### Customer Endpoints 
`http://localhost:3000/api/v1/customers` 

~~~~
[
  {
    id: 1,
    first_name: "Joey",
    last_name: "Ondricka"
  },
  {
    id: 2,
    first_name: "Cecelia",
    last_name: "Osinski"
  }
]
~~~~

#### Invoice Endpoints 
`http://localhost:3000/api/v1/invoices`  

  ~~~~
  [  
    {  
      id: 1,  
      customer_id: 1,  
      merchant_id: 26,  
      status: "shipped"
    },  
    {  
      id: 2,  
      customer_id: 1,  
      merchant_id: 75,  
      status: "shipped"  
    }
  ]
~~~~  

#### InvoiceItem Endpoints 
`http://localhost:3000/api/v1/invoice_items`

~~~~ 
[
  {
    id: 1,
    invoice_id: 1,
    item_id: 539,
    unit_price: "136.35",
    quantity: 5
  },
  {
    id: 2,
    invoice_id: 1,
    item_id: 528,
    unit_price: "233.24",
    quantity: 9
  }
] 
~~~~

#### Item Endpoints 
`http://localhost:3000/api/v1/items`

~~~~ 
[
  {
    id: 1,
    name: "Item Qui Esse",
    description: "Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem
                  nesciunt assumenda dicta voluptatum porro.",
    unit_price: "751.07",
    merchant_id: 1
  },
  {
    id: 2,
    name: "Item Autem Minima",
    description: "Cumque consequuntur ad. Fuga tenetur illo molestias enim aut iste. Provident quo hic aut. Aut quidem
                  voluptates dolores. Dolorem quae ab alias tempora.",
    unit_price: "670.76",
    merchant_id: 1
  }
] 
~~~~

#### Merchant Endpoints 
`http://localhost:3000/api/v1/merchants` 

~~~~
[
  {
    id: 1,
    name: "Schroeder-Jerde"
  },
  {
    id: 2,
    name: "Klein, Rempel and Jones"
  }
]
~~~~

#### Transaction Endpoints 
`http://localhost:3000/api/v1/transactions`

~~~~
[
  {
    id: 1,
    invoice_id: 1,
    credit_card_number: "4654405418249632",
    result: "success"
  },
  {
    id: 2,
    invoice_id: 2,
    credit_card_number: "4580251236515201",
    result: "success"
  }
]
~~~~

#### Single Finder Endpoints 
The request parameters include id, name, created_at and updated_at.

`http://localhost:3000/api/v1/customers/find?id=3`

~~~~
{
  id: 3,
  first_name: "Mariah",
  last_name: "Toy"
}
~~~~

#### Mutli Finder Endpoints

`http://localhost:3000/api/v1/customers/find_all?created_at=2012-03-27 14:54:10 UTC`

~~~~
[
  {
    id: 2,
    first_name: "Cecelia",
    last_name: "Osinski"
  },
  {
    id: 3,
    first_name: "Mariah",
    last_name: "Toy"
  },
  {
    id: 4,
    first_name: "Leanne",
    last_name: "Braun"
  },
  {
    id: 5,
    first_name: "Sylvester",
    last_name: "Nader"
  }
]
~~~~

#### Relationship Endpoints 

`http://localhost:3000/api/v1/items/:id/merchant` returns the associated merchant
`http://localhost:3000/api/v1/invoices/:id/invoice_items` returns a collection of associated invoice items

#### Business Intelligence Endpoints 

`http://localhost:3000/api/v1/merchants/most_revenue?quantity=x` returns the top x merchants ranked by total revenue  
`http://localhost:3000/api/v1/merchants/:id/favorite_customer` returns the customer who has conducted the most total number of successful transactions  


**Please note that this list of endpoints is non-exhaustive.** 

### Contributor 
[Claire Beauvais Lightner](https://github.com/clairebvs)
