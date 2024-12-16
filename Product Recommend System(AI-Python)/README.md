 Electronic Product Recommendation System

 Project Overview
This project develops an Electronic Product Recommendation System using two key filtering techniques:  
- Collaborative Filtering  
- Content-Based Filtering  

The system analyzes over 1400 Amazon products with detailed attributes to generate accurate product recommendations. The dataset includes key features like:
- `product_id`, `product_name`, `category`
- `discounted_price`, `actual_price`, `discount_percentage`
- `rating`, `rating_count`, `about_product`
- `user_id`, `user_name`, `review_id`, `review_title`, `review_content`
- `img_link`, `product_link`, and other attributes.

These features provide comprehensive information for product analysis and recommendations.

---

 Dataset
The dataset used in this project was collected from the Internet and contains over 1400 products. It includes:  
- Product details such as names, categories, prices, and ratings  
- User interactions including reviews, ratings, and engagement  

This dataset enables us to apply filtering algorithms effectively to generate recommendations.

---

 Recommendation Techniques

 1. Collaborative Filtering
- Focus: Analyzes user interaction patterns (e.g., reviews, ratings, and engagement).  
- Approach: Prioritizes products that users with similar preferences interact with.  
- Example:  
  For a product like "Wayona Nylon Braided USB to Lightning Fast Charging Cable", collaborative filtering suggests similar products based on user behavior, such as:  
  - "Sounce Fast Phone Charging Cable & Data Sync USB Cable Compatible for iPhone 13, 12,11, X..."  
  - "pTron Solero TB301 3A Type-C Data and Fast Charging Cable, Made in India..."

   While effective, collaborative filtering may miss thematic similarities between products.

 2. Content-Based Filtering
- Focus: Relies on product attributes such as product name, description, category, and price.  
- Approach: Recommends products based on attribute similarity using Cosine Similarity.  
- Example:  
  Given a keyword like “Nylon Braided USB Cable”, content-based filtering identifies and suggests products with similar descriptions and categories.  

---

 Cosine Similarity
Cosine similarity is used as the core metric to measure the similarity between products or user preferences.  
- In Content-Based Filtering: Measures attribute similarity (e.g., product names and descriptions).  
- In Collaborative Filtering: Measures user interaction similarities (e.g., ratings and reviews).  

---

 System Goals
By combining collaborative filtering and content-based filtering, this system aims to:  
1. Provide personalized recommendations for users based on their preferences and actions.  
2. Optimize the shopping experience by offering accurate product suggestions.  
3. Enhance decision-making for electronic product purchases.  

---

 How It Works
1. Input a product name or keyword (e.g., "USB Cable").  
2. The system uses:  
   - Collaborative Filtering to find similar products based on user engagement.  
   - Content-Based Filtering to identify products with similar attributes.  
3. Recommendations are presented to the user.

---

 Results
- Collaborative filtering excels at identifying products based on user behavior and interaction.  
- Content-based filtering excels at recommending products with thematic similarities.  

Both techniques complement each other to ensure diverse and accurate product recommendations.

---

 Technologies Used
- Python  
- Pandas, NumPy  
- Scikit-learn  
- Cosine Similarity  

---

 Conclusion
This project demonstrates the power of collaborative and content-based filtering methods in building an effective product recommendation system. By analyzing both user interactions and product attributes, the system enhances the shopping experience by providing accurate and relevant product suggestions.

---