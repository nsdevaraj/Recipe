from flask import Flask, render_template, request, jsonify, redirect, url_for, flash
from supabase import create_client, Client
import os
from dotenv import load_dotenv
from datetime import datetime
import uuid

load_dotenv()

app = Flask(__name__)
app.secret_key = os.getenv('FLASK_SECRET_KEY')

# Initialize Supabase client
supabase: Client = create_client(
    os.getenv('SUPABASE_URL'),
    os.getenv('SUPABASE_KEY')
)

@app.route('/')
def home():
    try:
        # Fetch latest recipes
        response = supabase.table('recipes').select('*').execute()
        recipes = response.data
        return render_template('index.html', recipes=recipes)
    except Exception as e:
        print(f"Error fetching recipes: {e}")
        return render_template('index.html', recipes=[])

@app.route('/recipe/<recipe_id>')
def recipe_detail(recipe_id):
    try:
        # Fetch recipe details
        recipe = supabase.table('recipes').select('*').eq('id', recipe_id).single().execute()
        reviews = supabase.table('reviews').select('*').eq('recipe_id', recipe_id).execute()
        return render_template('recipe_detail.html', recipe=recipe.data, reviews=reviews.data)
    except Exception as e:
        print(f"Error fetching recipe details: {e}")
        flash('Recipe not found')
        return redirect(url_for('home'))

@app.route('/search')
def search():
    try:
        query = request.args.get('q', '')
        category = request.args.get('category', '')
        
        # Build the query
        search_query = supabase.table('recipes').select('*')
        
        if category:
            search_query = search_query.eq('category', category)
        if query:
            search_query = search_query.ilike('ingredients', f'%{query}%')
        
        results = search_query.execute()
        return render_template('search_results.html', recipes=results.data, query=query)
    except Exception as e:
        print(f"Error searching recipes: {e}")
        flash('An error occurred while searching')
        return redirect(url_for('home'))

@app.route('/review/<recipe_id>', methods=['POST'])
def add_review(recipe_id):
    try:
        rating = request.form.get('rating')
        comment = request.form.get('comment')
        
        if not rating or not comment:
            flash('Both rating and comment are required')
            return redirect(url_for('recipe_detail', recipe_id=recipe_id))
        
        # Insert review
        supabase.table('reviews').insert({
            'recipe_id': recipe_id,
            'rating': int(rating),
            'comment': comment,
            'created_at': datetime.now().isoformat()
        }).execute()
        
        flash('Review added successfully!')
        return redirect(url_for('recipe_detail', recipe_id=recipe_id))
    except Exception as e:
        print(f"Error adding review: {e}")
        flash('An error occurred while adding the review')
        return redirect(url_for('recipe_detail', recipe_id=recipe_id))

if __name__ == '__main__':
    app.run(debug=True)
