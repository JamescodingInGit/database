import streamlit as st
import pickle
import re
import requests

products = pickle.load(open("product_list.pkl", 'rb'))
similarity = pickle.load(open("similarity.pkl", 'rb'))
collaborative_filtering_dct = pickle.load(open("collaborative_filtering.pkl",'rb'))

products_list=products['product_name'].values

st.title("Product-Recommend-System")
image_path = "title.jpg"

st.image(image_path, caption="", width=180)
recommendation_method = st.sidebar.radio("Choose Recommendation Method:", ["Content-Based Filtering", "Collaborative Filtering"])


def content_Based_Filtering_Recommend(product):
    index = products[products['product_name'].str.contains(r'\b{}\b'.format(re.escape(product)), case=False, regex=True)]
    seen_products = set()
    prod_name = []
    prod_picture = []
    prod_describe = []
    prod_link = []
    prod_rating = []
    prod_price = []

    for index, row in index.iterrows():
        distance = sorted(list(enumerate(similarity[index])), reverse=True, key=lambda vector: vector[1])
        for i in distance[1:6]:
            product_name = products.iloc[i[0]].product_name
            if product_name not in seen_products:
                prod_name.append(products.iloc[i[0]].product_name)
                prod_describe.append(products.iloc[i[0]].about_product)
                prod_link.append(products.iloc[i[0]].product_link)
                prod_picture.append(products.iloc[i[0]].img_link)
                prod_rating.append(products.iloc[i[0]].rating)
                prod_price.append(products.iloc[i[0]].actual_price)
                seen_products.add(product_name)
    return prod_name, prod_picture, prod_describe, prod_link, prod_rating, prod_price

def collaborative_filtering_recommend(product_name):
    similar_products = collaborative_filtering_dct.get(product_name, [])

    prod_names = []
    prod_pictures = []
    prod_descriptions = []
    prod_links = []
    prod_ratings = []
    prod_prices = []

    for prod_idx, similarity_score in similar_products:
        # Retrieve product information from the DataFrame using the index
        prod_data = products.iloc[prod_idx]
        prod_names.append(prod_data['product_name'])
        prod_pictures.append(prod_data['img_link'])
        prod_descriptions.append(prod_data['about_product'])
        prod_links.append(prod_data['product_link'])
        prod_ratings.append(prod_data['rating'])
        prod_prices.append(prod_data['actual_price'])

        # Sort products by ratings in descending order
        sorted_indices = sorted(range(len(prod_ratings)), key=lambda k: prod_ratings[k], reverse=True)
        prod_names = [prod_names[i] for i in sorted_indices]
        prod_pictures = [prod_pictures[i] for i in sorted_indices]
        prod_descriptions = [prod_descriptions[i] for i in sorted_indices]
        prod_links = [prod_links[i] for i in sorted_indices]
        prod_ratings = [prod_ratings[i] for i in sorted_indices]
        prod_prices = [prod_prices[i] for i in sorted_indices]

    return prod_names, prod_pictures, prod_descriptions, prod_links, prod_ratings, prod_prices

if recommendation_method == "Content-Based Filtering":
    user_input = st.text_input("Enter your product", "")
    if st.button("Show Recommend"):
        st.write("**Recommended Products:**")
        prod_names, prod_picture, prod_describe, prod_link, prod_rating, prod_price = content_Based_Filtering_Recommend(user_input)
        
        for i in range(5):
            col1, col2 = st.columns([2, 4])
            with col1:
                st.markdown(f'<img src="{prod_picture[i]}" alt="Product {i + 1}" style="width:200px; height:200px;">', unsafe_allow_html=True)
            with col2:
                st.markdown(f"**Product {i + 1} : {prod_names[i]}**")
                st.markdown(f"Rating : {prod_rating[i]} Price : {prod_price[i]}")
                st.text_area(f"Description for Product {i+1}", prod_describe[i], height=100, disabled=True)
                st.markdown(f"[Amazon Link for Product {i+1}]({prod_link[i]})")
                st.markdown("---")
                st.markdown("<br>", unsafe_allow_html=True)

if recommendation_method == "Collaborative Filtering":
    selectvalue=st.selectbox("Select product from dropdown", products_list)
    if st.button("Show Recommend"):
        
        prod_names, prod_pictures, prod_descriptions, prod_links, prod_ratings, prod_prices = collaborative_filtering_recommend(selectvalue)
        st.write("**Recommended Products:**")

        for i in range(5):
            col1, col2 = st.columns([2, 4])
            with col1:
                st.markdown(f'<img src="{prod_pictures[i]}" alt="Product {i + 1}" style="width:200px; height:200px;">', unsafe_allow_html=True)
            with col2:
                st.markdown(f"**Product {i + 1} : {prod_names[i]}**")
                st.markdown(f"Rating : {prod_ratings[i]} Price : {prod_prices[i]}")
                st.text_area(f"Description for Product {i+1}", prod_descriptions[i], height=100, disabled=True)
                st.markdown(f"[Amazon Link for Product {i+1}]({prod_links[i]})")
                st.markdown("---")
                st.markdown("<br>", unsafe_allow_html=True)