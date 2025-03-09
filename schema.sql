-- Enable the UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Create recipes table
CREATE TABLE IF NOT EXISTS public.recipes (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    title VARCHAR(255) NOT NULL,
    description TEXT,
    ingredients JSONB NOT NULL,
    instructions JSONB NOT NULL,
    cooking_time INTEGER NOT NULL,
    category VARCHAR(50) NOT NULL,
    image_url TEXT,
    average_rating DECIMAL(3,2) DEFAULT 0.0,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create reviews table
CREATE TABLE IF NOT EXISTS public.reviews (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    recipe_id UUID REFERENCES public.recipes(id) ON DELETE CASCADE,
    rating INTEGER CHECK (rating >= 1 AND rating <= 5),
    comment TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create index for faster searches
CREATE INDEX IF NOT EXISTS idx_recipes_category ON public.recipes(category);
CREATE INDEX IF NOT EXISTS idx_reviews_recipe_id ON public.reviews(recipe_id);

-- Enable Row Level Security (RLS)
ALTER TABLE public.recipes ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.reviews ENABLE ROW LEVEL SECURITY;

-- Create policies
CREATE POLICY "Enable read access for all users" ON public.recipes
    FOR SELECT USING (true);

CREATE POLICY "Enable read access for all users" ON public.reviews
    FOR SELECT USING (true);

-- Insert some sample recipes
INSERT INTO public.recipes (title, description, ingredients, instructions, cooking_time, category, image_url)
VALUES 
(
    'Classic Spaghetti Carbonara',
    'A traditional Italian pasta dish with eggs, cheese, pancetta, and black pepper',
    '["400g spaghetti", "200g pancetta", "4 large eggs", "100g Pecorino Romano", "100g Parmigiano-Reggiano", "Black pepper", "Salt"]'::jsonb,
    '["Bring a large pot of salted water to boil", "Cook spaghetti according to package instructions", "Meanwhile, cook pancetta until crispy", "Beat eggs and mix with grated cheese", "Combine hot pasta with egg mixture and pancetta", "Season with black pepper"]'::jsonb,
    30,
    'Main Course',
    'https://images.unsplash.com/photo-1612874742237-6526221588e3'
),
(
    'Chocolate Chip Cookies',
    'Classic homemade cookies that are crispy on the outside and chewy in the middle',
    '["2 1/4 cups flour", "1 cup butter", "3/4 cup sugar", "3/4 cup brown sugar", "2 eggs", "1 tsp vanilla", "1 tsp baking soda", "2 cups chocolate chips"]'::jsonb,
    '["Preheat oven to 375°F", "Cream butter and sugars", "Beat in eggs and vanilla", "Mix in dry ingredients", "Stir in chocolate chips", "Bake for 10 minutes"]'::jsonb,
    45,
    'Dessert',
    'https://images.unsplash.com/photo-1499636136210-6f4ee915583e'
);
