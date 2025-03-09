# Recipe Manager


python3 -m venv path/to/venv
source path/to/venv/bin/activate
python3 -m pip install -r requirements.txt

A web application for managing and sharing cooking recipes built with Flask and Supabase.

## Features

- Browse recipes with detailed information including ingredients and instructions
- Search recipes by ingredients or categories
- Leave reviews and ratings on recipes
- Modern, responsive UI with Bootstrap 5

## Setup

1. Clone the repository
2. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```

3. Set up Supabase:
   - Create a new project on [Supabase](https://supabase.com)
   - Create the following tables:
     - recipes (id, title, description, ingredients, instructions, cooking_time, category, image_url, average_rating)
     - reviews (id, recipe_id, rating, comment, created_at)

4. Configure environment variables:
   - Copy `.env.example` to `.env`
   - Update the following variables in `.env`:
     ```
     FLASK_SECRET_KEY=your-secret-key-here
     SUPABASE_URL=your-supabase-url
     SUPABASE_KEY=your-supabase-anon-key
     ```

5. Run the application:
   ```bash
   python app.py
   ```

6. Visit `http://localhost:5000` in your browser

## Database Schema

### recipes
- id: int (primary key)
- title: string
- description: text
- ingredients: json (array of strings)
- instructions: json (array of strings)
- cooking_time: int (minutes)
- category: string
- image_url: string (nullable)
- average_rating: float

### reviews
- id: int (primary key)
- recipe_id: int (foreign key to recipes.id)
- rating: int (1-5)
- comment: text
- created_at: timestamp

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a new Pull Request

graph TD
    A[User] --> B[Home Page '/']
    B --> C[Supabase 'recipes' table]
    
    A --> D[Recipe Detail '/recipe/:id']
    D --> E[Supabase 'recipes' table]
    D --> F[Supabase 'reviews' table]
    
    A --> G[Search '/search']
    G --> |Query & Category Filter| H[Supabase 'recipes' table]
    
    A --> I[Add Review '/review/:recipe_id']
    I --> |POST| J[Supabase 'reviews' table]
    
    %% Data flow for Home
    C --> |Return recipes| B
    
    %% Data flow for Recipe Detail
    E --> |Return recipe data| D
    F --> |Return reviews| D
    
    %% Data flow for Search
    H --> |Return filtered recipes| G
    
    %% Data flow for Reviews
    J --> |Redirect to| D

    %% Styling
    classDef page fill:#f9f,stroke:#333,stroke-width:2px;
    classDef database fill:#bbf,stroke:#333,stroke-width:2px;
    
    class B,D,G,I page;
    class C,E,F,H,J database;

