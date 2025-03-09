# Recipe Manager Documentation

## Acknowledgement
We would like to acknowledge the following technologies and tools that made this project possible:
- Flask framework for providing a robust web application foundation
- Supabase for reliable and scalable database services
- Bootstrap for modern UI components
- Python community for excellent packages and documentation

## Abstract
The Recipe Manager is a modern web application built with Flask and Supabase that enables users to manage and share cooking recipes. It provides a user-friendly interface for browsing, searching, and reviewing recipes, with features including detailed recipe information, ingredient-based search, and user reviews.

## Introduction
The Recipe Manager project aims to simplify recipe management and sharing through a web-based platform. It combines the power of Flask's backend capabilities with Supabase's reliable data storage to create a seamless recipe management experience. The application serves as both a personal recipe collection and a community platform where users can share and review recipes.

## Software and Hardware Requirements

### Software Requirements:
- Python 3.x
- Flask web framework
- Supabase account and client
- Web browser (Chrome, Firefox, Safari, or Edge)
- Git for version control
- Text editor or IDE
- Virtual environment tool (venv)

### Hardware Requirements:
- Computer with internet connection
- Minimum 4GB RAM
- 1GB free disk space
- Modern web browser support
- Network connection for API calls

## Why Python?
Python was chosen as the primary programming language for this project for several reasons:
1. **Readability**: Python's clean syntax makes the code easy to read and maintain
2. **Rich Ecosystem**: Extensive library support, especially Flask for web development
3. **Cross-platform**: Works consistently across different operating systems
4. **Community Support**: Large community and excellent documentation
5. **Integration Capabilities**: Easy integration with various databases and APIs
6. **Rapid Development**: Enables quick prototyping and development cycles

## Explanation of if statements and loops

### If Statements
The application uses conditional statements in several key areas:
```python
# Example from search route
if category:
    search_query = search_query.eq('category', category)
if query:
    search_query = search_query.ilike('ingredients', f'%{query}%')
```

### Loops
Loops are used throughout the application, particularly in templates:
```python
# Example from templates
{% for recipe in recipes %}
    # Display recipe information
{% endfor %}
```

## Demo
The application can be demonstrated through the following steps:
1. Start the server: `python app.py`
2. Access homepage: `http://localhost:5000`
3. Browse available recipes
4. Search for recipes by ingredients
5. View detailed recipe information
6. Add reviews and ratings

## Source Code
Key components of the source code:

### Main Application (app.py)
- Flask application setup
- Route definitions
- Database interactions
- Error handling

### Database Schema (schema.sql)
- Recipe table structure
- Reviews table structure
- Relationships and constraints

### Templates
- Base template layout
- Recipe listing pages
- Detail views
- Search results display

## All Routes

| Route | Method | Description |
|-------|--------|-------------|
| `/` | GET | Home page displaying recipe list |
| `/recipe/<recipe_id>` | GET | Detailed view of specific recipe |
| `/search` | GET | Search recipes by query/category |
| `/review/<recipe_id>` | POST | Add review to recipe |

## Output
The application produces various outputs:

### Recipe Listings
- Title and description
- Cooking time and category
- Average rating

### Recipe Details
- Complete ingredient list
- Step-by-step instructions
- User reviews and ratings

### Search Results
- Filtered recipe listings
- Category-based grouping
- Ingredient matches

## Bibliography
1. Flask Documentation: https://flask.palletsprojects.com/
2. Supabase Documentation: https://supabase.com/docs
3. Bootstrap Documentation: https://getbootstrap.com/docs
4. Python Documentation: https://docs.python.org/
5. Git Documentation: https://git-scm.com/doc